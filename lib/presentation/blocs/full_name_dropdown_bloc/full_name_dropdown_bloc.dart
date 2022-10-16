import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'full_name_dropdown_event.dart';
part 'full_name_dropdown_state.dart';

class FullNameDropdownBloc extends Bloc<FullNameDropdownEvent, FullNameDropdownState> {
  FullNameDropdownBloc() : super(FullNameDropdownCloseState()) {
    on<FullNameDropdownOpenEvent>(_openDropdown);
    on<FullNameDropdownCloseEvent>(_closeDropdown);
  }

  _openDropdown(FullNameDropdownEvent event, Emitter<FullNameDropdownState> emit) {

    emit(FullNameDropdownOpenState());

  }

  _closeDropdown(FullNameDropdownEvent event, Emitter<FullNameDropdownState> emit) {

    emit(FullNameDropdownCloseState());

  }

}
