import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/custom_error_widget.dart';
import 'package:businesscard/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/contact_bloc/contact_bloc.dart';


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
    BlocProvider.of<ContactBloc>(context).add(GetContactEvent());
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
                    color: Colors.grey.shade200
                ),
                width: double.infinity,
                child: Center(
                  child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none
                      )
                  ),
                ),
              ),
            ),
          ),
          // Other Sliver Widgets
          BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              if(state is ContactLoadingState) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if(state is ContactLoadedState) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: state.contacts.length,
                            (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(height: 30, color: Colors.purpleAccent),
                      );
                    })

                  // SliverChildListDelegate([
                  //
                  //   for (int i = 0; i != 50; i++)
                  //     Text('Test $i')
                  //
                  // ]),
                );
              }
              if(state is ContactErrorState) {
                return SliverFillRemaining(
                  child: Center(
                    child: CustomErrorWidget(
                        onTap: () {
                          BlocProvider.of<ContactBloc>(context).add(GetContactEvent());
                        }
                    ),
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


// class ContactWidget extends StatelessWidget {
//   const ContactWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: ClipOval(
//         child: Image.network(
//             card
//                 .generalInfo.profileImage,
//             width: 80,
//             height: 80,
//             fit: BoxFit.cover, errorBuilder:
//             (BuildContext context,
//             Object exception,
//             StackTrace?
//             stackTrace) {
//           return Container();
//         }),
//
//         // Image.asset(
//         //   'assets/images/avatar.jpg',
//         //   width: 80,
//         //   height: 80,
//         //   fit: BoxFit.cover,
//         // ),
//       ),
//     );
//   }
// }
