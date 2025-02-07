import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  bool _isLoading = false; // 🔥 Track loading state

  void _submit() async {
    if (_descController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _categoryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() => _isLoading = true); // 🔥 Show loading state

    try {
      final provider = Provider.of<ExpenseProvider>(context, listen: false);
      await Future.delayed(Duration(seconds: 2)); // Simulate a network delay
      provider.addExpense(Expense(
        description: _descController.text,
        amount: double.parse(_amountController.text),
        category: _categoryController.text,
        date: DateTime.now(),
      ));
      Navigator.pop(context); // Close the screen after saving
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false); // 🔥 Reset loading state
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expensess')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Description')),
            TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number),
            TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category')),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    child: Text('Save'),
                  ),
          ],
        ),
      ),
    );
  }
}
