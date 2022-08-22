import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:well_organized/constants/app_colors.dart';
import 'package:well_organized/screens/home_screen.dart';
import 'package:well_organized/screens/login_screen.dart';
import 'package:well_organized/services/routes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool isSignedIn = false;
  @override
  Widget build(BuildContext context) {
    
    final userStream = ref.watch(firebaseAuthProvider).firebaseAuth.authStateChanges().listen((user) {
      user == null ? isSignedIn = false : true;
      print(isSignedIn);
      setState(() {});
    });

    return MaterialApp(
      //! signup goes to homescreen as well. after signup loginscreen should be shown.
      home: isSignedIn ? const HomeScreen() : const LoginScreen(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: inputLabelColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: widgetBackgroundColor,
          selectedItemColor: selectedItemColor,
          unselectedItemColor: unselectedItemColor,
          selectedIconTheme: IconThemeData(size: 40),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        scaffoldBackgroundColor: backgroundColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) => buttonColor),
              foregroundColor: MaterialStateProperty.resolveWith((states) => buttonIconColor)),
        ),
        textTheme: GoogleFonts.montserratTextTheme(),
        appBarTheme: AppBarTheme(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            backgroundColor: widgetBackgroundColor,
            titleTextStyle: GoogleFonts.montserrat(
              color: titleTextColor,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            actionsIconTheme: const IconThemeData(
              color: titleTextColor,
            )),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Well Organized',
    );
  }
}
