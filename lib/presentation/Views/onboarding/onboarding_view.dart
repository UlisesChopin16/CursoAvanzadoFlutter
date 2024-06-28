import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/domain/models/slider_object_model/slider_object_model.dart';
import 'package:curso_avanzado_flutter/presentation/Views/onboarding/onboardin_view_model/onboarding_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/common/components/text_button_component.dart';
import 'package:curso_avanzado_flutter/presentation/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingView extends HookConsumerWidget {
  const OnboardingView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();

    final viewModel = ref.watch(onboardingViewModelProvider.notifier);

    final (length, index) = ref.watch(
        onboardingViewModelProvider.select((value) => (value.numOfSliders, value.currentIndex)));

    const sliders = SliderViewObject.sliders;
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: length,
        onPageChanged: viewModel.onPageChanged,
        itemBuilder: (context, index) {
          return OnBoardingPage(
            sliderObject: sliders[index],
          );
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButtonComponent(
                onPressed: () {
                  viewModel.skipOnBoarding();
                  context.pushReplacementNamed(Routes.loginRouteName);
                },
                text: StringsManager.skip,
              ),
            ),
            IndicatorPage(
              index: index,
              length: length,
              onReverse: () => viewModel.onReverse(pageController),
              onForward: () => viewModel.onForward(pageController),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObjectModel sliderObject;
  const OnBoardingPage({
    super.key,
    required this.sliderObject,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Gap(AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const Gap(AppSize.s60),
        SvgPicture.asset(
          sliderObject.image,
        ),
      ],
    );
  }
}

class IndicatorPage extends StatelessWidget {
  final VoidCallback onReverse;
  final VoidCallback onForward;

  final int index;
  final int length;
  const IndicatorPage({
    super.key,
    required this.length,
    required this.index,
    required this.onReverse,
    required this.onForward,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: onReverse,
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(
                  ImageAssets.leftArrowIc,
                ),
              ),
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < length; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: i == index
                      ? SvgPicture.asset(
                          ImageAssets.hollowCircleIc,
                        )
                      : SvgPicture.asset(
                          ImageAssets.solidCircleIc,
                        ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: onForward,
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(
                  ImageAssets.rightarrowIc,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
