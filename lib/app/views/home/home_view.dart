import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/note_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/note_model.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final NoteController noteController = Get.put(NoteController());
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
            title: const Text('Add Note'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Title required'
                                : null,
                  ),
                  TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(labelText: 'Message'),
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
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await noteController.addNote(
                      titleController.text.trim(),
                      messageController.text.trim(),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => AuthController.to.signOut(),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Obx(() {
        if (noteController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (noteController.error.value != null) {
          return Center(child: Text('Error: \\${noteController.error.value}'));
        }
        final notes = noteController.notes;
        final isTablet = MediaQuery.of(context).size.width >= 600;
        if (isTablet) {
          // Two-column layout for tablet
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: _NotesList(notes: notes, noteController: noteController),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                flex: 3,
                child: Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Note'),
                    onPressed: () => _showAddNoteDialog(context),
                  ),
                ),
              ),
            ],
          );
        } else {
          // Single column for mobile
          return Column(
            children: [
              Expanded(
                child: _NotesList(notes: notes, noteController: noteController),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Note'),
                    onPressed: () => _showAddNoteDialog(context),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

class _NotesList extends StatelessWidget {
  final List<NoteModel> notes;
  final NoteController noteController;
  const _NotesList({required this.notes, required this.noteController});

  void _showEditNoteDialog(BuildContext context, NoteModel note) {
    final titleController = TextEditingController(text: note.title);
    final messageController = TextEditingController(text: note.message);
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Note'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Title required'
                                : null,
                  ),
                  TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(labelText: 'Message'),
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
                child: const Text('Cancel'),
              ),
              ElevatedButton(
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
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return const Center(child: Text('No notes yet.'));
    }
    return ListView.separated(
      itemCount: notes.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          title: Text(note.title),
          subtitle: Text(note.message),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showEditNoteDialog(context, note);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => noteController.deleteNote(note.id),
              ),
            ],
          ),
        );
      },
    );
  }
}
