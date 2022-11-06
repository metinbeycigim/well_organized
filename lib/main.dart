import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:well_organized/constants/app_colors.dart';
import 'package:well_organized/services/firebase_auth_service.dart';
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
  @override
  Widget build(BuildContext context) {
    final userStream = ref.watch(FirebaseAuthService.authStateProvider);
    final GoRouter router = GoRouter(
      initialLocation: userStream.value == null ? '/login' : '/',
      routes: Routes.instance.routes,
    );
    return MaterialApp.router(
      routerConfig: router,
      // home: userStream.value == null ? const LoginScreen() : const HomeScreen(),
      theme: ThemeData(
          canvasColor: AppColors.widgetBackgroundColor,
          inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              labelStyle: TextStyle(color: AppColors.inputLabelColor),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: AppColors.selectedItemColor,
            unselectedItemColor: AppColors.unselectedItemColor,
            selectedIconTheme: IconThemeData(size: 40),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          scaffoldBackgroundColor: AppColors.backgroundColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.buttonColor),
                foregroundColor: MaterialStateProperty.resolveWith((states) => AppColors.buttonIconColor)),
          ),
          textTheme: GoogleFonts.montserratTextTheme(),
          appBarTheme: AppBarTheme(
              iconTheme: const IconThemeData(color: AppColors.buttonColor),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              backgroundColor: AppColors.widgetBackgroundColor,
              titleTextStyle: GoogleFonts.montserrat(
                color: AppColors.titleTextColor,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ))),
      debugShowCheckedModeBanner: false,
      title: 'Well Organized',
    );
  }
}
