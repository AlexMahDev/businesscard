import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/custom_error_widget.dart';
import 'package:businesscard/presentation/widgets/custom_text_field_widget.dart';
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

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    // BlocProvider.of<ContactBloc>(context).add(GetContactEvent());
  }

  @override
  void dispose() {
    searchController.dispose();
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
                  child: TextField(
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
                              searchController.text, contactState.contacts));
                        } else if (contactState is ContactSearchState) {
                          contactBloc.add(GetContactByNameEvent(
                              searchController.text, contactState.contacts));
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          // Other Sliver Widgets
          BlocBuilder<ContactBloc, ContactState>(
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
                      child:
                          ContactWidget(card: state.contacts[index].cardModel));
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
        ],
      ),
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
                if(card.generalInfo.profileImage.isNotEmpty)
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
