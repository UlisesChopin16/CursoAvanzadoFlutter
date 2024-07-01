import 'package:curso_avanzado_flutter/app/app_preferences.dart';
import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:curso_avanzado_flutter/constants/language_manager.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_view_model.freezed.dart';
part 'settings_view_model.g.dart';

@freezed
class SettingsPageModel with _$SettingsPageModel {
  const factory SettingsPageModel({
    @Default(0) int currentIndex,
  }) = _SettingsPageModel;
}

@riverpod
class SettingsViewModel extends _$SettingsViewModel implements SettingsViewModelInputs {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  SettingsPageModel build() {
    return const SettingsPageModel();
  }

  @override
  Future<void> setLanguage(LanguageType type) async {
    state = state.copyWith(
      currentIndex: 1,
    );
    await _appPreferences.setLanguageChanged(type);
    state = state.copyWith(
      currentIndex: 0,
    );
  }
}

abstract class SettingsViewModelInputs {
  Future<void> setLanguage(LanguageType type);
}
