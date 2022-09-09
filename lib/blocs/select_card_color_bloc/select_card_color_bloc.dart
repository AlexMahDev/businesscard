import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'select_card_color_event.dart';
part 'select_card_color_state.dart';

class SelectCardColorBloc extends Bloc<SelectCardColorEvent, Color> {
  SelectCardColorBloc() : super(Colors.redAccent) {
    on<SelectCardColorEvent>(_selectColor);
  }

  _selectColor(SelectCardColorEvent event, Emitter<Color> emit) {

    emit(event.color);

  }

}
