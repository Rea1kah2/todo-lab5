import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/firestore_service.dart';
import '../widgets/todo_dialog.dart';
import '../widgets/todo_item.dart';
import 'profile_screen.dart';

class TodoScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: 'Profil',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: _firestoreService.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi error: ${snapshot.error}'),
            );
          }

          final todos = snapshot.data ?? [];

          if (todos.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada catatan tugas.\nTekan tombol + untuk menambahkan.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.separated(
            itemCount: todos.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoItem(
                todo: todo,
                firestoreService: _firestoreService,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                TodoDialog(firestoreService: _firestoreService),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
