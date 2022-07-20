import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuildElevatedButton extends StatelessWidget {
  final String buttonName;
  final String routeName;
  const BuildElevatedButton(this.routeName, this.buttonName, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.go('/$routeName'),
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 50),
          elevation: 5,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
      child: Text(buttonName),
    );
  }
}
