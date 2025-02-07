import 'package:flutter/foundation.dart';
import '../services/expense_service.dart';
import '../models/expense.dart';
import 'currency_viewmodel.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseService _expenseService;
  final CurrencyViewModel _currencyViewModel;
  List<Expense> _expenses = [];
  double _totalExpenses = 0;

  ExpenseViewModel(this._expenseService, this._currencyViewModel) {
    _loadExpenses();
  }

  List<Expense> get expenses => _expenses;
  double get totalExpenses => _totalExpenses;

  Future<void> _loadExpenses() async {
    _expenses = await _expenseService.getExpenses();
    _totalExpenses = await _expenseService.getTotalExpenses();
    notifyListeners();
  }

  Future<void> refreshExpenses() async {
    await _loadExpenses();
  }

  Future<void> addExpense(Expense expense) async {
    await _expenseService.addExpense(expense);
    await _loadExpenses();
  }

  Future<void> deleteExpense(Expense expense) async {
    await _expenseService.deleteExpense(expense);
    await _loadExpenses();
  }

  double getConvertedTotalExpenses(String targetCurrency) {
    return _currencyViewModel.convert(_totalExpenses, 'USD', targetCurrency);
  }

  List<Expense> getConvertedExpenses(String targetCurrency) {
    return _expenses.map((expense) {
      double convertedAmount =
          _currencyViewModel.convert(expense.amount, 'USD', targetCurrency);
      return Expense(
        description: expense.description,
        amount: convertedAmount,
        category: expense.category,
        date: expense.date,
      );
    }).toList();
  }
}
