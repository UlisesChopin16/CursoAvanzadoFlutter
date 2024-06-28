import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/common/components/paragraph_component.dart';
import 'package:flutter/material.dart';

class ParagraphSectionComponent extends StatelessWidget {
  final String text;
  const ParagraphSectionComponent({super.key, required this.text,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30),
      child: ParagraphComponent(text: text),
    );
  }
}