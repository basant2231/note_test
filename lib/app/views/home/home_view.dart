import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/note_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/note_model.dart';

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
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Add Note',
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    style: GoogleFonts.montserrat(),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Title required'
                                : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(labelText: 'Message'),
                    style: GoogleFonts.montserrat(),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Message required'
                                : null,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel', style: GoogleFonts.montserrat()),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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
                child: Text(
                  'Add',
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
              ),
            ],
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
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Edit Note',
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    style: GoogleFonts.montserrat(),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Title required'
                                : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(labelText: 'Message'),
                    style: GoogleFonts.montserrat(),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Message required'
                                : null,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel', style: GoogleFonts.montserrat()),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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
                child: Text(
                  'Save',
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
              ),
            ],
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
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (noteController.error.value != null) {
              return SliverFillRemaining(
                child: Center(
                  child: Text('Error: \\${noteController.error.value}'),
                ),
              );
            }
            if (noteController.notes.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No notes yet.',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
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
                    color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
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
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          note.message,
                          style: GoogleFonts.montserrat(fontSize: 16),
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
                              color: isDark ? Colors.redAccent : Colors.red,
                            ),
                            onPressed: () => noteController.deleteNote(note.id),
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
