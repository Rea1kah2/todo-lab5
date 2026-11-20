import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 48,
                child: Icon(Icons.person, size: 48),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('Email'),
                        subtitle: Text(user?.email ?? 'Tidak diketahui'),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.vpn_key),
                        title: const Text('User ID'),
                        subtitle: Text(user?.uid ?? '-'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () async {
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                  await authService.signOut();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Keluar / Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
