import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class NoteService {
  final CollectionReference notesCollection = FirebaseFirestore.instance
      .collection('notes');

  Stream<List<NoteModel>> getUserNotes(String userId) {
    return notesCollection
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
        );
  }

  Future<void> addNote(NoteModel note) async {
    await notesCollection.add({
      'title': note.title,
      'message': note.message,
      'userId': note.userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateNote(NoteModel note) async {
    await notesCollection.doc(note.id).update(note.toMap());
  }

  Future<void> deleteNote(String noteId) async {
    await notesCollection.doc(noteId).delete();
  }
}
