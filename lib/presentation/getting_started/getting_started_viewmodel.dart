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

  @override
  Future<void> navigateReplaceNamed(BuildContext context, String route) async {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Future<void> navigateNamed(BuildContext context, String route) async {
    Navigator.pushNamed(context, route);

  }
}
