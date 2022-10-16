import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'text_field_event.dart';
part 'text_field_state.dart';

class TextFieldBloc extends Bloc<TextFieldEvent, TextFieldState> {
  TextFieldBloc() : super(TextFieldInitialState()) {
    on<AddTextFieldEvent>(_addTextField);
  }

  _addTextField(AddTextFieldEvent event, Emitter<TextFieldState> emit) {

    emit(TextFieldInitialState());

  }

}
