import 'package:curso_avanzado_flutter/app/app_preferences.dart';
import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/domain/models/slider_object_model/slider_object_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_view_model.freezed.dart';
part 'onboarding_view_model.g.dart';

@freezed
class SliderViewObject with _$SliderViewObject {
  const factory SliderViewObject({
    required SliderObjectModel sliderObjectModel,
    required int numOfSliders,
    @Default(0) int currentIndex,
  }) = _SliderViewObject;

  static final sliders = [
    SliderObjectModel(
      title: StringsManager.onBoardingTitle1.tr(),
      subTitle: StringsManager.onBoardingSubTitle1.tr(),
      image: ImageAssets.onboardingLogo1,
    ),
    SliderObjectModel(
      title: StringsManager.onBoardingTitle2.tr(),
      subTitle: StringsManager.onBoardingSubTitle2.tr(),
      image: ImageAssets.onboardingLogo2,
    ),
    SliderObjectModel(
      title: StringsManager.onBoardingTitle3.tr(),
      subTitle: StringsManager.onBoardingSubTitle3.tr(),
      image: ImageAssets.onboardingLogo3,
    ),
    SliderObjectModel(
      title: StringsManager.onBoardingTitle4.tr(),
      subTitle: StringsManager.onBoardingSubTitle4.tr(),
      image: ImageAssets.onboardingLogo4,
    ),
  ];
}

@riverpod
class OnboardingViewModel extends _$OnboardingViewModel implements OnBoardingViewModelInputs {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  SliderViewObject build() {
    return SliderViewObject(
      sliderObjectModel: SliderViewObject.sliders[0],
      numOfSliders: SliderViewObject.sliders.length,
    );
  }

  @override
  void onForward(PageController pageController) {
    state = state.copyWith(
      currentIndex: state.currentIndex + 1,
    );
    if (state.currentIndex == SliderViewObject.sliders.length) {
      state = state.copyWith(
        currentIndex: 0,
      );
    }

    _postDataToView();

    pageController.animateToPage(
      state.currentIndex,
      duration: const Duration(milliseconds: DurationConstant.d300),
      curve: Curves.easeIn,
    );
  }

  @override
  void onPageChanged(int index) {
    state = state.copyWith(
      currentIndex: index,
    );
    _postDataToView();
  }

  @override
  void onReverse(PageController pageController) {
    state = state.copyWith(
      currentIndex: state.currentIndex - 1,
    );
    if (state.currentIndex == -1) {
      state = state.copyWith(
        currentIndex: SliderViewObject.sliders.length - 1,
      );
    }

    _postDataToView();

    pageController.animateToPage(
      state.currentIndex,
      duration: const Duration(milliseconds: DurationConstant.d300),
      curve: Curves.easeIn,
    );
  }

  // private functions to handle the logic
  void _postDataToView() {
    state = state.copyWith(
      sliderObjectModel: SliderViewObject.sliders[state.currentIndex],
    );
  }

  void skipOnBoarding() {
    // save the skip action
    _appPreferences.setOnBoardingScreenViewed();
  }
}

// inputs mean the orders that our view model will receive from our view
abstract class OnBoardingViewModelInputs {
  void onForward(PageController pageController); // when user clicks on right arrow or swipe
  void onReverse(PageController pageController); // when user clicks on left arrow or swipe
  void onPageChanged(int index); // when user swipes
}
