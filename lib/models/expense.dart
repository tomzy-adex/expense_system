import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  late String description;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late String category;

  @HiveField(3)
  late DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });
}
