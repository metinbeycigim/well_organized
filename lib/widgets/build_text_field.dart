import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {

  final bool obscureText;
  final String labelText;
  final String hintText;
  final TextEditingController textEditingController;
  const BuildTextField(this.labelText, this.hintText, this.textEditingController, this.obscureText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: textEditingController,
        autocorrect: false,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
