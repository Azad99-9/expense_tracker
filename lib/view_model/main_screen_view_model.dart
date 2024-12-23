import 'package:stacked/stacked.dart';

class MainScreenViewModel extends BaseViewModel {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void onTabSelected(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
