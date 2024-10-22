import 'package:flutter/material.dart';
import 'package:jarvis/presentation/resources/assets_manager.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';
import 'getting_started_viewmodel.dart';

class GettingStartedView extends StatefulWidget {
  @override
  State<GettingStartedView> createState() => _GettingStartedViewState();
}

class _GettingStartedViewState extends State<GettingStartedView> {
  final GettingStartedViewModel _viewModel = GettingStartedViewModel();

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
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.teal.shade300,
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageAssets.gettingStartedLogo,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: AppSize.s20),
                Text(
                  'Welcome to AI\nchat bot',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontConstants.fontFamily,
                    fontSize: AppSize.s28,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                SizedBox(height: AppSize.s40),
                ElevatedButton(
                  onPressed: () {
                    _viewModel.navigateToMainScreen(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s28),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s40, vertical: AppSize.s16),
                  ),
                  child: Text(
                    'Getting Started',
                    style: TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      fontSize: AppSize.s18,
                      color: ColorManager.white,
                    ),
                  ),
                ),
                SizedBox(height: AppSize.s20),
                TextButton(
                  onPressed: () {
                    // Điều hướng đến trang điều khoản và điều kiện
                  },
                  child: Text(
                    'Terms & conditions',
                    style: TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      fontSize: AppSize.s16,
                      color: ColorManager.darkPrimary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          );
        }
      ),
    );
  }
}
