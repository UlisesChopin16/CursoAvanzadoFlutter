import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedImageComponent extends StatelessWidget {
  final String animationName;
  const AnimatedImageComponent({
    super.key,
    required this.animationName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }
}
