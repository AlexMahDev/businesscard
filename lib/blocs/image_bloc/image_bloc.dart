import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<PickImageEvent>(_pickImage);
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
        emit(ImagePickLoadedState(File(image.path)));
      }
    } catch (_) {}


  }


  _removeImage(ImageEvent event, Emitter<ImageState> emit) async {

    emit(ImageInitial());

  }

}
