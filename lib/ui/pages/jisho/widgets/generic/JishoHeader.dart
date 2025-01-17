import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class JishoHeader extends StatelessWidget {
  final String header;
  final bool guideline;
  const JishoHeader({required this.header, this.guideline = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: guideline,
          child: Padding(
            padding: EdgeInsets.only(right: Margins.margin8),
            child: Icon(Icons.subdirectory_arrow_right_rounded),
          ),
        ),
        Text(header, style: TextStyle(
          fontSize: FontSizes.fontSize20,
          fontWeight: FontWeight.bold
        ))
      ],
    );
  }
}
