import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class StorageRepository {

  final ImagePicker picker = ImagePicker();
  String url = '';

  Future<void> uploadImage(bool isGallery) async {

    final XFile? image;

    try {
      if (isGallery) {
        image = await picker.pickImage(source: ImageSource.gallery);
      } else {
        image = await picker.pickImage(source: ImageSource.camera);
      }
      if (image != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Crop Image',
                toolbarColor: Colors.black,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Crop Image',
            ),
          ],
        );
        if(croppedFile != null) {


          final File file = File(croppedFile.path);
          final String fileName = image.name;

          final String path = 'files/${'timestamp-${DateTime.now().millisecondsSinceEpoch}-file-$fileName'}';


          final ref = FirebaseStorage.instance.ref(path);

          final upload = await ref.putFile(file);

          url = await upload.ref.getDownloadURL();

        }
      }
    } catch (e) {
      throw Exception(e);
    }


  }

  Future<void> deleteImage(String fileName) async {

    final String path = 'files/$fileName';

    final ref = FirebaseStorage.instance.ref(path);

    try {
      await ref.delete();
      url = '';
    } catch (e) {
      throw Exception(e);
    }

  }


}