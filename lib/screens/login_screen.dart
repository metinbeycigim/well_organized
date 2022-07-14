import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/constants/text_editing_controllers.dart';
import 'package:well_organized/constants/titles.dart';
import 'package:well_organized/services/riverpod_service.dart';
import 'package:well_organized/widgets/build_text_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInInstance = ref.read(RiverpodService.firebaseAuthProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Titles.appTitle),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150.0,
                width: 190.0,
                padding: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
              BuildTextField(
                'E-mail',
                'Enter a valid email',
                TextEditingControllers.emailController,
                false,
              ),
              BuildTextField(
                'Password',
                'Enter your secure password',
                TextEditingControllers.passwordController,
                true,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    TextEditingControllers.emailController.text.isNotEmpty
                        ? await signInInstance.signIn(TextEditingControllers.emailController.text.trim(),
                            TextEditingControllers.passwordController.text.trim(), context)
                        : ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a valid email address'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
