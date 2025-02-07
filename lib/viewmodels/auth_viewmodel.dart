import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;
  String? _errorMessage;

  AuthViewModel(this._authService);

  String? get errorMessage => _errorMessage;

  Future<void> signIn(String email, String password) async {
    try {
      _errorMessage = null;
      await _authService.signIn(email, password);
      notifyListeners();
    } catch (e) {
      _errorMessage = e
          .toString()
          .replaceAll("Exception: ", ""); // Remove 'Exception' prefix
      notifyListeners();
      throw Exception(_errorMessage); // Re-throw for UI to catch
    }
  }

  Future<void> register(String email, String password) async {
    try {
      _errorMessage = null;
      await _authService.register(email, password);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
      notifyListeners();
      throw Exception(_errorMessage);
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }
}
