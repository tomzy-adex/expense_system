import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyService {
  static const String _apiKey =
      '4d4fc9fc0809491ca4c3a9b01bfa7c75'; // Replace with your OpenExchangeRates API key
  static const String _baseUrl =
      'https://openexchangerates.org/api/latest.json';
  static const String _cacheKey = 'exchange_rates_cache';
  static const Duration _cacheDuration = Duration(hours: 1);

  Future<Map<String, double>> fetchExchangeRates() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_cacheKey);

    if (cachedData != null) {
      final cachedTime = prefs.getInt('${_cacheKey}_time');
      if (cachedTime != null &&
          DateTime.now()
                  .difference(DateTime.fromMillisecondsSinceEpoch(cachedTime)) <
              _cacheDuration) {
        return Map<String, double>.from(json.decode(cachedData));
      }
    }

    final response = await http.get(Uri.parse('$_baseUrl?app_id=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rates = (data['rates'] as Map<String, dynamic>).map(
        (key, value) =>
            MapEntry(key, (value is int) ? value.toDouble() : value as double),
      );

      // Cache the new data
      await prefs.setString(_cacheKey, json.encode(rates));
      await prefs.setInt(
          '${_cacheKey}_time', DateTime.now().millisecondsSinceEpoch);

      return rates;
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  double convert(double amount, String fromCurrency, String toCurrency,
      Map<String, double> rates) {
    if (fromCurrency == toCurrency) return amount;

    final double fromRate = rates[fromCurrency] ?? 1;
    final double toRate = rates[toCurrency] ?? 1;

    return (amount / fromRate) * toRate;
  }
}
