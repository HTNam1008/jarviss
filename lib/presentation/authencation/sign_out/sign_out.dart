// lib/presentation/signout/sign_out_view.dart

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/presentation/authencation/sign_out/sign_out_viewmodel.dart';
import 'package:jarvis/presentation/common/dialog_util.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';
import 'dart:async';

class SignOutView extends StatefulWidget {
  const SignOutView({Key? key}) : super(key: key);

  @override
  _SignOutViewState createState() => _SignOutViewState();
}

class _SignOutViewState extends State<SignOutView> {
  late SignOutViewModel _viewModel;
  late StreamSubscription<bool> _signOutSubscription;
  late StreamSubscription<String> _errorSubscription;

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.instance<SignOutViewModel>();

    // Listen to signOutStream
    _signOutSubscription = _viewModel.signOutStream.listen((isSuccess) {
      if (isSuccess) {
        // Show success dialog
        showCustomDialog(
          context: context,
          type: DialogType.success,
          title: 'Đăng xuất thành công',
          message: 'Bạn đã đăng xuất khỏi ứng dụng.',
        ).then((_) {
          // Navigate to login screen after dialog is dismissed
          _viewModel.navigateReplaceNamed(context, Routes.signInRoute);
        });
      }
    });

    // Listen to errorStream
    _errorSubscription = _viewModel.errorStream.listen((errorMessage) {
      // Show error dialog
      showCustomDialog(
        context: context,
        type: DialogType.error,
        title: 'Đăng xuất thất bại',
        message: errorMessage,
      );
    });

    // Initiate sign-out
    _viewModel.signOut();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _signOutSubscription.cancel();
    _errorSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Display a loading indicator while signing out
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng xuất'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
