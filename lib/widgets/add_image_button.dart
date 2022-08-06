import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:well_organized/services/firebase_storage.dart';

class AddImageButton extends StatelessWidget {
  const AddImageButton({
    super.key,
    required this.formKey,
    required this.imageRef,
    required this.skuController,
  });

  final GlobalKey<FormState> formKey;
  final FirebaseStorageService imageRef;
  final TextEditingController skuController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(250, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(
            source: ImageSource.camera,
          );

          final imageFile = File(image!.path);

          try {
            imageRef.uploadImageToFirebaseStorage(skuController.text.trim().toUpperCase(), imageFile);
          } on FirebaseException catch (e) {
            print(e);
          }
        }
      },
      child: const Icon(Icons.photo_camera),
    );
  }
}
