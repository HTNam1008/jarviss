import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/login_usecase.dart';
import 'package:jarvis/presentation/login/login_viewmodel.dart';
import 'package:jarvis/presentation/resources/assets_manager.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final getIt = GetIt.instance;
  late LoginViewModel _loginViewModel;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _bind() {
    _loginViewModel.start();
    _emailController.addListener(() => _loginViewModel.setEmail(_emailController.text));
    _passwordController.addListener(() => _loginViewModel.setPassword(_passwordController.text));

    _loginViewModel.loginStream.listen((isSuccess) {
      if (isSuccess) {
        _loginViewModel.navigateReplaceNamed(context, Routes.mainRoute);
      }
    });

    _loginViewModel.errorStream.listen((errorMessage) {
      _showErrorDialog(errorMessage);
    });
  }

  void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

  @override
  void initState() {
    super.initState();
    // Khởi tạo LoginViewModel với LoginUseCase
    _loginViewModel = LoginViewModel(LoginUseCase(getIt<Repository>()), getIt<AppPreferences>());
    _bind();
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Colors.white,
            ],
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
                  backgroundImage: AssetImage(ImageAssets.splashLogo),
                ),
                const SizedBox(height: AppSize.s24),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: AppSize.s28,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                const SizedBox(height: AppSize.s8),
                Text(
                  'Please Login to continue',
                  style: TextStyle(fontSize: AppSize.s16, color: ColorManager.grey),
                ),
                const SizedBox(height: AppSize.s24),
                _buildTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                const SizedBox(height: AppSize.s16),
                _buildTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: AppSize.s8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      _loginViewModel.navigateNamed(context, Routes.forgotPasswordRoute);
                    },
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                ElevatedButton(
                  onPressed: () async {
                    await _loginViewModel.login();
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
                    height: AppSize.s20,
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: FontSize.s16, color: ColorManager.white),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                const Text('Or Login With'),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(ImageAssets.gg_ic),
                    const SizedBox(width: AppSize.s16),
                  ],
                ),
                const SizedBox(height: AppSize.s16),
                TextButton(
                  onPressed: () {
                    _loginViewModel.navigateNamed(context, Routes.registerRoute);
                  },
                  child: const Text('Don\'t have an account? Register'),
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
    bool obscureText = false,
  }) {
    return StreamBuilder<bool>(
      stream: hintText == 'Email' ? _loginViewModel.isEmailValid : _loginViewModel.isPasswordValid,
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
}
