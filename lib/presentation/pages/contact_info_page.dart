import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core_ui/widgets/card_widget.dart';
import '../../core_ui/widgets/custom_app_bar.dart';
import '../../core_ui/widgets/loading_overlay_widget.dart';
import '../../domain/models/card_model.dart';
import '../blocs/contact_bloc/contact_bloc.dart';

class ContactInfoPage extends StatelessWidget {
  final CardModel card;
  final bool isNewCard;
  final TextEditingController? searchController;

  const ContactInfoPage(
      {Key? key,
      required this.card,
      this.isNewCard = false,
      this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);
    final LoadingOverlay loadingOverlay = LoadingOverlay();
    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state is SaveContactLoadingState) {
          loadingOverlay.show(context);
        } else {
          loadingOverlay.hide();
        }

        if (state is SaveContactSuccessState) {
          searchController!.clear();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(localText!.contactIsSaved)));
        }
        if (state is SaveContactErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(localText!.errorText)));
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
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
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
