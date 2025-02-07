import 'package:flutter/foundation.dart';
import '../services/currency_service.dart';

class CurrencyViewModel extends ChangeNotifier {
  final CurrencyService _currencyService;
  Map<String, double> _exchangeRates = {};
  bool _isLoading = true;
  String? _error;

  CurrencyViewModel(this._currencyService) {
    _loadExchangeRates();
  }

  Map<String, double> get exchangeRates => _exchangeRates;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<String> get availableCurrencies => _exchangeRates.isEmpty
      ? ['USD', 'EUR', 'GBP', 'JPY']
      : _exchangeRates.keys.toList()
    ..sort();

  Future<void> _loadExchangeRates() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _exchangeRates = await _currencyService.fetchExchangeRates();
      _error = null;
    } catch (e) {
      _error = 'Failed to load exchange rates: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshExchangeRates() async {
    await _loadExchangeRates();
  }

  double convert(double amount, String fromCurrency, String toCurrency) {
    return _currencyService.convert(
        amount, fromCurrency, toCurrency, _exchangeRates);
  }
}
