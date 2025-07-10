import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_test/app/theme/app_colors.dart';
import '../../controllers/note_controller.dart';
import '../app_text_form_field.dart';
import '../../utils/app_fonts.dart';

import '../../utils/app_validators.dart';

class AddNoteDialog extends StatelessWidget {
  AddNoteDialog({super.key});
  final NoteController noteController = Get.find<NoteController>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkCard
              : AppColors.card,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.note_add, color: AppColors.primary, size: 28),
                  const SizedBox(width: 10),
                  Text(
                    'Add Note',
                    style: AppFonts.bold(
                      fontSize: 22,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                controller: titleController,
                label: 'Title',
                validator:
                    (value) => Validators.required(value, field: 'Title'),
              ),
              const SizedBox(height: 16),
              AppTextFormField(
                controller: messageController,
                label: 'Message',
                validator:
                    (value) => Validators.required(value, field: 'Message'),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await noteController.addNote(
                          titleController.text.trim(),
                          messageController.text.trim(),
                        );
                         Get.back();
                      }
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      'Add',
                      style: AppFonts.bold(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
