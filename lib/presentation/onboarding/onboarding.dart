import 'package:flutter/material.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:jarvis/presentation/resources/assets_manager.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/strings_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSlideViewObject,
      builder: (context, snapShot) {
        return _getContentWidget(snapShot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    return sliderViewObject != null
        ? Scaffold(
            backgroundColor: ColorManager.white,
            // appBar: AppBar(
            //   elevation: AppSize.s0,
            //   systemOverlayStyle: SystemUiOverlayStyle(
            //     statusBarColor: ColorManager.white,
            //     statusBarBrightness: Brightness.dark,
            //     statusBarIconBrightness: Brightness.dark,
            //   ),
            // ),
            body: PageView.builder(
              controller: _pageController,
              itemCount: sliderViewObject.numOfSlide,
              onPageChanged: (index) {
                _viewModel.onPageChanged(index);
              },
              itemBuilder: (context, index) {
                return OnBoardingPage(sliderViewObject.sliderObject);
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
                      onPressed: () {},
                      child: const Text(
                        AppStrings.skip,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  _getBottomSheetWidget(sliderViewObject),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left arrow icon
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
                child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.leftArrowIc),
                ),
                onTap: () {
                  _pageController.animateToPage(_viewModel.goPrevious(),
                      duration:
                          const Duration(milliseconds: DurationConstant.d300),
                      curve: Curves.linear);
                }),
          ),

          // circles indicator
          Row(
            children: [
              for (int idx = 0; idx < sliderViewObject.numOfSlide; idx++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(idx, sliderViewObject.currentIndex),
                )
            ],
          ),

          // right arrow icon
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
              onTap: () {
                _pageController.animateToPage(_viewModel.goNext(),
                    duration:
                        const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceInOut);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    return SizedBox(
      height: AppSize.s8, // Set the desired height for the circle
      width: AppSize.s8, // Set the desired width for the circle
      child: SvgPicture.asset(
        index == currentIndex
            ? ImageAssets.hollowCircleIc
            : ImageAssets.solidCircleIc,
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            // style: getApplicationTheme().textTheme.displayLarge,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}
