import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/constants/routes.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/locator.dart';
import 'package:expense_tracker/router.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:expense_tracker/services/navigation_service.dart';
import 'package:expense_tracker/services/notification_service.dart';
import 'package:expense_tracker/services/size_config.dart';
import 'package:expense_tracker/services/theme_service.dart';
import 'package:expense_tracker/services/user_service.dart';
import 'package:expense_tracker/views/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();

  await HiveService.initializeHive();

  await notificationService.initializeNotification();

  await AndroidAlarmManager.initialize();

  runApp(const MyApp());

  const int notificationId = 0;
  await AndroidAlarmManager.periodic(
    const Duration(
      hours: 24,
    ),
    notificationId,
    NotificationService.scheduleNotifications,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeService.lightTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.splashScreen,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    SizeConfig.init(context);
    return const MainScreen();
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Controls the opacity of the splash screen
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start the animation after the widget has been initialized
    _animateSplashScreen();
  }

  // Function to animate the splash screen
  Future<void> _animateSplashScreen() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // Delay before fade-in
    setState(() {
      _opacity = 1.0; // Change opacity to 1 to fade in
    });

    // Navigate to the next screen after a delay
    await Future.delayed(const Duration(seconds: 3));
    // Navigate to the home screen or main screen

    if (UserService.loggedIn) {
      bool userExists = await UserService.userExists();
      if (!userExists) {
        navigationService.pushReplacementNamed(Routes.signUp,
            arguments: UserService.currentUser);
      } else {
        navigationService.pushReplacementNamed(Routes.mainScreen);
      }
    } else {
      navigationService.pushReplacementNamed(Routes.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Theme.of(context);
    final colorScheme = themeService.colorScheme;
    final textScheme = themeService.textTheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1),
          // Animation duration for fade-in
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
