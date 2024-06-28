import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/common/components/title_component.dart';
import 'package:flutter/material.dart';

class TextSectionComponent extends StatelessWidget {
  final String text;

  const TextSectionComponent({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p30,
        right: AppPadding.p12,
        bottom: AppPadding.p2,
      ),
      child: TitleBoldComponent(
        text: text,
      ),
    );
  }
}
