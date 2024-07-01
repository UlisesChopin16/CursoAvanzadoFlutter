import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/pages/home_page/store_details_page/store_details_page_view_model/store_details_page_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/common/components/title_component.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/hooks/use_launch_effect.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/widgets.dart';

class StoreDetailsPage extends HookConsumerWidget {
  const StoreDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useLaunchEffect(
      ref.read(storeDetailsPageViewModelProvider.notifier).getStoreDetails,
    );

    final (flowState, title) = ref
        .watch(storeDetailsPageViewModelProvider.select((value) => (value.flowState, value.title)));
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: TitleBoldComponent(
          text: title,
          color: ColorManager.white,
        ),
      ),
      body: Center(
        child: flowState?.getScreenWidget(
          context,
          const StoreDetails(),
          ref.read(storeDetailsPageViewModelProvider.notifier).getStoreDetails,
        ),
      ),
    );
  }
}

class StoreDetails extends ConsumerWidget {
  const StoreDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (image, details, services, about) = ref.watch(storeDetailsPageViewModelProvider
        .select((value) => (value.imageUrl, value.details, value.services, value.about)));
    return ListView(
      children: [
        const Gap(AppSize.s20),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s12),
            child: Image.network(image, fit: BoxFit.cover, height: AppSize.s230),
          ),
        ),
        const Gap(AppSize.s16),
        TextSectionComponent(
          text: StringsManager.details.tr(),
        ),
        const Gap(AppSize.s8),
        ParagraphSectionComponent(
          text: details,
        ),
        const Gap(AppSize.s20),
        TextSectionComponent(
          text: StringsManager.services.tr(),
        ),
        const Gap(AppSize.s8),
        ParagraphSectionComponent(
          text: services,
        ),
        const Gap(AppSize.s20),
        TextSectionComponent(
          text: StringsManager.about.tr(),
        ),
        const Gap(AppSize.s8),
        ParagraphSectionComponent(
          text: about,
        ),
        const Gap(AppSize.s40),
      ],
    );
  }
}
