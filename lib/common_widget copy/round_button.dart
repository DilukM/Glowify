import 'package:flutter/material.dart';
import 'package:research_proj/common/color_extension.dart';

enum RoundButtonType { bgPrimary, textPrimary }

class RoundButton extends StatelessWidget {
  final String Title;
  final RoundButtonType type;
  final VoidCallback onPressed;

  const RoundButton({
    Key? key,
    required this.Title,
    required this.onPressed,
    this.type = RoundButtonType.bgPrimary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: Container(
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border:
                type == RoundButtonType.bgPrimary
                    ? null
                    : Border.all(color: Tcolor.primary, width: 1),
            color:
                type == RoundButtonType.bgPrimary
                    ? Tcolor.primary
                    : Tcolor.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            Title,
            style: TextStyle(
              color:
                  type == RoundButtonType.bgPrimary
                      ? Tcolor.white
                      : Tcolor.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
