import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/card_model.dart';
import '../../presentation/blocs/contact_bloc/contact_bloc.dart';
import '../../presentation/pages/contact_info_page.dart';

class ContactWidget extends StatelessWidget {
  final CardModel card;

  const ContactWidget({Key? key, required this.card}) : super(key: key);

  String getSubTitle() {
    String subTitle = '';

    if (card.generalInfo.jobTitle.isNotEmpty) {
      subTitle += '${card.generalInfo.jobTitle}, ';
    }

    if (card.generalInfo.department.isNotEmpty) {
      subTitle += '${card.generalInfo.department}, ';
    }

    if (card.generalInfo.companyName.isNotEmpty) {
      subTitle += '${card.generalInfo.companyName}, ';
    }

    if (subTitle.length > 1) {
      subTitle = subTitle.substring(0, subTitle.length - 2);
    }

    return subTitle;
  }

  @override
  Widget build(BuildContext context) {
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
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      subtitle: Text(getSubTitle(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black)),
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
                          const PopupMenuItem(
                            value: 1,
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.redAccent),
                            ),
                          ),
                          const PopupMenuDivider(),
                          const PopupMenuItem(
                            value: 2,
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.redAccent),
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
