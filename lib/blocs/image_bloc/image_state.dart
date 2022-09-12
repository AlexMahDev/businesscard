part of 'image_bloc.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

//class ImagePickLoadingState extends ImageEvent {}

class ImagePickLoadedState extends ImageState {

  final File image;

  ImagePickLoadedState(this.image);

}

class ImagePickErrorState extends ImageState {}