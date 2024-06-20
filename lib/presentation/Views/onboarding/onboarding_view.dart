import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
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
  int _currentIndex = 0;

  List<SliderObject> sliders = [
    SliderObject(
      title: StringsManager.onBoardingTitle1,
      subTitle: StringsManager.onBoardingSubTitle1,
      image: ImageAssets.onboardingLogo1,
    ),
    SliderObject(
      title: StringsManager.onBoardingTitle2,
      subTitle: StringsManager.onBoardingSubTitle2,
      image: ImageAssets.onboardingLogo2,
    ),
    SliderObject(
      title: StringsManager.onBoardingTitle3,
      subTitle: StringsManager.onBoardingSubTitle3,
      image: ImageAssets.onboardingLogo3,
    ),
    SliderObject(
      title: StringsManager.onBoardingTitle4,
      subTitle: StringsManager.onBoardingSubTitle4,
      image: ImageAssets.onboardingLogo4,
    ),
  ];

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
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
        itemCount: sliders.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
              index: _currentIndex,
              length: sliders.length,
              onReverse: onReverse,
              onForward: onForward,
            ),
          ],
        ),
      ),
    );
  }

  onReverse() {
    setState(() {
      _currentIndex--;
      if (_currentIndex == -1) {
        _currentIndex = sliders.length - 1;
      }
    });
    pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: DurationConstant.d300),
      curve: Curves.easeIn,
    );
  }

  onForward() {
    setState(() {
      _currentIndex++;
      if (_currentIndex == sliders.length) {
        _currentIndex = 0;
      }
    });
    pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: DurationConstant.d300),
      curve: Curves.easeIn,
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject sliderObject;
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

class SliderObject {
  final String title;
  final String subTitle;
  final String image;

  SliderObject({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}
