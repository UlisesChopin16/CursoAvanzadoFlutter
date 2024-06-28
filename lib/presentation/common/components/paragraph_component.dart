import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/font_manager.dart';
import 'package:curso_avanzado_flutter/constants/styles_manager.dart';
import 'package:flutter/material.dart';

class ParagraphComponent extends StatelessWidget {
  final String text;
  final Color color;

  const ParagraphComponent({super.key, required this.text, this.color = ColorManager.grey1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: getMediumStyle(
        fontSize: FontSize.s14,
        color: color,
      ),
    );
  }
}