import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:well_organized/services/firebase_auth_service.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
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
        try {
          await FirebaseAuthService().signUp(emailController.text.trim(), passwordController.text.trim(), context);
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$e'),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: const Text(
        'Sign Up',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
