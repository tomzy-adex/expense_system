import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'dashboard_view.dart';

import '../viewmodels/auth_viewmodel.dart';
import 'package:expense_tracker/screens/route/route.dart'; // Import AppRoutes

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLogin = true;

  void _submit() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      if (isLogin) {
        await authProvider.signIn(
            _emailController.text, _passwordController.text);
      } else {
        await authProvider.signUp(
            _emailController.text, _passwordController.text);
      }
      // Navigate to AddExpenseScreen using the named route
      Navigator.pushReplacementNamed(context, AppRoutes.dashboardScreen);
    } catch (error) {
      print(error.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Login' : 'Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
                // onPressed: _submit,
                onPressed: () async {
                  await authViewModel.signIn(
                    _emailController.text,
                    _passwordController.text,
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardView()),
                  );
                },
                child: Text(isLogin ? 'Login' : 'Sign Up')),
            TextButton(
              onPressed: () => setState(() => isLogin = !isLogin),
              child: Text(isLogin
                  ? 'Create Account'
                  : 'Already have an account? Login'),
            )
          ],
        ),
      ),
    );
  }
}
