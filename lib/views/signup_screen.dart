import 'package:expense_tracker/services/size_config.dart';
import 'package:expense_tracker/view_model/signup_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class SignupScreen extends StackedView<SignupViewModel> {
  final User user;

  SignupScreen({
    required this.user,
  });
  @override
  SignupViewModel viewModelBuilder(BuildContext context) => SignupViewModel();

  @override
  void onViewModelReady(SignupViewModel viewModel) {
    viewModel.initialise(user);
  }

  @override
  Widget builder(BuildContext context, SignupViewModel model, Widget? child) {
    final themeService = Theme.of(context);
    final colorScheme = themeService.colorScheme;
    final textScheme = themeService.textTheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.07,
            ),
            Container(
              height: SizeConfig.screenHeight * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          child: SvgPicture.asset('assets/svgs/logo.svg'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Expense",
                            textAlign: TextAlign.center,
                            style: textScheme.displayMedium),
                        Text("Tracker",
                            textAlign: TextAlign.center,
                            style: textScheme.displayMedium),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                        child: Column(
                      children: <Widget>[
                        customTextFormField(
                          colorScheme: colorScheme,
                          focus: FocusNode(),
                          controller: model.nameController,
                          title: 'Name',
                          enabled: true,
                          icon: Icons.person,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        customTextFormField(
                          colorScheme: colorScheme,
                          focus: FocusNode(),
                          controller: model.emailController,
                          title: 'Email',
                          enabled: false,
                          icon: Icons.email,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        customTextFormField(
                            colorScheme: colorScheme,
                            focus: FocusNode(),
                            controller: model.dailyThresoldController,
                            title: 'Dialy Expense',
                            enabled: true,
                            icon: Icons.attach_money_outlined),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        customTextFormField(
                            colorScheme: colorScheme,
                            controller: model.monthlyThresoldController,
                            focus: FocusNode(),
                            enabled: true,
                            title: 'Monthly Expense',
                            icon: Icons.attach_money_outlined),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              model.submit();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(130, 50),
                              elevation: 0,
                              backgroundColor: colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    18), // Rounded corners
                                // side: BorderSide(
                                //   color: colorScheme
                                //       .secondaryBackgroundColor, // Border color
                                //   width: 0, // Border width
                                // ),
                              ),
                            ),
                            child: model.isLoading
                                ? Container(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(color: colorScheme.primary,),
                                  )
                                : Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class customTextFormField extends StatelessWidget {
  const customTextFormField({
    super.key,
    required this.colorScheme,
    required this.focus,
    required this.controller,
    required this.title,
    required this.enabled,
    required this.icon,
  });

  final ColorScheme colorScheme;
  final FocusNode focus;
  final TextEditingController controller;
  final String title;
  final bool enabled;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: colorScheme.onPrimary,
      controller: controller,
      focusNode: focus,
      readOnly: !enabled,
      enabled: enabled,
      onTap: () {},
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        prefixIconColor: colorScheme.onPrimary,
        labelText: title,
        labelStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 20,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: colorScheme.onPrimary,
        )),
      ),
    );
  }
}
