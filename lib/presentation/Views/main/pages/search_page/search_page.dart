import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: const Text(StringsManager.search).tr(),
      ),
    );
  }
}
