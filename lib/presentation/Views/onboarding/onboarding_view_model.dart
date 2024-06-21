import 'dart:async';

import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/domain/models/slider_object_model.dart';
import 'package:curso_avanzado_flutter/presentation/base/base_view_models.dart';
import 'package:flutter/material.dart';

class OnboardingViewModel extends BaseViewModels
    implements OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controllers
  final StreamController<SliderViewObject> _streamController = StreamController<SliderViewObject>();

  int _currentIndex = 0;

  final PageController pageController = PageController();

  final List<SliderObjectModel> sliders = const [
    SliderObjectModel(
      title: StringsManager.onBoardingTitle1,
      subTitle: StringsManager.onBoardingSubTitle1,
      image: ImageAssets.onboardingLogo1,
    ),
    SliderObjectModel(
      title: StringsManager.onBoardingTitle2,
      subTitle: StringsManager.onBoardingSubTitle2,
      image: ImageAssets.onboardingLogo2,
    ),
    SliderObjectModel(
      title: StringsManager.onBoardingTitle3,
      subTitle: StringsManager.onBoardingSubTitle3,
      image: ImageAssets.onboardingLogo3,
    ),
    SliderObjectModel(
      title: StringsManager.onBoardingTitle4,
      subTitle: StringsManager.onBoardingSubTitle4,
      image: ImageAssets.onboardingLogo4,
    ),
  ];

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    // TODO: implement start
    _postDataToView();
  }

  @override
  void onForward() {
    _currentIndex++;
    if (_currentIndex == sliders.length) {
      _currentIndex = 0;
    }

    _postDataToView();

    pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: DurationConstant.d300),
      curve: Curves.easeIn,
    );
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  void onReverse() {
    _currentIndex--;
    if (_currentIndex == -1) {
      _currentIndex = sliders.length - 1;
    }

    _postDataToView();

    pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: DurationConstant.d300),
      curve: Curves.easeIn,
    );
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // private functions to handle the logic
  void _postDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(
        sliderObjectModel: sliders[_currentIndex],
        numOfSliders: sliders.length,
        currentIndex: _currentIndex,
      ),
    );
  }
}

// inputs mean the orders that our view model will receive from our view
abstract class OnBoardingViewModelInputs {
  void onForward(); // when user clicks on right arrow or swipe
  void onReverse(); // when user clicks on left arrow or swipe
  void onPageChanged(int index); // when user swipes

  Sink get inputSliderViewObject; // this is the way to add data to our stream .. stream input
}

// outputs mean the data or results that will be sent from our view model to our view
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject>
      get outputSliderViewObject; // this is the way to get data from our stream .. stream output
}

class SliderViewObject {
  SliderObjectModel sliderObjectModel;
  int numOfSliders;
  int currentIndex;

  SliderViewObject({
    required this.sliderObjectModel,
    required this.numOfSliders,
    required this.currentIndex,
  });
}
