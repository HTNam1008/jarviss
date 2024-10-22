import 'package:flutter/material.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';

class GettingStartedViewModel extends BaseViewModel {
  @override
  void dispose() {
  }

  @override
  void start() {
  }

  Future<void> navigateToMainScreen(BuildContext context) async {
    Navigator.pushReplacementNamed(context, Routes.mainRoute);
  }
}
