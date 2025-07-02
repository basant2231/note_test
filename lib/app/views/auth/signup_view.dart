import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/auth_controller.dart';
import 'package:flutter/gestures.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/app_button.dart';
import '../../utils/app_validators.dart';

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
                          label: 'Sign Up',
                          loading: isLoading.value,
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
                          icon: Icons.person_add,
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
