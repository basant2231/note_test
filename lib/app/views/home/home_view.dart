import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/note_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/note_model.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/note_card.dart';
import '../../widgets/delete_note_dialog.dart';
import '../../widgets/add_note_dialog.dart';
import '../../widgets/edit_note_dialog.dart';
import '../../widgets/dialogs/logout_dialog.dart';
import '../../theme/app_colors.dart';


/// HomeView displays the user's notes and allows note management.
class HomeView extends StatelessWidget {
  HomeView({super.key});
  final NoteController noteController = Get.find<NoteController>();

  final GlobalKey<FormState> _addFormKey = GlobalKey<FormState>();
  final TextEditingController _addTitleController = TextEditingController();
  final TextEditingController _addMessageController = TextEditingController();

  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();
  final TextEditingController _editTitleController = TextEditingController();
  final TextEditingController _editMessageController = TextEditingController();

  Future<void> _showAddNoteDialog(BuildContext context) async {
    await showAddNoteDialog(
      context: context,
      formKey: _addFormKey,
      titleController: _addTitleController,
      messageController: _addMessageController,
      onAdd: (title, message) async {
        await noteController.addNote(title, message);
      },
    );
  }

  Future<void> _showEditNoteDialog(BuildContext context, NoteModel note) async {
    _editTitleController.text = note.title;
    _editMessageController.text = note.message;
    await showEditNoteDialog(
      context: context,
      formKey: _editFormKey,
      titleController: _editTitleController,
      messageController: _editMessageController,
      onSave: (title, message) async {
        final updatedNote = note.copyWith(title: title, message: message);
        await noteController.updateNote(updatedNote);
      },
    );
  }

  Future<bool?> _showLogoutDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => LogoutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 700;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: const Color(0xFF6C63FF),
                title: Text(
                  'My Notes',
                  style: AppFonts.bold(color: Colors.white, fontSize: 22),
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
                    label: Text('Add Note', style: AppFonts.bold(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
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
                        color: AppColors.primary,
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
