import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../controllers/note_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/note_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';

// Suggested color palette:
// Primary: #6C63FF (Indigo Accent)
// Secondary: #F8F8FF (Ghost White)
// Accent: #FF6584 (Pinkish Red)
// Card: #FFFFFF (Light), #1E1E2C (Dark)
// Font: GoogleFonts.montserrat()

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
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkBackground
                                : AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: AppFonts.regular(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkText
                                : AppColors.text,
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Title required'
                                  : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkBackground
                                : AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: AppFonts.regular(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkText
                                : AppColors.text,
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Message required'
                                  : null,
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
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkBackground
                                : AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: AppFonts.regular(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkText
                                : AppColors.text,
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Title required'
                                  : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkBackground
                                : AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: AppFonts.regular(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkText
                                : AppColors.text,
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Message required'
                                  : null,
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                onPressed: () => AuthController.to.signOut(),
                tooltip: 'Logout',
              ),
            ],
            elevation: 4,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: Text(
                    'Add Note',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
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
                  ),
                  onPressed: () => _showAddNoteDialog(context),
                ),
              ),
            ),
          ),
          Obx(() {
            if (noteController.isLoading.value) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Card(
                        elevation: 4,
                        color: isDark ? AppColors.darkCard : AppColors.card,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          title: Container(
                            height: 18,
                            width: 120,
                            color: Colors.white,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              height: 14,
                              width: 200,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  childCount: 6,
                ),
              );
            }
            if (noteController.error.value != null) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    'Error: \\${noteController.error.value}',
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
                    style: AppFonts.regular(fontSize: 18, color: Colors.grey),
                  ),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final note = noteController.notes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Card(
                    elevation: 4,
                    color: isDark ? AppColors.darkCard : AppColors.card,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      title: Text(
                        note.title,
                        style: AppFonts.bold(
                          color: isDark ? AppColors.darkText : AppColors.text,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          note.message,
                          style: AppFonts.regular(
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
                              color: isDark ? Colors.amber : Colors.deepPurple,
                            ),
                            onPressed: () {
                              _showEditNoteDialog(context, note);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color:
                                  isDark
                                      ? AppColors.darkError
                                      : AppColors.error,
                            ),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder:
                                    (context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      backgroundColor:
                                          isDark
                                              ? AppColors.darkCard
                                              : AppColors.card,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 28,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.warning_amber_rounded,
                                                  color: AppColors.error,
                                                  size: 28,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  'Delete Note',
                                                  style: AppFonts.bold(
                                                    fontSize: 22,
                                                    color: AppColors.error,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              'Are you sure you want to delete this note?',
                                              style: AppFonts.regular(
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 28),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed:
                                                      () => Navigator.of(
                                                        context,
                                                      ).pop(false),
                                                  child: Text(
                                                    'Cancel',
                                                    style: AppFonts.regular(
                                                      color: AppColors.subtitle,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                ElevatedButton.icon(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.error,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 20,
                                                          vertical: 12,
                                                        ),
                                                  ),
                                                  onPressed:
                                                      () => Navigator.of(
                                                        context,
                                                      ).pop(true),
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  label: Text(
                                                    'Delete',
                                                    style: AppFonts.bold(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              );
                              if (confirm == true) {
                                await noteController.deleteNote(note.id);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }, childCount: noteController.notes.length),
            );
          }),
        ],
      ),
      backgroundColor:
          isDark ? const Color(0xFF232946) : const Color(0xFFF8F8FF),
    );
  }
}
