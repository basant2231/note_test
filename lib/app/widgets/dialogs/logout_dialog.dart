import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/app_fonts.dart';
import '../../theme/app_colors.dart';
class LogoutDialog extends StatelessWidget {
  LogoutDialog({super.key});
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: AppColors.card,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.logout, color: AppColors.primary, size: 28),
                const SizedBox(width: 10),
                Text(
                  'Logout',
                  style: AppFonts.bold(fontSize: 22, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Are you sure you want to log out?',
              style: AppFonts.regular(fontSize: 16),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: AppFonts.regular(color: AppColors.subtitle),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                  icon: const Icon(Icons.logout, color: Colors.white, size: 20),
                  label: Text(
                    'Logout',
                    style: AppFonts.bold(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
