import 'package:hive/hive.dart';

part 'expense.g.dart'; // Generated file

@HiveType(typeId: 2) // Unique ID for this type
class Expense {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String description;

  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.description,
  });

  // From JSON constructor
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      title: json['title'] as String,
      amount: json['amount'] as double,
      category: json['category'] as String,
      date: DateTime.parse(json['date'] as String), 
      description: json['description'] as String,
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(), 
      'description': description,
    };
  }
}

@HiveType(typeId: 3)  // Unique typeId for Expenses class
class Expenses {
  @HiveField(0)
  List<Expense> expenses;

  Expenses({required this.expenses});
}
