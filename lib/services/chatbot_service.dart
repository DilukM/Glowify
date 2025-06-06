import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ChatbotService {
  late Interpreter _interpreter;
  Map<String, dynamic> _intentsData = {};
  Map<String, List<String>> _responses = {};
  List<String> _tags = [];
  Map<String, int> _wordIndex = {};  // For tokenizer functionality
  List<String> _labelEncoder = [];
  
  final int vocabSize = 1000;
  final int maxLen = 20;
  final String oovToken = "<OOV>";

  bool _isInitialized = false;
  // Initialize the model and load all required files
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // 1. Load the TFLite model using direct asset path
      _interpreter = await Interpreter.fromAsset('assets/chatbot_model.tflite');

      // 2. Load the intents JSON
      final jsonString = await rootBundle.loadString('assets/intents.json');
      _intentsData = jsonDecode(jsonString);

      // 3. Extract all tags and responses for future use
      _responses = {};
      Set<String> tagSet = {};

      for (var intent in _intentsData['intents']) {
        final tag = intent['tag'];
        tagSet.add(tag);
        _responses[tag] = List<String>.from(intent['responses']);
      }

      // Convert to a sorted list for consistent indexing
      _tags = tagSet.toList();
      _tags.sort();
      
      // Create word index for tokenization
      _createWordIndex();

      print('Loaded ${_tags.length} intent tags');
      print('Model input shape: ${_interpreter.getInputTensor(0).shape}');
      print('Model output shape: ${_interpreter.getOutputTensor(0).shape}');

      _isInitialized = true;
    } catch (e) {
      print('Error initializing chatbot: $e');
      throw Exception('Failed to initialize chatbot: $e');
    }
  }
  // Process input text and get prediction
  Future<Map<String, dynamic>> processMessage(String text) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      // Try using the TFLite model first
      try {
        // 1. Tokenize and preprocess input
        final preprocessed = _preprocessText(text);
        
        // 2. Run inference with TFLite model
        final result = _runInference(preprocessed);
        final tagIndex = _getTopPredictionIndex(result);
        
        // Check if we have a strong enough prediction
        if (result[0][tagIndex] > 0.5 && tagIndex < _tags.length) {
          final tag = _tags[tagIndex];
          final possibleResponses = _responses[tag]!;
          final response = possibleResponses[Random().nextInt(possibleResponses.length)];
          
          print('TFLite prediction: $tag with confidence ${result[0][tagIndex]}');
          return {
            'tag': tag,
            'response': response,
            'confidence': result[0][tagIndex],
          };
        } else {
          print('TFLite prediction too weak: ${result[0][tagIndex]} for tag index $tagIndex');
        }
      } catch (e) {
        print('Error in TFLite inference: $e');
        // Fall back to pattern matching if TFLite fails
      }

      // Fallback to pattern matching
      final userText = text.toLowerCase().trim();
      double highestMatch = 0.0;
      String bestMatchTag = '';
      String bestResponse = '';

      print('Falling back to pattern matching for: $userText');
      
      // Try to find a matching pattern using improved matching algorithm
      for (var intent in _intentsData['intents']) {
        final tag = intent['tag'];
        final patterns = List<String>.from(intent['patterns']);

        for (var pattern in patterns) {
          final patternLower = pattern.toLowerCase().trim();

          // Calculate similarity between input and pattern
          double similarity = _calculateTextSimilarity(userText, patternLower);

          // Debug output for top matches only
          if (similarity > 0.3) {
            print('Pattern: "$patternLower", Similarity: $similarity');
          }

          // If we have a better match, update our best match
          if (similarity > highestMatch) {
            highestMatch = similarity;
            bestMatchTag = tag;

            // Get a random response from the matched intent
            final List<String> possibleResponses = _responses[tag]!;
            bestResponse =
                possibleResponses[Random().nextInt(possibleResponses.length)];
          }
        }
      }

      // If we have a decent match, return it
      if (highestMatch > 0.4) {
        print('Pattern matching found: $bestMatchTag with confidence $highestMatch');
        return {
          'tag': bestMatchTag,
          'response': bestResponse,
          'confidence': highestMatch,
        };
      }

      // If no match is found, return a default message with suggestions
      return {
        'tag': 'unknown',
        'response':
            'I\'m not sure how to respond to that. You might want to ask me about:\n\n'
            '- Dry skin treatment\n'
            '- Acne problems\n'
            '- Oily skin care\n'
            '- Skincare routines\n'
            '- Product recommendations',
        'confidence': 0.3,
      };
    } catch (e) {
      print('Error processing message: $e');
      return {
        'tag': 'error',
        'response': 'Sorry, I encountered an error processing your message.',
        'confidence': 0.0,
      };
    }
  }

  // Create a word index for tokenization purposes
  void _createWordIndex() {
    Set<String> wordSet = {};
    
    // Collect all unique words from all patterns
    for (var intent in _intentsData['intents']) {
      for (var pattern in intent['patterns']) {
        final words = pattern.toLowerCase().split(RegExp(r'\s+'));
        wordSet.addAll(words);
      }
    }

    // Create word index mapping (similar to tokenizer.word_index in Python)
    int index = 1; // Start from 1 (0 is reserved for padding)
    _wordIndex = {};
    for (var word in wordSet) {
      if (word.isNotEmpty && index < vocabSize) {
        _wordIndex[word] = index++;
      }
    }
    
    print('Created word index with ${_wordIndex.length} words');
  }

  // Preprocess text for model input (similar to tokenization and padding)
  List<List<int>> _preprocessText(String text) {
    final words = text.toLowerCase().trim().split(RegExp(r'\s+'));
    final List<int> sequence = [];
    
    // Convert words to indices (tokenization)
    for (final word in words) {
      if (_wordIndex.containsKey(word)) {
        sequence.add(_wordIndex[word]!);
      } else {
        // Out of vocabulary token
        sequence.add(vocabSize - 1);
      }
    }
    
    // Pad sequence (similar to pad_sequences in Python)
    final List<int> paddedSequence = List<int>.filled(maxLen, 0);
    for (int i = 0; i < sequence.length && i < maxLen; i++) {
      paddedSequence[i] = sequence[i];
    }
    
    return [paddedSequence];
  }

  // Calculate text similarity between two strings
  double _calculateTextSimilarity(String text1, String text2) {
    if (text1.isEmpty || text2.isEmpty) return 0.0;

    // Direct containment (weighted higher)
    if (text1.contains(text2) || text2.contains(text1)) {
      return 0.8;
    }

    // Word-level matching
    final words1 = text1.split(' ');
    final words2 = text2.split(' ');

    int matchingWords = 0;

    // Count matching words
    for (var word in words1) {
      if (word.length > 2 && words2.contains(word)) {
        matchingWords++;
      }
    }

    // Calculate similarity based on matching words ratio
    double wordMatchRatio =
        words1.isNotEmpty ? matchingWords / words1.length : 0;

    // Check for keyword matching (skincare-related terms)
    final List<String> keywords = [
      'skin',
      'dry',
      'oily',
      'acne',
      'routine',
      'moisturizer',
      'hydrate',
      'treatment',
      'cleanser',
      'serum',
      'sunscreen',
      'exfoliate',
      'face',
      'pores',
      'wrinkles',
      'aging'
    ];

    int keywordMatches = 0;
    for (var keyword in keywords) {
      if (text1.contains(keyword) && text2.contains(keyword)) {
        keywordMatches++;
      }
    }

    double keywordFactor = keywordMatches > 0 ? 0.3 : 0.0;

    // Calculate final similarity score
    return 0.7 * wordMatchRatio + keywordFactor;
  }
  // Run TFLite inference
  List<List<double>> _runInference(List<List<int>> input) {
    // Prepare output tensor
    final outputShape = _interpreter.getOutputTensor(0).shape;
    final outputSize = outputShape[1];
    var output = List.filled(1, List<double>.filled(outputSize, 0));
    
    // Run inference
    _interpreter.run(input, output);
    return output;
  }
  
  // Get index with highest prediction value
  int _getTopPredictionIndex(List<List<double>> predictions) {
    int maxIndex = 0;
    double maxValue = predictions[0][0];
    
    for (int i = 1; i < predictions[0].length; i++) {
      if (predictions[0][i] > maxValue) {
        maxValue = predictions[0][i];
        maxIndex = i;
      }
    }
    
    return maxIndex;
  }

  // Clean up resources
  void dispose() {
    _interpreter.close();
  }
}
