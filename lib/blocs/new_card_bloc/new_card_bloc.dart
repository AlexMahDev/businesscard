import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:businesscard/data/models/card_model.dart';
import 'package:meta/meta.dart';

part 'new_card_event.dart';
part 'new_card_state.dart';

class NewCardBloc extends Bloc<NewCardEvent, NewCardState> {
  NewCardBloc() : super(NewCardInitialState(CardModel(settings: SettingsModel(cardTitle: '', cardColor: 4294922834), generalInfo: GeneralInfoModel(firstName: '', middleName: '', lastName: '', jobTitle: '', department: '', companyName: '', headLine: ''), extraInfo: ExtraInfoModel(listOfFields: [])))) {
    on<AddCardInfoEvent>(_addInfo);
  }

  _addInfo(AddCardInfoEvent event, Emitter<NewCardState> emit) {

    emit(NewCardInitialState(event.card));

  }

}
