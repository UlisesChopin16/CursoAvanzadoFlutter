import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/pages/home_page/home_page.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/pages/notifications_page/notifications_page.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/pages/search_page/search_page.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/pages/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_view_model.freezed.dart';
part 'main_view_model.g.dart';

@freezed
class MainModel with _$MainModel {
  const factory MainModel({
    @Default(0) int currentIndex,
    @Default([]) List<Widget> pages,
    @Default(StringsManager.home) String title,
  }) = _MainModel;
}

@riverpod
class MainViewModel extends _$MainViewModel implements MainViewModelInputs {

  static const List<Widget> pages = [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage(),
  ];

  @override
  MainModel build() {
    return const MainModel(
      pages: pages,
    );
  }

  @override
  void changeIndex(int index) {
    state = state.copyWith(
      currentIndex: index,
      title: StringsManager.titles[index],
    );
  }

  @override
  void onTap(int index) {
    changeIndex(index);
  }
}

abstract class MainViewModelInputs {
  void changeIndex(int index);
  void onTap(int index);
}
