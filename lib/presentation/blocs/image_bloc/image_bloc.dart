import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:businesscard/data/repositories/storage_repository.dart';
import 'package:flutter/material.dart';
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


  }


  _getNetworkImage(GetImageEvent event, Emitter<ImageState> emit) async {

    if(storageRepository.url.isNotEmpty) {
      emit(ImageNetworkLoadedState(storageRepository.url));
    } else {
      emit(ImageInitialState());
    }

  }


  _removeImage(RemoveImageEvent event, Emitter<ImageState> emit) async {

    emit(ImageDeletingState());

    try {
      final String fileName = event.fileUrl.substring(0, event.fileUrl.indexOf('?alt')).replaceAll('https://firebasestorage.googleapis.com/v0/b/bcard-f4f4b.appspot.com/o/files%2F', '').trim();
      await storageRepository.deleteImage(fileName);
      emit(ImageInitialState());
    } catch (e) {
      emit(ImageNetworkLoadedState(storageRepository.url));
    }


  }


}
