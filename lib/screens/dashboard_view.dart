import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/expense_viewmodel.dart';
import 'add_expense_view.dart';
import 'currency_conversion_view.dart';
import '../models/expense.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseViewModel = Provider.of<ExpenseViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Total Expenses',
                      style: Theme.of(context).textTheme.titleLarge),
                  Text('\$${expenseViewModel.totalExpenses.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenseViewModel.expenses.length,
              itemBuilder: (context, index) {
                final expense = expenseViewModel.expenses[index];
                return Dismissible(
                  key: Key(expense.hashCode.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    expenseViewModel.deleteExpense(expense);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${expense.description} deleted')),
                    );
                  },
                  child: ListTile(
                    title: Text(expense.description),
                    subtitle: Text(expense.category),
                    trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrencyConversionView()),
                );
              },
              child: Text('Currency Conversion'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseView()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
