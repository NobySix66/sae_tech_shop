import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _username;

  String? get username => _username;
  bool get isLoggedIn => _username != null;

  final Map<String, String> _users = {}; // username : password

  // ================= LOGIN (BYPASS UNTUK TUGAS) =================
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simulasi API

    username = username.trim();
    
    // Bypass: Jika input tidak kosong, izinkan masuk tanpa cek database/map
    if (username.isNotEmpty && password.isNotEmpty) {
      _username = username;
      notifyListeners();
      return true;
    }

    return false;
  }

  // ================= REGISTER =================
  Future<bool> register(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    username = username.trim();

    if (username.isEmpty || password.isEmpty) return false;
    
    // Tetap simpan ke map jika ingin simulasi regis
    if (!_users.containsKey(username)) {
      _users[username] = password;
    }
    
    _username = username;
    notifyListeners();
    return true;
  }

  // ================= LOGOUT =================
  void logout() {
    _username = null;
    notifyListeners();
  }

  // ================= UPDATE USERNAME =================
  void updateUsername(String newUsername) {
    if (_username == null) return;

    newUsername = newUsername.trim();
    if (newUsername.isEmpty) return;

    _username = newUsername;
    notifyListeners();
  }
}
