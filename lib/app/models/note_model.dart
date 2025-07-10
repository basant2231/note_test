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
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
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

  NoteModel copyWith({
    String? id,
    String? title,
    String? message,
    String? userId,
    DateTime? timestamp,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
