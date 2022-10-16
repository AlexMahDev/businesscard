part of 'text_clear_button_bloc.dart';

@immutable
abstract class TextClearButtonEvent {}

class ClearButtonEnableEvent extends TextClearButtonEvent {}

class ClearButtonDisableEvent extends TextClearButtonEvent {}