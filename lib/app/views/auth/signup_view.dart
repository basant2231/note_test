import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/auth_controller.dart';
import 'package:flutter/gestures.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';

class SignupView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  SignupView({super.key});

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
                      'Create Account',
                      style: AppFonts.bold(
                        color: isDark ? AppColors.darkText : AppColors.primary,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        filled: true,
                        fillColor:
                            isDark
                                ? AppColors.darkBackground
                                : AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: AppFonts.regular(
                        color: isDark ? AppColors.darkText : AppColors.text,
                      ),
                      validator:
                          (value) =>
                              value != null && value.isEmail
                                  ? null
                                  : 'Enter a valid email',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        filled: true,
                        fillColor:
                            isDark
                                ? AppColors.darkBackground
                                : AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      obscureText: true,
                      style: AppFonts.regular(
                        color: isDark ? AppColors.darkText : AppColors.text,
                      ),
                      validator:
                          (value) =>
                              value != null && value.length >= 6
                                  ? null
                                  : 'Password too short',
                    ),
                    const SizedBox(height: 24),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed:
                              isLoading.value
                                  ? null
                                  : () async {
                                    if (_formKey.currentState!.validate()) {
                                      isLoading.value = true;
                                      await AuthController.to.signUp(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      );
                                      isLoading.value = false;
                                    }
                                  },
                          child:
                              isLoading.value
                                  ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : Text(
                                    'Sign Up',
                                    style: AppFonts.bold(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: RichText(
                        text: TextSpan(
                          style: AppFonts.regular(color: AppColors.text),
                          children: [
                            const TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Login',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () => Get.back(),
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
