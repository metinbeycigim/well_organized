import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class FirebaseStorageService {
  Reference get firebaseStorageRef => FirebaseStorage.instance.ref();

  Future<void> uploadImageToFirebaseStorage(String path, File imageFile) async {
    final imageCount = await firebaseStorageRef.child(path).listAll().then((value) => value.items.length);
    final image = await firebaseStorageRef.child('$path/$path-${(imageCount + 1).toString()}').putFile(imageFile);
  }

 
}
