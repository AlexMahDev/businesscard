import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:businesscard/data/models/card_model.dart';
import 'package:meta/meta.dart';

part 'card_info_event.dart';
part 'card_info_state.dart';

class CardInfoBloc extends Bloc<CardInfoEvent, CardInfoState> {
  CardInfoBloc() : super(CardInfoInitialState()) {
    on<GetCardInfoEvent>(_getCardInfo);
  }

  _getCardInfo(CardInfoEvent event, Emitter<CardInfoState> emit) async {

    emit(CardInfoLoadingState());

    await Future.delayed(const Duration(seconds: 5), () {});

    List<Map<String, Map<String, dynamic>>> listOfCards = [

      {
        "settings": {
          "cardTitle": "Job",
          "cardColor": "red",
        },
        "generalInfo": {
          "firstName": "Alexander",
          "middleName": "Mikhailovich",
          "lastName": "Makhrachyov",
          "jobTitle": "Head Of Mobile",
          "department": "Mobile",
          "companyName": "Innowise",
          "headLine": "Hi!"
        },
        "extraInfo": {
          "email": "myemail@gmail.com",
        },

      }

    ];

    CardModel card = CardModel.fromJson(listOfCards[0]);



    // Map<String, Map<String, String>> data =
    //
    // {
    //   "generalInfo": {
    //     "Full_Name": "Alexander Makhrachyov",
    //     "Job_Title": "Head Of Mobile",
    //     "Department": "Mobile",
    //     "Company_Name": "Innowise",
    //     "Headline": "Hi!"
    //   },
    //   "extraInfo": {
    //     "Email": "myemail@gmail.com",
    //   },
    //
    // };

    emit(CardInfoLoadedState(card));


  }
}
