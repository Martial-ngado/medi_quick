import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _userId;
  String? _userName;
  String? _userEmail;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  AuthProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _userName = prefs.getString('userName');
    _userEmail = prefs.getString('userEmail');
    _isLoggedIn = _userId != null;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    try {
      // Simulation d'une connexion (à remplacer par votre API)
      await Future.delayed(const Duration(seconds: 1));
      
      _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
      _userName = email.split('@')[0];
      _userEmail = email;
      _isLoggedIn = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', _userId!);
      await prefs.setString('userName', _userName!);
      await prefs.setString('userEmail', _userEmail!);

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      // Simulation d'une inscription (à remplacer par votre API)
      await Future.delayed(const Duration(seconds: 1));
      
      _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
      _userName = name;
      _userEmail = email;
      _isLoggedIn = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', _userId!);
      await prefs.setString('userName', _userName!);
      await prefs.setString('userEmail', _userEmail!);

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    _userId = null;
    _userName = null;
    _userEmail = null;
    _isLoggedIn = false;
    
    notifyListeners();
  }
}
