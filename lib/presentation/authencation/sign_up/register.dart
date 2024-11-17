import 'package:flutter/material.dart';
import 'package:jarvis/presentation/authencation/sign_up/register_viewmodel.dart';
import 'package:jarvis/presentation/resources/assets_manager.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegisterViewModel _registerViewModel = RegisterViewModel();

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
                ),
                const SizedBox(height: AppSize.s16),
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
                const SizedBox(height: AppSize.s16),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement registration functionality
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
