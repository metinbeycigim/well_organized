import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_colors.dart';

class FirebaseStorageService {
  Reference get firebaseStorageRef => FirebaseStorage.instance.ref();

  Future<void> uploadImageToFirebaseStorage(String path, File imageFile) async {
    //! more than 3 photos can not be uploaded. Should it be overriden?
    final imageCount = await firebaseStorageRef.child('Images/$path').listAll().then((value) => value.items.length);
    final image = imageCount < 3
        ? await firebaseStorageRef.child('Images/$path/$path-${(imageCount + 1).toString()}').putFile(imageFile)
        : Fluttertoast.showToast(
            msg: 'You already have 3 photos',
            textColor: AppColors.toastTextColor,
            backgroundColor: AppColors.toastBackgroundColor,
            toastLength: Toast.LENGTH_LONG,
          );
  }

  Future<void> uploadExcelFiletoFirebaseStorage(String excelFileName, File excelFile) async {
    final excelFileUpload = await firebaseStorageRef.child('Files/$excelFileName').putFile(excelFile);
  }
}
