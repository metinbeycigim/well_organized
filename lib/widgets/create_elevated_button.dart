import 'package:flutter/material.dart';

class CreateElevatedButton extends StatelessWidget {
  final void callBackFunction;
  const CreateElevatedButton(this.callBackFunction, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => callBackFunction,
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 45),
          elevation: 5,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
      child: const Text('PlaceHolderText'),
    );
  }
}
