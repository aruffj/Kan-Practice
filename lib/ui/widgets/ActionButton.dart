import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class ActionButton extends StatelessWidget {
  /// Label to put on the button
  final String label;
  /// Color of the button. Defaults to green
  final Color color;
  /// Color of the label button. Defaults to green
  final Color textColor;
  /// Horizontal padding for the button. Defaults to 32.
  final double horizontal;
  /// Vertical padding for the button. Defaults to 8.
  final double vertical;
  final Function() onTap;
  const ActionButton({required this.label, this.color = Colors.green, this.textColor = Colors.white,
    this.horizontal = Margins.margin32, this.vertical = Margins.margin8, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CustomSizes.defaultSizeActionButton,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomRadius.radius16),
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(CustomRadius.radius16),
          child: Container(
            height: CustomSizes.defaultSizeActionButton,
            alignment: Alignment.center,
            margin: EdgeInsets.all(Margins.margin16),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(label, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: FontSizes.fontSize16, fontWeight: FontWeight.bold, color: textColor)
              ),
            )
          ),
        ),
      ),
    );
  }
}
