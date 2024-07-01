import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/main_view_model.dart/main_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationComponent extends ConsumerWidget {
  const BottomNavigationComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (currentIndex,) = ref.watch(
      mainViewModelProvider.select(
        (value) => (value.currentIndex,),
      ),
    );
    return Container(
      decoration: const BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.lightGrey,
            spreadRadius: AppSize.s1,
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: ColorManager.white,
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: ref.read(mainViewModelProvider.notifier).onTap,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: StringsManager.home.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: StringsManager.search.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
            label: StringsManager.notifications.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: StringsManager.settings.tr(),
          ),
        ],
      ),
    );
  }
}
