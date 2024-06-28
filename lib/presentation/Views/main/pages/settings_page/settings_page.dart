import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    return const Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: Text('SettingsPage'),
      ),
    );
  }
}