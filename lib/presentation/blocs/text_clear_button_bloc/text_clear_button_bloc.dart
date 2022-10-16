import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'text_clear_button_event.dart';
part 'text_clear_button_state.dart';

class TextClearButtonBloc extends Bloc<TextClearButtonEvent, TextClearButtonState> {
  TextClearButtonBloc() : super(ClearButtonInitialState()) {
    on<ClearButtonEnableEvent>(_enableClearButton);
    on<ClearButtonDisableEvent>(_disableClearButton);
  }

  _enableClearButton(TextClearButtonEvent event, Emitter<TextClearButtonState> emit) {

    emit(ClearButtonEnableState());

  }

  _disableClearButton(TextClearButtonEvent event, Emitter<TextClearButtonState> emit) {

    emit(ClearButtonDisableState());

  }

}
