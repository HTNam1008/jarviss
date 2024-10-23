import 'package:flutter/material.dart';
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
  final LoginViewModel _loginViewModel = LoginViewModel(null); // TODO: pass for loginUseCase

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _bind() {
    _loginViewModel.start();
    _userNameController.addListener(() => _loginViewModel.setUserName(_userNameController.text));
    _passwordController.addListener(() => _loginViewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
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
                  controller: _userNameController,
                  hintText: 'Username/Email',
                  icon: Icons.person,
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
                  onPressed: () {
                    // TODO: Implement login functionality
                    _loginViewModel.navigateReplaceNamed(context, Routes.mainRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: AppSize.s16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s28),
                    ),
                    backgroundColor: ColorManager.teal, // Make button background transparent
                    shadowColor: Colors.transparent, // Remove shadow for a clean gradient effect
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: AppSize.s40,
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
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
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
