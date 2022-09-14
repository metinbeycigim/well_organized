import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:well_organized/constants/app_colors.dart';
import 'package:well_organized/screens/home_screen.dart';
import 'package:well_organized/screens/login_screen.dart';
import 'package:well_organized/services/firebase_auth_service.dart';

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
  @override
  Widget build(BuildContext context) {
    final userStream = ref.watch(FirebaseAuthService.authStateProvider);

    return MaterialApp(
      home: userStream.value == null ? const LoginScreen() : const HomeScreen(),
      theme: ThemeData(
          canvasColor: widgetBackgroundColor,
          inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: inputLabelColor),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor), borderRadius: BorderRadius.all(Radius.circular(15)))),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
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
              iconTheme: const IconThemeData(color: buttonColor),
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
              ))),
      debugShowCheckedModeBanner: false,
      title: 'Well Organized',
    );
  }
}
