import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:expense_tracker/services/expense_service.dart';
import 'package:expense_tracker/viewmodels/expense_viewmodel.dart';
import 'package:expense_tracker/viewmodels/currency_viewmodel.dart';
import 'package:expense_tracker/models/expense.dart';

class MockExpenseService extends Mock implements ExpenseService {}

class MockCurrencyViewModel extends Mock implements CurrencyViewModel {}

void main() {
  group('ExpenseViewModel Tests', () {
    late ExpenseViewModel expenseViewModel;
    late MockExpenseService mockExpenseService;
    late MockCurrencyViewModel mockCurrencyViewModel;

    setUp(() {
      mockExpenseService = MockExpenseService();
      mockCurrencyViewModel = MockCurrencyViewModel();
      expenseViewModel =
          ExpenseViewModel(mockExpenseService, mockCurrencyViewModel);
    });

    test('Adding an expense should update the list and total', () async {
      final expense = Expense(
        description: 'Test Expense',
        amount: 50.0,
        category: 'Test Category',
        date: DateTime.now(),
      );

      when(mockExpenseService.addExpense(expense))
          .thenAnswer((_) async => null);
      when(mockExpenseService.getExpenses()).thenAnswer((_) async => [expense]);
      when(mockExpenseService.getTotalExpenses()).thenAnswer((_) async => 50.0);

      await expenseViewModel.addExpense(expense);

      expect(expenseViewModel.expenses.length, 1);
      expect(expenseViewModel.totalExpenses, 50.0);
    });

    test('Loading expenses should update the view model', () async {
      final expenses = [
        Expense(
            description: 'Expense 1',
            amount: 50.0,
            category: 'Category 1',
            date: DateTime.now()),
        Expense(
            description: 'Expense 2',
            amount: 75.0,
            category: 'Category 2',
            date: DateTime.now()),
      ];

      when(mockExpenseService.getExpenses()).thenAnswer((_) async => expenses);
      when(mockExpenseService.getTotalExpenses())
          .thenAnswer((_) async => 125.0);

      await expenseViewModel.refreshExpenses();

      expect(expenseViewModel.expenses.length, 2);
      expect(expenseViewModel.totalExpenses, 125.0);
    });

    test('Converting total expenses should use CurrencyViewModel', () {
      when(mockCurrencyViewModel.convert(100.0, 'USD', 'EUR')).thenReturn(85.0);

      expenseViewModel =
          ExpenseViewModel(mockExpenseService, mockCurrencyViewModel);
      when(mockExpenseService.getTotalExpenses())
          .thenAnswer((_) async => 100.0);

      final convertedTotal = expenseViewModel.getConvertedTotalExpenses('EUR');

      expect(convertedTotal, 85.0);
      verify(mockCurrencyViewModel.convert(100.0, 'USD', 'EUR')).called(1);
    });
  });
}
