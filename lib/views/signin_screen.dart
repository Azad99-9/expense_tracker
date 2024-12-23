// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:expense_tracker/constants/routes.dart';
// import 'package:expense_tracker/locator.dart';
// import 'package:expense_tracker/services/notification_services.dart';
// import 'package:expense_tracker/services/theme_service.dart';
// import 'package:expense_tracker/services/size_config.dart';
// import 'package:expense_tracker/services/user_service.dart';

// class SigninPage extends StatefulWidget {
//   const SigninPage({super.key});

//   @override
//   State<SigninPage> createState() => _SigninPageState();
// }

// class _SigninPageState extends State<SigninPage> {
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.init(context);
//     return Scaffold(
//       backgroundColor: ThemeService.secondaryColor,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               width: 140,
//               height: 140,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: const AssetImage('assets/images/logo.png'),
//                 ),
//               ),
//             ),
//             const Text(
//               "RGUKT",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xff00444E),
//               ),
//             ),
//             const Text(
//               "Mess Management System",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xff00444E),
//               ),
//             ),

//             // SizedBox(
//             //   height: SizeConfig.screenHeight * 0.35,
//             //   child: Stack(
//             //     children: <Widget>[
//             //
//             //     ],
//             //   ),
//             // ),
//             SizedBox(
//               height: SizeConfig.screenHeight * 0.05,
//             ),

//             ElevatedButton(
//               onPressed: () async {
//                 setState(() {
//                   isLoading = true;
//                 });
//                 final userData = await userService.googleSignIn();
//                 if (userService.loggedIn) {
//                   final docRef = FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(userData?.uid);
//                   final DocumentSnapshot snapshot = await docRef.get();
//                   if (!snapshot.exists) {
//                     navigationService.pushReplacementScreen(Routes.signUp,
//                         arguments: userData);
//                   } else {
//                     final FCS_TOKEN = await NotificationServices().getToken();
//                     print("in sign in page $FCS_TOKEN");
//                     await docRef.update({'FCS_TOKEN': FCS_TOKEN});
//                     navigationService.pushReplacementScreen(Routes.home);
//                   }
//                 }
//                 setState(() {
//                   isLoading = false;
//                 });
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.all(0),
//                 maximumSize: const Size(300, 200),
//                 minimumSize: const Size(100, 50),
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),

//                 ),
//               ),
//               child: isLoading
//                   ? Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(width: 30, height: 30, child: CircularProgressIndicator(),)
//                       ],
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         CircleAvatar(
//                           radius: 12,
//                           backgroundImage: NetworkImage(
//                               'https://th.bing.com/th/id/OIP.IcreJX7hnOjNYRnlo4DCWwHaE8?rs=1&pid=ImgDetMain'),
//                         ),
//                         SizedBox(width: 8,),
//                         Text(
//                           "Continue with Google",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//             SizedBox(
//               height: SizeConfig.screenHeight * 0.01,
//             ),

//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:expense_tracker/view_model/signin_view_model_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class SignIn extends StackedView<SigninViewModel> {
  @override
  SigninViewModel viewModelBuilder(BuildContext context) => SigninViewModel();

  @override
  Widget builder(BuildContext context, SigninViewModel model, Widget? child) {
    final themeService = Theme.of(context);
    final colorScheme = themeService.colorScheme;
    final textScheme = themeService.textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(height: 20,),
                  Text(
                    "Expense",
                    textAlign: TextAlign.center,
                    style: textScheme.displayMedium
                  ),
                  Text(
                    "Tracker",
                    textAlign: TextAlign.center,
                    style: textScheme.displayMedium
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
          
              onPressed: () async {
                model.signIn();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                backgroundColor: colorScheme.tertiary.withOpacity(0.3),
                maximumSize: const Size(300, 200),
                minimumSize: const Size(100, 50),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: model.isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(color: colorScheme.onPrimary,),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                              'https://th.bing.com/th/id/OIP.IcreJX7hnOjNYRnlo4DCWwHaE8?rs=1&pid=ImgDetMain'),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Continue with Google",
                          style: textScheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)
                          
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
