import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream status autentikasi user
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Mendapatkan user yang sedang aktif
  User? get currentUser => _auth.currentUser;

  // Masuk dengan email & password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Daftar akun baru dengan email & password
  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Keluar / Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
