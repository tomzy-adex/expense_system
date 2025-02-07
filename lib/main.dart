import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:expense_tracker/services/auth_service.dart';
import 'package:expense_tracker/services/expense_service.dart';
import 'package:expense_tracker/services/currency_service.dart';
import 'package:expense_tracker/viewmodels/auth_viewmodel.dart';
import 'package:expense_tracker/viewmodels/expense_viewmodel.dart';
import 'package:expense_tracker/viewmodels/currency_viewmodel.dart';
import 'package:expense_tracker/screens/login.dart';
import 'package:expense_tracker/models/expense.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  await Hive.openBox<Expense>('expenses');
  setupDependencies();
  runApp(MyApp());
}

void setupDependencies() {
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => ExpenseService());
  getIt.registerLazySingleton(() => CurrencyService());
  getIt
      .registerLazySingleton(() => CurrencyViewModel(getIt<CurrencyService>()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthViewModel(getIt<AuthService>())),
        ChangeNotifierProvider(create: (_) => getIt<CurrencyViewModel>()),
        ChangeNotifierProxyProvider<CurrencyViewModel, ExpenseViewModel>(
          create: (_) => ExpenseViewModel(
              getIt<ExpenseService>(), getIt<CurrencyViewModel>()),
          update: (_, currencyViewModel, previousExpenseViewModel) =>
              ExpenseViewModel(getIt<ExpenseService>(), currencyViewModel),
        ),
      ],
      child: MaterialApp(
        title: 'Expense Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginView(),
      ),
    );
  }
}
