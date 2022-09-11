part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class ImagePickLoadingEvent extends ImageEvent {}

class ImagePickLoadedEvent extends ImageEvent {}

class ImagePickErrorEvent extends ImageEvent {}