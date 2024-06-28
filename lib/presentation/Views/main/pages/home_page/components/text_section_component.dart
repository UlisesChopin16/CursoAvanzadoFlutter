import 'package:curso_avanzado_flutter/constants/values_manager.dart';
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
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p2,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
