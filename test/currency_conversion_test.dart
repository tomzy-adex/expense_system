import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:expense_tracker/services/currency_service.dart';
import 'package:expense_tracker/viewmodels/currency_viewmodel.dart';

class MockCurrencyService extends Mock implements CurrencyService {}

void main() {
  group('CurrencyViewModel Tests', () {
    late CurrencyViewModel currencyViewModel;
    late MockCurrencyService mockCurrencyService;

    setUp(() {
      mockCurrencyService = MockCurrencyService();
      currencyViewModel = CurrencyViewModel(mockCurrencyService);
    });

    test('Loading exchange rates should update the view model', () async {
      final mockRates = {
        'USD': 1.0,
        'EUR': 0.85,
        'GBP': 0.72,
      };

      when(mockCurrencyService.fetchExchangeRates())
          .thenAnswer((_) async => mockRates);

      await currencyViewModel.refreshExchangeRates();

      expect(currencyViewModel.exchangeRates, mockRates);
    });

    test('Currency conversion should work correctly', () async {
      final mockRates = {
        'USD': 1.0,
        'EUR': 0.85,
        'GBP': 0.72,
      };

      when(mockCurrencyService.fetchExchangeRates())
          .thenAnswer((_) async => mockRates);
      await currencyViewModel.refreshExchangeRates();

      expect(currencyViewModel.convert(100, 'USD', 'EUR'), closeTo(85.0, 0.01));
      expect(currencyViewModel.convert(100, 'USD', 'GBP'), closeTo(72.0, 0.01));
      expect(
          currencyViewModel.convert(100, 'EUR', 'USD'), closeTo(117.65, 0.01));
    });
  });
}
