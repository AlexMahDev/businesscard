import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitialState()) {
    on<PickImageEvent>(_pickImage);
    on<NetworkImageEvent>(_showNetworkImage);
    on<RemoveImageEvent>(_removeImage);
  }

  _pickImage(PickImageEvent event, Emitter<ImageState> emit) async {

    final ImagePicker picker = ImagePicker();
    final XFile? image;

    try {
      if (event.isGallery) {
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
          emit(ImagePickLoadedState(File(croppedFile.path)));
        }
      }
    } catch (_) {}


  }


  _showNetworkImage(NetworkImageEvent event, Emitter<ImageState> emit) async {

    if(event.imageUrl.isNotEmpty) {
      emit(ImageNetworkState(event.imageUrl));
    } else {
      emit(ImageInitialState());
    }

  }


  _removeImage(ImageEvent event, Emitter<ImageState> emit) async {

    emit(ImageInitialState());

  }





}
