import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/domain/models/slider_object_model/slider_object_model.dart';
import 'package:curso_avanzado_flutter/presentation/Views/onboarding/onboarding_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  OnboardingViewModel viewModel = OnboardingViewModel();

  void _bind() {
    viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: viewModel.outputSliderViewObject,
        builder: (context, snapshot) {

          
          late final SliderViewObject slider;
          if (snapshot.hasData) {
            slider = snapshot.data!;
          } else {
            return const SizedBox();
          }
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
              controller: viewModel.pageController,
              itemCount: slider.numOfSliders,
              onPageChanged: viewModel.onPageChanged,
              itemBuilder: (context, index) {
                return OnBoardingPage(
                  sliderObject: viewModel.sliders[index],
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
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.loginRoute);
                      },
                      child: Text(
                        StringsManager.skip,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  IndicatorPage(
                    index: slider.currentIndex,
                    length: slider.numOfSliders,
                    onReverse: viewModel.onReverse,
                    onForward: viewModel.onForward,
                  ),
                ],
              ),
            ),
          );
        });
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
