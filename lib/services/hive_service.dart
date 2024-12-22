import 'package:expense_tracker/constants/hive_key.dart';
import 'package:expense_tracker/models/day/day.dart';
import 'package:expense_tracker/models/expense/expense.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  /// Initialize Hive with path setup
  static Future<void> initializeHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(DayAdapter());
    Hive.registerAdapter(ExpenseAdapter());
    Hive.registerAdapter(ExpensesAdapter());
    // Hive.registerAdapter(Days());

    await openBox<Expenses>(HiveKeys.dayExpenses);
    await openBox<Days>(HiveKeys.expenseCells);
  }

  /// Open a Hive box
  static Future<Box<T>> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  /// Add a new item to the Hive box
  static void putItem<T>(Box<T> box, String key, T item) async {
    await box.put(key, item);
  }

  static T? getItem<T>(Box<T?> box, String key) {
    return box.get(key);
  }

  /// Update an item in the Hive box
  static Future<void> updateItem<T>(String boxName, int index, T item) async {
    final box = await openBox<T>(boxName);
    await box.putAt(index, item);
  }

  /// Delete an item from the Hive box
  static void deleteItem<T>(Box<T> box, String key) {
    box.delete(key);
  }

  /// Retrieve all items from the Hive box
  static Future<List<T>> getAllItems<T>(String boxName) async {
    final box = await openBox<T>(boxName);
    return box.values.toList();
  }

  /// Close a Hive box
  static Future<void> closeBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }
  }

  /// Delete a Hive box
  static Future<void> deleteBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).deleteFromDisk();
    }
  }
}
