import 'package:flutter/cupertino.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class RegisterViewModel extends BaseViewModel {
  @override
  Future<void> navigateReplaceNamed(BuildContext context, String route) async {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Future<void> navigateNamed(BuildContext context, String route) async {
    Navigator.pushNamed(context, route);
  }
}
