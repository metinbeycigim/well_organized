import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:well_organized/services/firebase_auth_service.dart';

import '../constants/app_colors.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.emailController,

    required this.passwordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        emailController.text.isNotEmpty
            ? await FirebaseAuthService().signIn(emailController.text.trim(), passwordController.text.trim(), context)
            :  Fluttertoast.showToast(
        msg: 'Please enter a valid email address',
        textColor: toastTextColor,
        backgroundColor: toastBackgroundColor,
        toastLength: Toast.LENGTH_LONG,
      );
      },
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}