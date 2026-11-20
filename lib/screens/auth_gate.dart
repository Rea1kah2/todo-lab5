import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'signin_screen.dart';
import 'todo_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // Tampilkan loading saat status autentikasi sedang dimuat
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Tampilkan pesan jika terjadi kesalahan stream
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Terjadi kesalahan koneksi autentikasi:\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // Jika user sudah login (memiliki data sesi)
        if (snapshot.hasData) {
          return TodoScreen();
        }

        // Jika user belum login
        return const SignInScreen();
      },
    );
  }
}
