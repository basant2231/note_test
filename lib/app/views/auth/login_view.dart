import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/auth_controller.dart';
import 'signup_view.dart';
import 'package:flutter/gestures.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/app_button.dart';
import '../../utils/app_validators.dart';

/// LoginView provides the login form and handles user authentication.
class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: isDark ? AppColors.darkCard : AppColors.card,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: AppFonts.bold(
                        color: isDark ? AppColors.darkText : AppColors.primary,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppTextFormField(
                      controller: emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      controller: passwordController,
                      label: 'Password',
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock),
                      validator: Validators.password,
                    ),
                    const SizedBox(height: 24),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          label: 'Login',
                          loading: AuthController.to.isLoading.value,
                          onPressed:
                              AuthController.to.isLoading.value
                                  ? null
                                  : () async {
                                    if (_formKey.currentState!.validate()) {
                                      AuthController.to.isLoading.value = true;
                                      await AuthController.to.signIn(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      );
                                      AuthController.to.isLoading.value = false;
                                      Get.offAllNamed('/home');
                                    }
                                  },
                          icon: Icons.login,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => Get.toNamed('/signup'),
                      child: RichText(
                        text: TextSpan(
                          style: AppFonts.regular(color: AppColors.text),
                          children: [
                            const TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Sign up',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () => Get.toNamed('/signup'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
