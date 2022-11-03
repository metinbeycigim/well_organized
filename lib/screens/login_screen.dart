import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/constants/app_colors.dart';
import 'package:well_organized/widgets/add_space.dart';
import 'package:well_organized/widgets/sign_in_button.dart';
import 'package:well_organized/widgets/sign_up_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final passwordVisibilityProvider = StateProvider<bool>((ref) => true);
  final signInControllerProvider = StateProvider<bool>((ref) => true);

  bool isSignIn = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateController<bool> passwordProviderStateController = ref.watch(passwordVisibilityProvider.state);
    bool isObscure = passwordProviderStateController.state;

    StateController<bool> signInProviderStateController = ref.watch(signInControllerProvider.state);
    bool isSignIn = signInProviderStateController.state;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Well Organized'),
          ),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
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
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter your email address',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: passwordController,
                      autocorrect: false,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        suffixIcon: InkWell(
                          child:
                              isObscure ? const Icon(Icons.visibility_sharp) : const Icon(Icons.visibility_off_sharp),
                          onTap: () => passwordProviderStateController.update((state) => state = !state),
                        ),
                        labelText: 'Password',
                        hintText: 'Enter your secure password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: isSignIn
                        ? SignInButton(
                            emailController: emailController,
                            passwordController: passwordController,
                          )
                        : SignUpButton(
                            emailController: emailController,
                            passwordController: passwordController,
                          ),
                  ),
                  verticalSpace(30),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        isSignIn
                            ? const TextSpan(
                                text: 'If you do not have an account click ',
                                style: TextStyle(color: buttonColor),
                              )
                            : const TextSpan(
                                text: 'If you have an account click ',
                                style: TextStyle(color: buttonColor),
                              ),
                        TextSpan(
                          text: 'here',
                          style: const TextStyle(color: backgroundColor, backgroundColor: buttonColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              signInProviderStateController.update((state) => state = !state);
                              passwordProviderStateController.state = true;
                              emailController.clear();
                              passwordController.clear();
                            },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
