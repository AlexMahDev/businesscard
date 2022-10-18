import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core_ui/widgets/add_contact_by_link_widget.dart';
import '../../core_ui/widgets/contact_widget.dart';
import '../../core_ui/widgets/custom_error_widget.dart';
import '../../core_ui/widgets/loading_overlay_widget.dart';
import '../blocs/contact_bloc/contact_bloc.dart';
import 'contact_info_page.dart';

class ContactsPage extends StatefulWidget {

  final TextEditingController searchController;

  const ContactsPage({Key? key, required this.searchController}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late final LoadingOverlay loadingOverlay;

  @override
  void initState() {
    super.initState();
    loadingOverlay = LoadingOverlay();
  }

  @override
  void dispose() {
    //searchController.dispose();
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
              IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  splashRadius: 20,
                  onPressed: () {
                    final contactBloc = BlocProvider.of<ContactBloc>(context);
                    showDialog(
                        context: context,
                        builder: (ctx) =>
                            BlocProvider.value(
                              value: contactBloc,
                              child: const AddContactByLinkWidget(),
                            ));
                  },
                  icon: const Icon(Icons.add))
            ],
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
                        controller: widget.searchController,
                        decoration: const InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none),
                        onChanged: (name) {
                          final contactBloc =
                          BlocProvider.of<ContactBloc>(context);
                          final contactState = contactBloc.state;
                          if (contactState is ContactLoadedState) {
                            contactBloc.add(GetContactByNameEvent(
                                widget.searchController.text, contactState.contacts));
                          } else if (contactState is ContactSearchState) {
                            contactBloc.add(GetContactByNameEvent(
                                widget.searchController.text, contactState.contacts));
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

              if (state is DelContactErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Something went wrong :(')));
              }

              if (state is SearchLinkSuccessState) {
                final contactBloc = BlocProvider.of<ContactBloc>(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      BlocProvider.value(
                        value: contactBloc,
                        child: ContactInfoPage(
                            card: state.card, isNewCard: true, searchController: widget.searchController),
                      ),
                ));
              }

              if (state is SearchLinkErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Something went wrong :(')));
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
                if (current is ContactSearchState) {
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
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is ContactLoadedState) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return ContactWidget(
                              card: state.contacts[index].cardModel);
                        },
                        childCount: state.contacts.length,
                      ));
                }

                if (state is ContactSearchState) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return ContactWidget(
                              card: state.foundContacts[index].cardModel);
                        },
                        childCount: state.foundContacts.length,
                      ));
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
