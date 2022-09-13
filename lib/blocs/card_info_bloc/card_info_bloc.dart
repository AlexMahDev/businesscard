import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:businesscard/data/models/card_model.dart';
import 'package:meta/meta.dart';

part 'card_info_event.dart';
part 'card_info_state.dart';

class CardInfoBloc extends Bloc<CardInfoEvent, CardInfoState> {
  CardInfoBloc() : super(CardInfoInitialState()) {
    on<GetCardInfoEvent>(_getCardInfo);
    on<AddCardEvent>(_addCard);
    on<AddExtraInfoEvent>(_addExtraInfo);
  }

  _getCardInfo(CardInfoEvent event, Emitter<CardInfoState> emit) async {

    emit(CardInfoLoadingState());

    await Future.delayed(const Duration(seconds: 5), () {});

    List<Map<String, Map<String, dynamic>>> listOfCards = [

      {
        "settings": {
          //"cardTitle": "Job",
          "cardColor": 4294922834,
        },
        "generalInfo": {
          "cardTitle": "Job",
          "firstName": "Alexander",
          "middleName": "Mikhailovich",
          "lastName": "Makhrachyov",
          "jobTitle": "Head Of Mobile",
          "department": "Mobile",
          "companyName": "Innowise",
          "headLine": "Hi!",
          "profileImage": "https://broncolor.swiss/assets/img/Stories/Inspiration/Daniel-Radcliffe/_contentWithShareBar23/DANIEL-RADCLIFFE-featured.jpg",
          "logoImage": "https://media-exp1.licdn.com/dms/image/C4D22AQGXD38tJ3bl6g/feedshare-shrink_800/0/1658841071398?e=1663200000&v=beta&t=QmWAtDvMN4YTLIBg7RopEEuXO1PWq6VpeSkKbafqpb0"
        },
        "extraInfo": {
          "email": "myemail@gmail.com",
        },

      },

      {
        "settings": {
          "cardColor": 4294922834,
        },
        "generalInfo": {
          "cardTitle": "Job",
          "firstName": "Alexander",
          "middleName": "Mikhailovich",
          "lastName": "test",
          "jobTitle": "test",
          "department": "Mobile",
          "companyName": "test",
          "headLine": "Hi!",
          "profileImage": "https://broncolor.swiss/assets/img/Stories/Inspiration/Daniel-Radcliffe/_contentWithShareBar23/DANIEL-RADCLIFFE-featured.jpg",
          "logoImage": "https://scontent-waw1-1.xx.fbcdn.net/v/t39.30808-6/215485554_10159431724164660_8100659849944415055_n.png?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=WUhRQ7j_fr8AX-aIi3O&_nc_ht=scontent-waw1-1.xx&oh=00_AT8EUagE3wtnp-EPMVpVE9x9GTcrmOsITCKpNEXC7zzVtA&oe=632456A9"
        },
        "extraInfo": {
          "email": "test@gmail.com",
        },

      }

    ];


    List<CardModel> cards = List.from(listOfCards.map((card) => CardModel.fromJson(card)));



    //CardModel card = CardModel.fromJson(listOfCards[0]);



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

    emit(CardInfoLoadedState(cards));

  }


  _addCard(AddCardEvent event, Emitter<CardInfoState> emit) async {


    //List<CardModel> cards = List.from(listOfCards.map((card) => CardModel.fromJson(card)));

    emit(CardInfoLoadedState(event.cards));

  }

  _addExtraInfo(AddExtraInfoEvent event, Emitter<CardInfoState> emit) async {


    //List<CardModel> cards = List.from(listOfCards.map((card) => CardModel.fromJson(card)));

    emit(CardInfoLoadedState(event.cards));

  }


}
