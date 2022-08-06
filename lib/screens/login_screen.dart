import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/constants/titles.dart';
import 'package:well_organized/services/riverpod_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    final signInInstance = ref.read(RiverpodService.firebaseAuthProvider);

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(Titles.appTitle),
          ),
          body: SingleChildScrollView(
            
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: usernameController,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter your username',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: passwordController,
                    autocorrect: false,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      suffix: IconButton(
                        onPressed: () => setState(() {
                          isObscure = !isObscure;
                        }),
                        icon: isObscure ? const Icon(Icons.visibility_sharp) : const Icon(Icons.visibility_off_sharp),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter your secure password',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () async {
                      usernameController.text.isNotEmpty
                          ? await signInInstance.signIn(
    //////////*! autocomplete for email domain to use only username. It only works in this specific app. Not for general use!!!!!!
                              ('${usernameController.text.trim()}@test.com'),
                              passwordController.text.trim(),
                              context)
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
      ),
    );
  }
}
