import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'components/widgets.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  static void onTap() {
    print('SettingsPage');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: ListView(
          children: const [
            Gap(20),
            ItemSettingComponent(
              title: StringsManager.changeLanguage,
              assetName: ImageAssets.changeLangIc,
              onTap: onTap,
            ),
            ItemSettingComponent(
              title: StringsManager.contactUs,
              assetName: ImageAssets.contactUsIc,
              onTap: onTap,
            ),
            ItemSettingComponent(
              title: StringsManager.inviteYourFriends,
              assetName: ImageAssets.inviteFriendsIc,
              onTap: onTap,
            ),
            ItemSettingComponent(
              title: StringsManager.logout,
              assetName: ImageAssets.logoutIc,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
