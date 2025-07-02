import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String title;
  final String message;
  final String userId;
  final DateTime timestamp;

  NoteModel({
    required this.id,
    required this.title,
    required this.message,
    required this.userId,
    required this.timestamp,
  });

  factory NoteModel.fromMap(Map<String, dynamic> data, String documentId) {
    return NoteModel(
      id: documentId,
      title: data['title'] ?? '',
      message: data['message'] ?? '',
      userId: data['userId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'userId': userId,
      'timestamp': timestamp,
    };
  }
}
