import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  late Box<Expense> _expenseBox;

  List<Expense> get expenses => _expenses;

  Future<void> loadExpenses() async {
    _expenseBox = await Hive.openBox<Expense>('expenses');
    _expenses = _expenseBox.values.toList();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await _expenseBox.add(expense);
    _expenses.add(expense);
    notifyListeners();
  }
}
