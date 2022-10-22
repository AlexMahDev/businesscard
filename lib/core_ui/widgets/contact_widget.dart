import 'package:businesscard/core_ui/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/card_model.dart';
import '../../presentation/blocs/contact_bloc/contact_bloc.dart';
import '../../presentation/pages/contact_info_page.dart';
import '../ui_functions/ui_functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ContactWidget extends StatelessWidget {
  final CardModel card;

  const ContactWidget({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              final contactBloc = BlocProvider.of<ContactBloc>(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    BlocProvider<ContactBloc>.value(
                  value: contactBloc,
                  child: ContactInfoPage(card: card),
                ),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (card.generalInfo.profileImage.isNotEmpty)
                    ClipOval(
                      child: Image.network(card.generalInfo.profileImage,
                          width: 80, height: 80, fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                        return Container();
                      }),
                    ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                          '${card.generalInfo.firstName} ${card.generalInfo.middleName} ${card.generalInfo.lastName}',
                          style: TextThemeCustom.userNameTextTheme),
                      subtitle: Text(UiFunctions().getSubTitle(card),
                          style: TextThemeCustom.subTitleTextTheme),
                      trailing: PopupMenuButton<int>(
                        icon: const Icon(Icons.more_vert, color: Colors.black),
                        splashRadius: 20,
                        onSelected: (item) async {
                          switch (item) {
                            case 1:
                              final contactBloc =
                                  BlocProvider.of<ContactBloc>(context);
                              final contactState = contactBloc.state;
                              if (contactState is ContactLoadedState) {
                                contactBloc.add(DeleteContactEvent(
                                    card.cardId, contactState.contacts));
                              } else if (contactState is ContactSearchState) {
                                contactBloc.add(DeleteContactEvent(
                                    card.cardId,
                                    contactState.contacts,
                                    contactState.foundContacts));
                              }
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Text(
                              localText!.delete,
                              style: TextThemeCustom.popupMenuTextTheme,
                            ),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            value: 2,
                            child: Text(
                              localText.cancel,
                              style: TextThemeCustom.popupMenuTextTheme,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black)
        ],
      ),
    );
  }
}
