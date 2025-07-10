import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

import 'package:flutter/gestures.dart';
import '../../theme/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/app_button.dart';
import '../../utils/app_validators.dart';
import '../../theme/app_paddings.dart';

/// LoginView provides the login form and handles user authentication.
class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: AppPaddings.screen,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: AppColors.card,
            child: Padding(
              padding: AppPaddings.card,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: AppFonts.bold(
                        color: AppColors.primary,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: AppSpacings.large),
                    AppTextFormField(
                      controller: emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                      validator: Validators.email,
                    ),
                    const SizedBox(height: AppSpacings.medium),
                    AppTextFormField(
                      controller: passwordController,
                      label: 'Password',
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock),
                      validator: Validators.password,
                    ),
                    const SizedBox(height: AppSpacings.large),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          label: 'Login',
                          loading: authController.isLoading.value,
                          onPressed:
                              authController.isLoading.value
                                  ? null
                                  : () async {
                                    if (_formKey.currentState!.validate()) {
                                      authController.isLoading.value = true;
                                      await authController.signIn(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      );
                                      authController.isLoading.value = false;
                                      Get.offAllNamed('/home');
                                    }
                                  },
                          icon: Icons.login,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacings.small),
                    TextButton(
                      onPressed: () => Get.toNamed('/signup'),
                      child: RichText(
                        text: TextSpan(
                          style: AppFonts.regular(color: AppColors.text),
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: AppFonts.regular(color: AppColors.text),
                            ),
                            TextSpan(
                              text: 'Sign up',
                              style: AppFonts.bold(
                                color: AppColors.primary,
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
