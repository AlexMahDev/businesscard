part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class PickImageEvent extends ImageEvent {

  final bool isGallery;

  PickImageEvent(this.isGallery);

}

class RemoveImageEvent extends ImageEvent {}