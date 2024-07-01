import 'package:curso_avanzado_flutter/app/app_preferences.dart';
import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/pages/home_page/home_view_model/home_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/hooks/use_launch_effect.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/wigets.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useLaunchEffect(
      ref.read(homeViewModelProvider.notifier).dataHome,
    );

    final (flowState,) = ref.watch(
      homeViewModelProvider.select(
        (value) => (value.flowState,),
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: Center(
          child: SingleChildScrollView(
            child: flowState?.getScreenWidget(
              context,
              const PageHome(),
              ref.read(homeViewModelProvider.notifier).onRetry,
            ),
          ),
        ),
      ),
    );
  }
}

class PageHome extends ConsumerWidget {
  static AppPreferences appPreferences = instance<AppPreferences>();
  const PageHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (services, stores) = ref.watch(
      homeViewModelProvider.select(
        (value) => (value.homeResponseModel?.data.services, value.homeResponseModel?.data.stores),
      ),
    );

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CarouselBannersComponent(),
          const Gap(AppSize.s12),
          TextSectionComponent(
            text: StringsManager.services.tr(),
          ),
          ListItemsComponent(
            items: services,
          ),
          const Gap(AppSize.s12),
          TextSectionComponent(
            text: StringsManager.stores.tr(),
          ),
          ListItemsComponent(
            items: stores,
          ),
        ],
      ),
    );
  }
}
