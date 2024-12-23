import 'package:expense_tracker/constants/routes.dart';
import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/models/user_model.dart';
import 'package:expense_tracker/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignupViewModel extends BaseViewModel {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController dailyThresoldController;
  late final TextEditingController monthlyThresoldController;

  late final User userDetails;

  void initialise(User user) {
    userDetails = user;
    nameController = TextEditingController(text: userDetails.displayName ?? '');
    dailyThresoldController = TextEditingController(text: '');
    monthlyThresoldController = TextEditingController(text: '');
    emailController = TextEditingController(text: userDetails.email);
  }


  bool isLoading = false;
  void submit() async {
    isLoading = true;
    notifyListeners();
    try {
      await UserService.createNewUser(
        UserModel(
          uid: userDetails.uid,
          name: nameController.text,
          email: emailController.text,
          dailyThresold: dailyThresoldController.text,
          monthlyThresold: monthlyThresoldController.text,
        ),
      );
      navigationService.pushReplacementNamed(Routes.mainScreen);
    } catch (e) {
      print(e.toString());
    }
    
    isLoading = false;
    notifyListeners();
  }
}
