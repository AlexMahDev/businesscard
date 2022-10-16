import 'package:businesscard/core_ui/widgets/share_card_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/card_model.dart';
import '../../presentation/blocs/card_page_bloc/card_page_bloc.dart';

class PageSelectorWidget extends StatelessWidget {

  final List<CardModel> cards;

  const PageSelectorWidget({Key? key, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardPageBloc, int>(
      builder: (context, cardPageState) {
        return Container(
          height: 80,
          color: Colors.white.withOpacity(0.6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int cardNumber = 0;
                    cardNumber < cards.length;
                    cardNumber++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0),
                        child: Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                            color: cardNumber != cardPageState
                                ? Colors.black
                                : Color(cards[cardPageState]
                                .settings
                                .cardColor),
                            shape: BoxShape.circle,
                            //border: Border.all(color: Colors.black),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: ShareCardButton(qrLink: cards[cardPageState].qrLink,
                    color: cards[cardPageState].settings
                        .cardColor),
              )
            ],
          ),
        );
      },
    );
  }
}