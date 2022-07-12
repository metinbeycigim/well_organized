import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController textEditingController;
  const BuildTextField(this.labelText, this.hintText, this.textEditingController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: textEditingController,        
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
