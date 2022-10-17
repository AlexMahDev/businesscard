import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'select_card_color_event.dart';
part 'select_card_color_state.dart';

class SelectCardColorBloc extends Bloc<SelectCardColorEvent, int> {
  SelectCardColorBloc() : super(4294922834) {
    on<SelectCardColorEvent>(_selectColor);
  }

  _selectColor(SelectCardColorEvent event, Emitter<int> emit) {

    emit(event.color);

  }

}
