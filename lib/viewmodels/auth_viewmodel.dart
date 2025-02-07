import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  AuthViewModel(this._authService);

  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signIn(email, password);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _authService.register(email, password);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }
}
