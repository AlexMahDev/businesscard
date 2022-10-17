import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'card_page_event.dart';
part 'card_page_state.dart';

class CardPageBloc extends Bloc<CardPageEvent, int> {
  CardPageBloc() : super(0) {
    on<ChangeCardPageEvent>(_changePage);
  }

  _changePage(ChangeCardPageEvent event, Emitter<int> emit) {

    emit(event.cardPage);

  }

}
