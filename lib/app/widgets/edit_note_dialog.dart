import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/app_button.dart';
import '../utils/app_validators.dart';

Future<void> showEditNoteDialog({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController titleController,
  required TextEditingController messageController,
  required Future<void> Function(String, String) onSave,
}) async {
  await showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.edit, color: AppColors.primary, size: 28),
                  const SizedBox(width: 10),
                  Text('Edit Note', style: AppTextStyles.headline(fontSize: 22, color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                controller: titleController,
                label: 'Title',
                validator: (value) => Validators.required(value, field: 'Title'),
              ),
              const SizedBox(height: 16),
              AppTextFormField(
                controller: messageController,
                label: 'Message',
                validator: (value) => Validators.required(value, field: 'Message'),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel', style: AppTextStyles.subtitle(color: AppColors.subtitle)),
                  ),
                  const SizedBox(width: 8),
                  AppButton(
                    label: 'Save',
                    icon: Icons.save,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await onSave(titleController.text.trim(), messageController.text.trim());
                      Get.back();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
} 