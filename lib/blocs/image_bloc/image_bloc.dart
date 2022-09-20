import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:businesscard/data/repositories/storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {

  final StorageRepository storageRepository;

  ImageBloc({required this.storageRepository}) : super(ImageInitialState()) {
    on<UploadImageEvent>(_uploadImage);
    on<GetImageEvent>(_getNetworkImage);
    on<RemoveImageEvent>(_removeImage);
  }

  _uploadImage(UploadImageEvent event, Emitter<ImageState> emit) async {

    emit(ImageLoadingState());

    try {
      await storageRepository.uploadImage(event.isGallery);
      if (storageRepository.url.isNotEmpty) {
        emit(ImageNetworkLoadedState(storageRepository.url));
      } else {
        emit(ImageInitialState());
      }
    } catch (e) {
      emit(ImagePickErrorState());
    }

    // final ImagePicker picker = ImagePicker();
    // final XFile? image;
    //
    // try {
    //   if (event.isGallery) {
    //     image = await picker.pickImage(source: ImageSource.gallery);
    //   } else {
    //     image = await picker.pickImage(source: ImageSource.camera);
    //   }
    //   if (image != null) {
    //     CroppedFile? croppedFile = await ImageCropper().cropImage(
    //       sourcePath: image.path,
    //       aspectRatioPresets: [
    //         CropAspectRatioPreset.square,
    //         CropAspectRatioPreset.ratio3x2,
    //         CropAspectRatioPreset.original,
    //         CropAspectRatioPreset.ratio4x3,
    //         CropAspectRatioPreset.ratio16x9
    //       ],
    //       uiSettings: [
    //         AndroidUiSettings(
    //             toolbarTitle: 'Crop Image',
    //             toolbarColor: Colors.black,
    //             toolbarWidgetColor: Colors.white,
    //             initAspectRatio: CropAspectRatioPreset.original,
    //             lockAspectRatio: false),
    //         IOSUiSettings(
    //           title: 'Crop Image',
    //         ),
    //       ],
    //     );
    //     if(croppedFile != null) {
    //
    //       final File file = File(croppedFile.path);
    //       final String fileName = image.name;
    //
    //       final String path = 'files/${'timestamp${DateTime.now().millisecondsSinceEpoch}file$fileName'}';
    //
    //       //final ref = FirebaseStorage.instance.ref().child(path);
    //
    //       final ref = FirebaseStorage.instance.ref(path);
    //
    //       final upload = await ref.putFile(file);
    //
    //       final url = await upload.ref.getDownloadURL();
    //
    //
    //
    //       emit(ImagePickLoadedState(File(croppedFile.path)));
    //     }
    //   }
    // } catch (_) {}


  }


  _getNetworkImage(GetImageEvent event, Emitter<ImageState> emit) async {

    if(storageRepository.url.isNotEmpty) {
      emit(ImageNetworkLoadedState(storageRepository.url));
    } else {
      emit(ImageInitialState());
    }

  }


  _removeImage(ImageEvent event, Emitter<ImageState> emit) async {

    storageRepository.deleteImage();
    emit(ImageInitialState());

  }





}
