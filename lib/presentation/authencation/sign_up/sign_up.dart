import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/sign_up_usecase.dart';
import 'package:jarvis/presentation/authencation/sign_up/sign_up_viewmodel.dart';
import 'package:jarvis/presentation/common/dialog_util.dart';
import 'package:jarvis/presentation/resources/assets_manager.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final getIt = GetIt.instance;
  late SignUpViewModel _signUpViewModel;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _bind() {
    _signUpViewModel.start();

    _emailController.addListener(() => _signUpViewModel.setEmail(_emailController.text));
    _passwordController.addListener(() => _signUpViewModel.setPassword(_passwordController.text));
    _userNameController.addListener(() => _signUpViewModel.setUsername(_userNameController.text));

    _signUpViewModel.signUpStream.listen((isSuccess) {
      if (isSuccess) {
        showCustomDialog(
          context: context,
          type: DialogType.success,
          title: 'Sign up successfully',
          message: 'You are being redirected to the Sign in page!',
        ).then((_) {
          _signUpViewModel.navigateReplaceNamed(context, Routes.mainRoute);
        });
      }
    });

    _signUpViewModel.errorStream.listen((errorMessage) {
      showCustomDialog(
          context: context,
          type: DialogType.error,
          title: 'Sign in failed',
          message: errorMessage,
        );
    });
  }

  @override
  void initState() {
    super.initState();
    _signUpViewModel = SignUpViewModel(SignUpUseCase(getIt<Repository>()), getIt<AppPreferences>());
    _bind();
  }

   @override
  void dispose() {
    _signUpViewModel.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorManager.teal, ColorManager.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: AppSize.s16),
                const CircleAvatar(
                  radius: AppSize.s40,
                  backgroundImage: AssetImage(ImageAssets.splashLogo), // Logo placeholder
                ),
                const SizedBox(height: AppSize.s24),
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: AppSize.s28,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                const SizedBox(height: AppSize.s8),
                const Text(
                  'Please Register to continue',
                  style: TextStyle(fontSize: AppSize.s16, color: Colors.grey),
                ),
                const SizedBox(height: AppSize.s24),
                _buildTextField(
                  controller: _userNameController,
                  hintText: 'Username',
                  icon: Icons.person,
                  name: 'username'
                ),
                const SizedBox(height: AppSize.s16),
                _buildTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                  name: 'email',

                ),
                const SizedBox(height: AppSize.s16),
                _buildTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  name: 'password'
                ),
                const SizedBox(height: AppSize.s16),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement registration functionality
                    _signUpViewModel.signUp();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: AppSize.s16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s28),
                    ),
                    backgroundColor: ColorManager.teal,
                    shadowColor: Colors.transparent,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: AppSize.s14,
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: FontSize.s16, color: ColorManager.white),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'By continuing, you agree to our ',
                  style: TextStyle(fontSize: AppSize.s14, color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Implement privacy policy functionality
                  },
                  child: const Text(
                    'Privacy policy',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                const Text('Or Login With'),
                const SizedBox(height: AppSize.s8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(ImageAssets.gg_ic),
                  ],
                ),
                const SizedBox(height: AppSize.s16),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to Login screen
                    Navigator.pop(context);
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

    Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required String name,
    bool obscureText = false,
  }) {
    return StreamBuilder<bool>(
      stream: getItemValidate(name),
      builder: (context, snapshot) {
        return TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hintText,
            errorText: (snapshot.data == false) ? 'Invalid $hintText' : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        );
      },
    );
  }

  Widget _buildSocialButton(String assetPath) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement social login functionality
      },
      child: CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage(assetPath),
      ),
    );
  }
  
  Stream<bool> getItemValidate(String name) {
    switch (name) {
      case 'username':
        return _signUpViewModel.isUsernameValid;
      case 'email':
        return _signUpViewModel.isEmailValid;
      case 'password':
        return _signUpViewModel.isPasswordValid;
      default:
        return Stream.value(true);
    }
  }
}
