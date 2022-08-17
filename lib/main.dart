import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:well_organized/constants/app_colors.dart';
import 'package:well_organized/screens/home_screen.dart';

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
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(
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
