import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/constants/routes.dart';
import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/services/user_service.dart';
import 'package:stacked/stacked.dart';

class SigninViewModel extends BaseViewModel {
  bool isLoading = false;

  Future<void> signIn() async {
    isLoading = true;
    notifyListeners();
    final userData = await UserService.googleSignIn();
    if (UserService.loggedIn) {
      bool userExists = await UserService.userExists();
      if (!userExists) {
        navigationService.pushReplacementNamed(
          Routes.signUp,
          arguments: userData,
        );
      } else {
        // final FCS_TOKEN = await NotificationServices().getToken();
        // print("in sign in page $FCS_TOKEN");
        // await docRef.update({'FCS_TOKEN': FCS_TOKEN});
        navigationService.pushReplacementNamed(Routes.mainScreen);
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
