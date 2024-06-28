import 'package:curso_avanzado_flutter/presentation/Views/main/components/bottom_navigation_component.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/main_view_model.dart/main_view_model.dart';
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
        title: Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
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
