import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../controllers/note_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/note_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/app_button.dart';
import '../../utils/app_validators.dart';
import '../../widgets/note_card.dart';
import '../../widgets/delete_note_dialog.dart';

/// HomeView displays the user's notes and allows note management.
class HomeView extends StatelessWidget {
  HomeView({super.key});
  final NoteController noteController = Get.find<NoteController>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showAddNoteDialog(BuildContext context) {
    titleController.clear();
    messageController.clear();
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
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
                        Icon(
                          Icons.note_add,
                          color: AppColors.primary,
                          size: 28,
                        ),
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
                          (value) =>
                              Validators.required(value, field: 'Message'),
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
                              Navigator.of(context).pop();
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
          ),
    );
  }

  void _showEditNoteDialog(BuildContext context, NoteModel note) {
    final titleController = TextEditingController(text: note.title);
    final messageController = TextEditingController(text: note.message);
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
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
                        Icon(Icons.edit, color: AppColors.primary, size: 28),
                        const SizedBox(width: 10),
                        Text(
                          'Edit Note',
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
                          (value) =>
                              Validators.required(value, field: 'Message'),
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
                              final updatedNote = NoteModel(
                                id: note.id,
                                title: titleController.text.trim(),
                                message: messageController.text.trim(),
                                userId: note.userId,
                                timestamp: note.timestamp,
                              );
                              await noteController.updateNote(updatedNote);
                              Navigator.of(context).pop();
                            }
                          },
                          icon: const Icon(
                            Icons.save,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: Text(
                            'Save',
                            style: AppFonts.bold(color: Colors.white),
                          ),
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

  Future<bool?> _showLogoutDialog(BuildContext context) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return showDialog<bool>(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: isDark ? AppColors.darkCard : AppColors.card,
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
                        style: AppFonts.bold(
                          fontSize: 22,
                          color: AppColors.primary,
                        ),
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
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 20,
                        ),
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
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 700;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor:
                    isDark ? const Color(0xFF232946) : const Color(0xFF6C63FF),
                title: Text(
                  'My Notes',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () async {
                      final confirm = await _showLogoutDialog(context);
                      if (confirm == true) {
                        AuthController.to.signOut();
                        Get.offAllNamed('/login');
                      }
                    },
                    tooltip: 'Logout',
                  ),
                ],
                elevation: 4,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 24 : 16,
                    vertical: 12,
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: Text(
                      'Add Note',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDark
                              ? const Color(0xFFFF6584)
                              : const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: () => _showAddNoteDialog(context),
                  ),
                ),
              ),
              Obx(() {
                if (noteController.isLoading.value) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(
                        color:
                            isDark
                                ? const Color(0xFF6C63FF)
                                : const Color(0xFF6C63FF),
                        strokeWidth: 3,
                      ),
                    ),
                  );
                }
                if (noteController.error.value != null) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'Error: ${noteController.error.value}',
                        style: AppFonts.regular(),
                      ),
                    ),
                  );
                }
                if (noteController.notes.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No notes yet.',
                        style: AppFonts.regular(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }
                // Responsive notes list
                if (isTablet) {
                  // Two or three-column grid for tablets, minimal horizontal padding
                  int crossAxisCount = constraints.maxWidth > 1100 ? 3 : 2;
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.6,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final note = noteController.notes[index];
                        return NoteCard(
                          note: note,
                          onEdit: () => _showEditNoteDialog(context, note),
                          onDelete: () async {
                            final confirm = await showDeleteNoteDialog(
                              context: context,
                            );
                            if (confirm == true) {
                              await noteController.deleteNote(note.id);
                            }
                          },
                        );
                      }, childCount: noteController.notes.length),
                    ),
                  );
                } else {
                  // Single-column list for mobile
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final note = noteController.notes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: NoteCard(
                          note: note,
                          onEdit: () => _showEditNoteDialog(context, note),
                          onDelete: () async {
                            final confirm = await showDeleteNoteDialog(
                              context: context,
                            );
                            if (confirm == true) {
                              await noteController.deleteNote(note.id);
                            }
                          },
                        ),
                      );
                    }, childCount: noteController.notes.length),
                  );
                }
              }),
            ],
          ),
        );
      },
    );
  }
}
