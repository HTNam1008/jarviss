import 'dart:async';

import 'package:flutter_application_1/domain/model/model.dart';
import 'package:flutter_application_1/presentation/base/baseviewmodel.dart';

import 'package:flutter_application_1/presentation/resources/assets_manager.dart';
import 'package:flutter_application_1/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    implements OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controller
  final StreamController<SliderViewObject> _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    // send slider data to our view
    _postDataToView();
  }

  @override
  int goNext() {
    final nextIndex = _currentIndex + 1;
    if (nextIndex >= _list.length) {
      _currentIndex = 0;
    } else {
      _currentIndex = _currentIndex + 1;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    final previousIndex = _currentIndex - 1;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    } else {
      _currentIndex = _currentIndex - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSlideViewObject
  Sink get inputSlideViewObject => _streamController.sink;

  @override
  // TODO: implement outputSlideViewObject
  Stream<SliderViewObject> get outputSlideViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  // private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo4),
      ];

  _postDataToView() {
    inputSlideViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

// inputs mean the orders that our views model will receives from our view.
abstract class OnBoardingViewModelInputs {
  int goNext(); // when user click on right arrow or swipe
  int goPrevious(); // when user click on left arrow or swipe
  void onPageChanged(int index);

  Sink get inputSlideViewObject;
}

// outputs mean data or results that will be sent from viewmodel to our view.
abstract class OnBoardingViewModelOutputs {
  // will be implemented it later.
  Stream<SliderViewObject> get outputSlideViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlide;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlide, this.currentIndex);
}
