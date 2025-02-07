import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/currency_viewmodel.dart';

class CurrencyConversionView extends StatefulWidget {
  @override
  _CurrencyConversionViewState createState() => _CurrencyConversionViewState();
}

class _CurrencyConversionViewState extends State<CurrencyConversionView> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _convertedAmount = 0;

  @override
  Widget build(BuildContext context) {
    final currencyViewModel = Provider.of<CurrencyViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Currency Conversion')),
      body: currencyViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : currencyViewModel.error != null
              ? Center(child: Text(currencyViewModel.error!))
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _amountController,
                          decoration: InputDecoration(labelText: 'Amount'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an amount';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _fromCurrency,
                                decoration: InputDecoration(labelText: 'From'),
                                items: currencyViewModel.availableCurrencies
                                    .map((currency) => DropdownMenuItem(
                                          value: currency,
                                          child: Text(currency),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _fromCurrency = value!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _toCurrency,
                                decoration: InputDecoration(labelText: 'To'),
                                items: currencyViewModel.availableCurrencies
                                    .map((currency) => DropdownMenuItem(
                                          value: currency,
                                          child: Text(currency),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _toCurrency = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final amount =
                                  double.parse(_amountController.text);
                              setState(() {
                                _convertedAmount = currencyViewModel.convert(
                                  amount,
                                  _fromCurrency,
                                  _toCurrency,
                                );
                              });
                            }
                          },
                          child: Text('Convert'),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Converted Amount: ${_convertedAmount.toStringAsFixed(2)} $_toCurrency',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
