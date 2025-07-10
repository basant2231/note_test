import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../models/note_model.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const NoteCard({super.key, required this.note, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 4,
      color: isDark ? AppColors.darkCard : AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        title: Text(
          note.title,
          style: AppTextStyles.headline(
            color: isDark ? AppColors.darkText : AppColors.text,
            fontSize: 18,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            note.message,
            style: AppTextStyles.body(
              color: isDark ? AppColors.darkText : AppColors.text,
              fontSize: 16,
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: isDark ? AppColors.accent : AppColors.primary,
              ),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: isDark ? AppColors.darkError : AppColors.error,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
