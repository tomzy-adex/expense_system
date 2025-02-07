import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'dashboard_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLogin = true;
  bool _isLoading = false;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateInput);
    _passwordController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      _isValid = _isValidEmail(email) && password.length >= 6;
    });
  }

  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }

  Future<void> _handleAuth() async {
    if (!_isValid) return;

    setState(() => _isLoading = true);

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    try {
      if (isLogin) {
        await authViewModel.signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } else {
        await authViewModel.register(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardView()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Login' : 'Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _emailController.text.isNotEmpty &&
                        !_isValidEmail(_emailController.text)
                    ? 'Enter a valid email'
                    : null,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _passwordController.text.isNotEmpty &&
                        _passwordController.text.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            _isLoading
                ? CircularProgressIndicator() // 🔥 Show loading indicator
                : ElevatedButton(
                    onPressed: _isValid
                        ? _handleAuth
                        : null, // 🔥 Disable if input is invalid
                    child: Text(isLogin ? 'Login' : 'Sign Up'),
                  ),
            TextButton(
              onPressed: () => setState(() => isLogin = !isLogin),
              child: Text(
                isLogin
                    ? 'New user? Create Account'
                    : 'Already have an account? Login',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
