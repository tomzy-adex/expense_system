import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/auth_screen.dart';
import 'package:expense_tracker/screens/add_expense_screen.dart';
import 'package:expense_tracker/screens/add_expense_view.dart';
import 'package:expense_tracker/screens/dashboard_view.dart';

class AppRoutes {
  static const String authScreen = '/';
  static const String addExpenseScreen = '/add-expense';
  static const String addExpenseViewScreen = '/add-expense-view';
  static const String dashboardScreen = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authScreen:
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case dashboardScreen:
        return MaterialPageRoute(builder: (_) => DashboardView());
      case addExpenseScreen:
        return MaterialPageRoute(builder: (_) => AddExpenseScreen());
      case addExpenseViewScreen:
        return MaterialPageRoute(builder: (_) => AddExpenseView());
      default:
        return MaterialPageRoute(builder: (_) => AuthScreen()); // Default route
    }
  }
}
