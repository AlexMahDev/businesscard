part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class UploadImageEvent extends ImageEvent {

  final bool isGallery;

  UploadImageEvent(this.isGallery);

}

class GetImageEvent extends ImageEvent {}


class RemoveImageEvent extends ImageEvent {

  final String fileUrl;

  RemoveImageEvent(this.fileUrl);

}