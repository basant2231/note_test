import 'package:get/get.dart';
import '../models/note_model.dart';
import '../models/user_model.dart';
import '../services/note_service.dart';
import 'auth_controller.dart';

class NoteController extends GetxController {
  final NoteService _noteService = NoteService();
  final notes = <NoteModel>[].obs;
  final isLoading = false.obs;
  final error = RxnString();

  @override
  void onInit() {
    super.onInit();
    final user = AuthController.to.user;
    if (user != null) {
      _bindNotes(user.uid);
    }
    ever(AuthController.to.userRx, (UserModel? user) {
      if (user != null) {
        _bindNotes(user.uid);
      } else {
        notes.clear();
      }
    });
  }

  void _bindNotes(String userId) {
    isLoading.value = true;
    _noteService
        .getUserNotes(userId)
        .listen(
          (noteList) {
            notes.assignAll(noteList);
            isLoading.value = false;
          },
          onError: (e) {
            error.value = e.toString();
            isLoading.value = false;
          },
        );
  }

  Future<void> addNote(String title, String message) async {
    try {
      final user = AuthController.to.user;
      if (user == null) throw Exception('User not logged in');
      final note = NoteModel(
        id: '',
        title: title,
        message: message,
        userId: user.uid,
        timestamp: DateTime.now(),
      );
      await _noteService.addNote(note);
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      await _noteService.updateNote(note);
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _noteService.deleteNote(noteId);
    } catch (e) {
      error.value = e.toString();
    }
  }
}
