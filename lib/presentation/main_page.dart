import 'package:businesscard/blocs/card_info_bloc/card_info_bloc.dart';
import 'package:businesscard/blocs/card_page_bloc/card_page_bloc.dart';
import 'package:businesscard/blocs/select_card_color_bloc/select_card_color_bloc.dart';
import 'package:businesscard/presentation/test_page.dart';
import 'package:businesscard/presentation/welcome_page.dart';
import 'package:businesscard/presentation/widgets/card_is_empty_widget.dart';
import 'package:businesscard/presentation/widgets/card_page_view_widget.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/custom_error_widget.dart';
import 'package:businesscard/presentation/widgets/page_selector_widget.dart';
import 'package:businesscard/presentation/widgets/share_card_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../data/models/card_model.dart';
import '../data/repositories/dynamic_link_repository.dart';
import 'contacts_page.dart';
import 'create_card_page.dart';
import 'edit_card_page.dart';

class MainPageNavigationBar extends StatefulWidget {
  const MainPageNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainPageNavigationBar> createState() => _MainPageNavigationBarState();
}

class _MainPageNavigationBarState extends State<MainPageNavigationBar> {
  DynamicLinkRepository dynamicLinkRepository = DynamicLinkRepository();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CardInfoBloc>(context).add(GetCardInfoEvent());
    BlocProvider.of<CardPageBloc>(context).add(ChangeCardPageEvent(0));
    dynamicLinkRepository.retrieveDynamicLink(context);
    //retrieveDynamicLink();
    //initDynamicLinks();
  }

  // Future<void> retrieveDynamicLink() async {
  //   try {
  //     final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
  //     if (data != null) {
  //       print('first link check');
  //       final Uri deepLink = data.link;
  //       handleDynamicLink(deepLink);
  //       Navigator.of(context).push(MaterialPageRoute (
  //         builder: (BuildContext context) => const TestPage(),
  //       ));
  //     }
  //     FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
  //       print('second link check');
  //       Navigator.of(context).push(MaterialPageRoute (
  //         builder: (BuildContext context) => const TestPage(),
  //       ));
  //       //Navigator.pushNamed(context, dynamicLinkData.link.path);
  //     }).onError((error) {
  //       // Handle errors
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  // }

  // handleDynamicLink(Uri url) {
  //   print(url);
  //   // List<String> separatedString = [];
  //   // separatedString.addAll(url.path.split('/'));
  //   // if (separatedString[1] == "post") {
  //   //   Navigator.push(
  //   //       context,
  //   //       MaterialPageRoute(
  //   //           builder: (context) => PostScreen(separatedString[2])));
  //   // }
  // }

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    CardsPage(),
    ContactsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: const CustomAppBar(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.redAccent,
          enableFeedback: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              label: 'Your Card',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              label: 'Contacts',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class CardsPage extends StatelessWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: BlocBuilder<CardInfoBloc, CardInfoState>(
          builder: (context, cardInfoState) {
            if (cardInfoState is CardInfoLoadedState) {
              return BlocBuilder<CardPageBloc, int>(
                builder: (context, cardPageState) {
                  return Text(
                      cardInfoState.cards[cardPageState].generalInfo.cardTitle);
                },
              );
            }
            return Text('BCard');
          },
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   splashRadius: 20,
        //   onPressed: () async {
        //
        //     // final doc = FirebaseFirestore.instance.collection("users").doc("S4lc2BkgjnPbjlnUPMmfMcb2F012").collection("contacts");
        //     //
        //     // await doc.doc().set({'test' : 'test'});
        //
        //     // final info = await FirebaseFirestore.instance.collection("users").doc('uid-1').collection("cards").get();
        //     // print(info.docs.first.data());
        //     context.read<AuthBloc>().add(SignOutRequested());
        //   },
        // ),
        actions: [
          BlocBuilder<CardInfoBloc, CardInfoState>(
            builder: (context, state) {
              if (state is CardInfoLoadedState || state is CardInfoEmptyState) {
                return IconButton(
                  icon: const Icon(Icons.add),
                  splashRadius: 20,
                  onPressed: () {
                    final cardInfoBloc = BlocProvider.of<CardInfoBloc>(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => BlocProvider.value(
                              value: cardInfoBloc,
                              child: CreateCardPage(),
                            )));
                  },
                );
              }
              return Container();
            },
          ),
          BlocBuilder<CardInfoBloc, CardInfoState>(
            builder: (context, state) {
              if (state is CardInfoLoadedState) {
                return IconButton(
                  icon: const Icon(Icons.edit),
                  splashRadius: 20,
                  onPressed: () {
                    final cardInfoBloc = BlocProvider.of<CardInfoBloc>(context);

                    final cardPageBloc = BlocProvider.of<CardPageBloc>(context);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => BlocProvider.value(
                              value: cardInfoBloc,
                              child: EditCardPage(
                                  card: state.cards[cardPageBloc.state]),
                            )));
                  },
                );
              }

              return Container();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 300,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/business-card.png',
                      color: Colors.white,
                    ),
                    Text("BCard",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            ListTile(
              textColor: Colors.grey,
              leading: Image.asset('assets/images/crying.png'),
              title: Text('Sign Out', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              onTap: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
            )
          ],
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => WelcomePage()),
              (route) => false,
            );
          }
        },
        child: BlocBuilder<CardInfoBloc, CardInfoState>(
          buildWhen: (previous, current) {
            if(current is CardInfoLoadingState) {
              return true;
            }
            if(current is CardInfoLoadedState) {
              return true;
            }
            if(current is CardInfoEmptyState) {
              return true;
            }
            if(current is CardInfoErrorState) {
              return true;
            }
            if(current is CardInfoInitialState) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state is CardInfoLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is CardInfoLoadedState) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CardPageViewWidget(cards: state.cards),
                  PageSelectorWidget(cards: state.cards)
                ],
              );
            }


            if (state is CardInfoEmptyState) {
              return CardIsEmptyWidget();
            }
            
            if (state is CardInfoErrorState) {
              return CustomErrorWidget(
                  onTap: () {
                    BlocProvider.of<CardInfoBloc>(context).add(GetCardInfoEvent());
                  }
              );
            }

            return Container();
          },
        ),
      ),
      //floatingActionButton: const CustomFloatActionButton(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


