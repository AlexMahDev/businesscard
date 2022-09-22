part of 'image_bloc.dart';

@immutable
abstract class ImageState {}

class ImageInitialState extends ImageState {}


class ImagePickErrorState extends ImageState {}


class ImageNetworkLoadedState extends ImageState {

  final String networkImage;

  ImageNetworkLoadedState(this.networkImage);

}

class ImageLoadingState extends ImageState {}


class ImageDeletingState extends ImageState {}