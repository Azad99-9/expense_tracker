import 'package:hive/hive.dart';

part 'day.g.dart'; // Required for code generation

@HiveType(typeId: 1) // Assign a unique typeId for this model
class Day {
  @HiveField(0)
  final String money;

  @HiveField(1)
  final List<String> expenses; // List of expense titles (max 3)

  @HiveField(2)
  final String individualKey;

  Day({
    required this.money,
    required this.expenses,
    required this.individualKey,
  });

  // From JSON constructor
  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      money: json['money'] as String,
      expenses: List<String>.from(json['expenses'] ?? []),
      individualKey: json['individualKey'] as String,
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'money': money,
      'expenses': expenses,
      'individualKey': individualKey,
    };
  }
}

@HiveType(typeId: 4)  // Unique typeId for Days class
class Days {
  @HiveField(0)
  List<Day?> days;

  Days({required this.days});
}
