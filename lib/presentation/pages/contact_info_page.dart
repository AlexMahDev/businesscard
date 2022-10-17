import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core_ui/widgets/card_widget.dart';
import '../../core_ui/widgets/custom_app_bar.dart';
import '../../core_ui/widgets/loading_overlay_widget.dart';
import '../../domain/models/card_model.dart';
import '../blocs/contact_bloc/contact_bloc.dart';

class ContactInfoPage extends StatelessWidget {
  final CardModel card;
  final bool isNewCard;

  const ContactInfoPage({Key? key, required this.card, this.isNewCard = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoadingOverlay loadingOverlay = LoadingOverlay();
    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state is SaveContactLoadingState) {
          loadingOverlay.show(context);
        } else {
          loadingOverlay.hide();
        }

        if (state is SaveContactSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Contact is saved')));
        }
        if (state is SaveContactErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Something went wrong :(')));
        }
      },
      child: Scaffold(
          appBar: CustomAppBar(
            title: Text(card.generalInfo.cardTitle),
            actions: [
              if (isNewCard)
                IconButton(
                  icon: const Icon(Icons.save_alt),
                  splashRadius: 20,
                  onPressed: () {
                    BlocProvider.of<ContactBloc>(context)
                        .add(SaveContactEvent(card));
                  },
                )
            ],
          ),
          body: CardWidget(card: card)),
    );
  }
}
