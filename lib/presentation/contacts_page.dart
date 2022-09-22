import 'package:businesscard/presentation/widgets/card_widget.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/custom_error_widget.dart';
import 'package:businesscard/presentation/widgets/custom_text_field_widget.dart';
import 'package:businesscard/presentation/widgets/loading_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/contact_bloc/contact_bloc.dart';
import '../data/models/card_model.dart';
import 'contact_info_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late final TextEditingController searchController;
  late final TextEditingController urlController;
  late final LoadingOverlay loadingOverlay;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    urlController = TextEditingController();
    loadingOverlay = LoadingOverlay();
    // BlocProvider.of<ContactBloc>(context).add(GetContactEvent());
  }

  @override
  void dispose() {
    searchController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: const Text('Contacts'),
            actions: [
              BlocBuilder<ContactBloc, ContactState>(
                builder: (context, state) {

                  if(state is ContactLoadedState)
                    return IconButton(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        splashRadius: 20,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: Text("Add contact"),
                                    content: SizedBox(
                                      height: 120,
                                      child: Column(
                                        children: [
                                          Text(
                                              "Enter link you received from contact"),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomTextField(
                                              controller: urlController,
                                              hintText: 'Link'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            BlocProvider.of<ContactBloc>(context)
                                                .add(SaveContactManualEvent(urlController.text, state.contacts));
                                          },
                                          child: Text('Add',
                                              style: TextStyle(fontSize: 18))),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel',
                                              style: TextStyle(fontSize: 18))),
                                    ],
                                  ));
                        },
                        icon: Icon(Icons.add));

                  return Container();
                },
              )
            ],
            // actions: [
            //   IconButton(
            //     icon: const Icon(Icons.shopping_cart),
            //     onPressed: () {},
            //   ),
            // ],
            bottom: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200),
                width: double.infinity,
                child: Center(
                  child: BlocBuilder<ContactBloc, ContactState>(
                    builder: (context, state) {
                      return TextField(
                        enabled: state is ContactLoadingState ? false : true,
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none),
                        onChanged: (name) {
                          if (searchController.text.isEmpty ||
                              searchController.text.length > 3) {
                            final contactBloc =
                                BlocProvider.of<ContactBloc>(context);
                            final contactState = contactBloc.state;
                            if (contactState is ContactLoadedState) {
                              contactBloc.add(GetContactByNameEvent(
                                  searchController.text,
                                  contactState.contacts));
                            } else if (contactState is ContactSearchState) {
                              contactBloc.add(GetContactByNameEvent(
                                  searchController.text,
                                  contactState.contacts));
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          // Other Sliver Widgets
          BlocListener<ContactBloc, ContactState>(
            listener: (context, state) {
              if (state is DelContactLoadingState) {
                loadingOverlay.show(context);
              } else if (state is SearchLinkLoadingState) {
                loadingOverlay.show(context);
              } else {
                loadingOverlay.hide();
              }

              if(state is DelContactErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    SnackBar(content: Text('Something went wrong :(')));
              }

              if(state is SearchLinkSuccessState) {
                Navigator.of(context).push(MaterialPageRoute (
                  builder: (BuildContext context) => ContactInfoPage(card: state.card, isNewCard: true),
                ));
              }

              if(state is SearchLinkErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    SnackBar(content: Text('Something went wrong :(')));
              }

            },
            child: BlocBuilder<ContactBloc, ContactState>(
              buildWhen: (previous, current) {
                if (current is ContactLoadingState) {
                  return true;
                }
                if (current is ContactLoadedState) {
                  return true;
                }
                if (current is ContactErrorState) {
                  return true;
                }
                if (current is ContactEmptyState) {
                  return true;
                }
                if (current is ContactInitialState) {
                  return true;
                }

                return false;
              },
              builder: (context, state) {
                if (state is ContactLoadingState) {
                  return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is ContactLoadedState) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: state.contacts.length, (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: ContactWidget(
                            card: state.contacts[index].cardModel));
                  }));
                }

                if (state is ContactSearchState) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: state.foundContacts.length,
                          (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: ContactWidget(
                            card: state.foundContacts[index].cardModel));
                  })

                      // SliverChildListDelegate([
                      //
                      //   for (int i = 0; i != 50; i++)
                      //     Text('Test $i')
                      //
                      // ]),
                      );
                }
                if (state is ContactErrorState) {
                  return SliverFillRemaining(
                    child: Center(
                      child: CustomErrorWidget(onTap: () {
                        BlocProvider.of<ContactBloc>(context)
                            .add(GetContactEvent());
                      }),
                    ),
                  );
                }

                return SliverFillRemaining(child: Container());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddContactByLinkWidget extends StatelessWidget {
  const AddContactByLinkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}

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
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ContactInfoPage(card: card),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                if (card.generalInfo.profileImage.isNotEmpty)
                  ClipOval(
                    child: Image.network(card.generalInfo.profileImage,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover, errorBuilder: (BuildContext context,
                            Object exception, StackTrace? stackTrace) {
                      return Container();
                    }),
                  ),
                Expanded(
                  child: ListTile(
                    title: Text(
                        '${card.generalInfo.firstName} ${card.generalInfo.middleName} ${card.generalInfo.lastName}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text(getSubTitle(),
                        style: TextStyle(fontSize: 20, color: Colors.black)),
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
                                  card.cardId, contactState.contacts));
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
                      //icon: Icon(Icons.menu),
                      //offset: const Offset(-15, 60),
                    ),

                    // IconButton(
                    //   splashRadius: 20,
                    //   onPressed: () {
                    //     final contactBloc = BlocProvider.of<ContactBloc>(context);
                    //     final contactState = contactBloc.state;
                    //     if (contactState is ContactLoadedState) {
                    //       contactBloc.add(DeleteContactEvent(card.cardId, contactState.contacts));
                    //     } else if (contactState is ContactSearchState) {
                    //       contactBloc.add(DeleteContactEvent(card.cardId, contactState.contacts));
                    //     }
                    //   },
                    //   icon: Icon(Icons.more_vert, color: Colors.black),
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(color: Colors.black)
      ],
    );
  }
}
