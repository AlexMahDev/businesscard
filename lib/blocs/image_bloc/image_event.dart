part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class UploadImageEvent extends ImageEvent {

  final bool isGallery;

  UploadImageEvent(this.isGallery);

}

class GetImageEvent extends ImageEvent {

  // final String imageUrl;
  //
  // GetImageEvent(this.imageUrl);


}


class RemoveImageEvent extends ImageEvent {}