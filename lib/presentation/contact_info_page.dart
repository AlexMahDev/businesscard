import 'package:businesscard/blocs/contact_bloc/contact_bloc.dart';
import 'package:businesscard/presentation/widgets/card_widget.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/loading_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/card_model.dart';

class ContactInfoPage extends StatelessWidget {

  final CardModel card;
  final bool isNewCard;

  const ContactInfoPage({Key? key, required this.card, this.isNewCard = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoadingOverlay loadingOverlay = LoadingOverlay();
    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state is ContactLoadingState) {
          loadingOverlay.show(context);
        } else {
          loadingOverlay.hide();
        }
        if (state is ContactLoadedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
              SnackBar(content: Text('Contact is saved')));
        }
        if (state is ContactErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
              SnackBar(content: Text('Something went wrong :(')));
        }
      },
      child: Scaffold(
          appBar: CustomAppBar(
            title: Text(card.generalInfo.cardTitle),
            actions: [
              if(isNewCard)
                IconButton(
                  icon: const Icon(Icons.save_alt),
                  splashRadius: 20,
                  onPressed: () {
                    BlocProvider.of<ContactBloc>(context).add(
                        SaveContactEvent(card));
                  },
                )
            ],
          ),
          body: CardWidget(card: card)
        //floatingActionButton: const CustomFloatActionButton(), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
