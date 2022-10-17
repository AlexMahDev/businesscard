import 'package:businesscard/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/dynamic_link_repository.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/card_info_bloc/card_info_bloc.dart';
import '../blocs/card_page_bloc/card_page_bloc.dart';
import 'cards_page.dart';
import 'contacts_page.dart';

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
  }

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomePage()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
