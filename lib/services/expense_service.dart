import 'package:hive/hive.dart';
import '../models/expense.dart';

class ExpenseService {
  static const String _boxName = 'expenses';

  Future<void> addExpense(Expense expense) async {
    final box = await Hive.openBox<Expense>(_boxName);
    await box.add(expense);
  }

  Future<void> deleteExpense(Expense expense) async {
    final box = await Hive.openBox<Expense>(_boxName);
    final expenseToDelete = box.values.firstWhere((e) =>
        e.description == expense.description &&
        e.amount == expense.amount &&
        e.category == expense.category &&
        e.date == expense.date);
    await expenseToDelete.delete();
  }

  Future<List<Expense>> getExpenses() async {
    final box = await Hive.openBox<Expense>(_boxName);
    return box.values.toList();
  }

  Future<double> getTotalExpenses() async {
    final expenses = await getExpenses();
    return expenses.fold<double>(0, (sum, expense) => sum + expense.amount);
  }
}
