import 'package:get/get.dart';
import '../models/note_model.dart';
import '../models/user_model.dart';
import '../services/note_service.dart';
import 'auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteController extends GetxController {
  final notes = <NoteModel>[].obs;
  final isLoading = false.obs;
  final error = RxnString();

  @override
  void onInit() {
    super.onInit();
    final user = AuthController.to.user;
    if (user != null) {
      _bindNotesStream(user.uid);
    }
    ever(AuthController.to.userRx, (UserModel? user) {
      if (user != null) {
        _bindNotesStream(user.uid);
      } else {
        notes.clear();
      }
    });
  }

  void _bindNotesStream(String userId) {
    isLoading.value = true;
    notes.bindStream(
      FirebaseFirestore.instance
          .collection('notes')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs
                    .map(
                      (doc) => NoteModel.fromMap(
                        doc.data() as Map<String, dynamic>,
                        doc.id,
                      ),
                    )
                    .toList(),
          ),
    );
    isLoading.value = false;
  }

  Future<void> addNote(String title, String message) async {
    try {
      final user = AuthController.to.user;
      if (user == null) throw Exception('User not logged in');
      await FirebaseFirestore.instance.collection('notes').add({
        'title': title,
        'message': message,
        'userId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(note.id)
          .update(note.toMap());
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await FirebaseFirestore.instance.collection('notes').doc(noteId).delete();
    } catch (e) {
      error.value = e.toString();
    }
  }
}
