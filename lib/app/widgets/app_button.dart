import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final Color? color;
  final IconData? icon;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.color,
    this.icon,
    this.textColor,
    this.borderRadius = 12,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final btnColor = color ?? AppColors.primary;
    final txtColor = textColor ?? Colors.white;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: loading ? null : onPressed,
      icon: loading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.2,
                valueColor: AlwaysStoppedAnimation<Color>(txtColor),
              ),
            )
          : (icon != null ? Icon(icon, color: txtColor, size: 20) : const SizedBox.shrink()),
      label: Text(
        label,
        style: AppTextStyles.headline(color: txtColor, fontSize: 16),
      ),
    );
  }
} 