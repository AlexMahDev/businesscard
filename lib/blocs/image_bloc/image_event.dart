part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class PickImageEvent extends ImageEvent {

  final bool isGallery;

  PickImageEvent(this.isGallery);

}

class NetworkImageEvent extends ImageEvent {

  final String imageUrl;

  NetworkImageEvent(this.imageUrl);


}


class RemoveImageEvent extends ImageEvent {}