import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String id;
  final String task;
  final bool isDone;
  final Timestamp? createdAt;

  Todo({
    required this.id,
    required this.task,
    required this.isDone,
    this.createdAt,
  });

  factory Todo.fromFirestore(DocumentSnapshot doc) {
    final data = (doc.data() as Map<String, dynamic>?) ?? {};
    return Todo(
      id: doc.id,
      task: data['task'] as String? ?? '',
      isDone: data['isDone'] as bool? ?? false,
      createdAt: data['createdAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task': task,
      'isDone': isDone,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
