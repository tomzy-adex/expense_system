import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/expense_viewmodel.dart';
import '../viewmodels/currency_viewmodel.dart';
import '../models/expense.dart';

class AddExpenseView extends StatefulWidget {
  @override
  _AddExpenseViewState createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  String _selectedCurrency = 'USD';
  bool _isLoading = false;

  void _submitExpense() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true); // 🔥 Show loading state

    final expenseViewModel =
        Provider.of<ExpenseViewModel>(context, listen: false);
    final currencyViewModel =
        Provider.of<CurrencyViewModel>(context, listen: false);

    double amount = double.parse(_amountController.text);

    if (_selectedCurrency != 'USD') {
      amount = currencyViewModel.convert(amount, _selectedCurrency, 'USD');
    }

    final expense = Expense(
      description: _descriptionController.text.trim(),
      amount: amount,
      category: _categoryController.text.trim(),
      date: DateTime.now(),
    );

    await Future.delayed(Duration(seconds: 2)); // Simulating a delay

    expenseViewModel.addExpense(expense);

    setState(() => _isLoading = false); // 🔥 Hide loading state

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final currencyViewModel = Provider.of<CurrencyViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onChanged: (_) => setState(() {}),
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an amount';
                  }
                  final parsedValue = double.tryParse(value);
                  if (parsedValue == null) {
                    return 'Please enter a valid number';
                  }
                  if (parsedValue <= 0) {
                    return 'Amount must be greater than 0';
                  }
                  return null;
                },
                onChanged: (_) => setState(() {}),
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
                onChanged: (_) => setState(() {}),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCurrency,
                decoration: InputDecoration(labelText: 'Currency'),
                items: currencyViewModel.availableCurrencies
                    .map((currency) => DropdownMenuItem(
                          value: currency,
                          child: Text(currency),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCurrency = value!;
                  });
                },
              ),
              SizedBox(height: 24),
              _isLoading
                  ? CircularProgressIndicator() // 🔥 Show loading indicator
                  : ElevatedButton(
                      onPressed: _formKey.currentState?.validate() == true
                          ? _submitExpense
                          : null, // 🔥 Disable button if form is invalid
                      child: Text('Add Expense'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
