import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/components/bottom_navigation_component.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/main_view_model.dart/main_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/common/components/title_component.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class MainView extends HookConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (
      currentIndex,
      pages,
      title,
    ) = ref.watch(
      mainViewModelProvider.select(
        (value) => (
          value.currentIndex,
          value.pages,
          value.title,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: TitleBoldComponent(
          text: title,
          color: ColorManager.white,
        ),
      ),
      body: Center(
          child: LazyLoadIndexedStack(
        index: currentIndex,
        children: pages,
      )),
      bottomNavigationBar: const BottomNavigationComponent(),
    );
  }
}
