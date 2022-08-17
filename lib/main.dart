import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:well_organized/constants/app_colors.dart';
import 'package:well_organized/screens/home_screen.dart';
import 'package:well_organized/screens/login_screen.dart';
import 'package:well_organized/services/riverpod_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  static const String title = 'Well Organized';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(RiverpodService.authStateProvider);
    return MaterialApp(
      home: authState.value == null ? const LoginScreen() : const HomeScreen(),
      theme: ThemeData(
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
      title: title,
    );
  }
}
