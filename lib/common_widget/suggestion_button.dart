import 'package:flutter/material.dart';
import 'package:research_proj/common/color_extension.dart';

class SuggestionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SuggestionButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Tcolor.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Tcolor.primary.withOpacity(0.5)),
          ),
          child: Text(
            text,
            style: TextStyle(color: Tcolor.primaryText),
          ),
        ),
      ),
    );
  }
}
