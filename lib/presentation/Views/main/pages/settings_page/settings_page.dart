import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/language_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/login/login_view_model/login_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/pages/settings_page/settings_view_model/settings_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/routes/routes_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'components/widgets.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  void onTapChangeLanguage(BuildContext context) async {
    showPopUpLanguage(context);
  }

  void onTapContactUs(BuildContext context) {}
  void onTapInviteFriends(BuildContext context) {}
  void onTapLogout(BuildContext context) async {
    await ref.read(loginViewModelProvider.notifier).logoutL();
    if (!context.mounted) return;
    context.pushReplacementNamed(Routes.loginRouteName);
  }

  @override
  Widget build(BuildContext context) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: ListView(
          children: [
            const Gap(20),
            ItemSettingComponent(
              title: StringsManager.changeLanguage,
              assetName: ImageAssets.changeLangIc,
              onTap: onTapChangeLanguage,
            ),
            ItemSettingComponent(
              title: StringsManager.contactUs,
              assetName: ImageAssets.contactUsIc,
              onTap: onTapContactUs,
            ),
            ItemSettingComponent(
              title: StringsManager.inviteYourFriends,
              assetName: ImageAssets.inviteFriendsIc,
              onTap: onTapInviteFriends,
            ),
            ItemSettingComponent(
              title: StringsManager.logout,
              assetName: ImageAssets.logoutIc,
              onTap: onTapLogout,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showPopUpLanguage(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          backgroundColor: ColorManager.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ItemSettingComponent(
                title: StringsManager.english.tr(),
                assetName: ImageAssets.changeLangIc,
                onTap: (context) async => await onTapItem(LanguageType.ENGLISH, context),
              ),
              // español
              ItemSettingComponent(
                title: StringsManager.spanish.tr(),
                assetName: ImageAssets.changeLangIc,
                onTap: (context) async => await onTapItem(LanguageType.SPANISH, context),
              ),
              // arabic
              ItemSettingComponent(
                title: StringsManager.arabic.tr(),
                assetName: ImageAssets.changeLangIc,
                onTap: (context) async => onTapItem(LanguageType.ARABIC, context),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> onTapItem(LanguageType languageType, BuildContext context) async {
    await ref.read(settingsViewModelProvider.notifier).setLanguage(languageType);
    if (!context.mounted) return;
    Phoenix.rebirth(context);
  }
}
