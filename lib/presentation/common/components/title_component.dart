import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/font_manager.dart';
import 'package:curso_avanzado_flutter/constants/styles_manager.dart';
import 'package:flutter/material.dart';

class TitleBoldComponent extends StatelessWidget {
  final String text;
  final Color color;
  const TitleBoldComponent({super.key, this.color = ColorManager.primary, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getBoldStyle(
        fontSize: FontSize.s18,
        color: color,
      ),
    );
  }
}

class TitleRegularComponent extends StatelessWidget {
  final String text;
  final Color color;
  const TitleRegularComponent({super.key, this.color = ColorManager.primary, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getRegularStyle(
        fontSize: FontSize.s16,
        color: color,
      ),
    );
  }
}
