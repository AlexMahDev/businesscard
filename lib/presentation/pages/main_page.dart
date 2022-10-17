import 'package:businesscard/presentation/pages/welcome_page.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core_ui/widgets/loading_overlay_widget.dart';
import '../../data/repositories/card_repository.dart';
import '../../data/repositories/contact_repository.dart';
import '../../data/repositories/dynamic_link_repository.dart';
import '../../domain/models/card_model.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/card_info_bloc/card_info_bloc.dart';
import '../blocs/card_page_bloc/card_page_bloc.dart';
import '../blocs/contact_bloc/contact_bloc.dart';
import 'cards_page.dart';
import 'contact_info_page.dart';
import 'contacts_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late final CardPageBloc cardPageBloc;

  @override
  void initState() {
    super.initState();
    cardPageBloc = CardPageBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const WelcomePage()),
                (route) => false,
          );
        }
      },
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => CardRepository(),
          ),
          RepositoryProvider(
            create: (context) => ContactRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CardPageBloc>(
              create: (context) => cardPageBloc,
            ),
            BlocProvider<CardInfoBloc>(
              create: (context) =>
              CardInfoBloc(
                  cardRepository: RepositoryProvider.of<CardRepository>(
                      context),
                  cardPageBloc: cardPageBloc)
                ..add(GetCardInfoEvent()),
            ),
            BlocProvider<ContactBloc>(
              create: (context) =>
              ContactBloc(
                  contactRepository:
                  RepositoryProvider.of<ContactRepository>(context))
                ..add(GetContactEvent()),
            ),
          ],
          child: const MainPageNavigationBar(),
        ),

      ),
    );
  }
}


class MainPageNavigationBar extends StatefulWidget {
  const MainPageNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainPageNavigationBar> createState() => _MainPageNavigationBarState();
}

class _MainPageNavigationBarState extends State<MainPageNavigationBar> {

  DynamicLinkRepository dynamicLinkRepository = DynamicLinkRepository();
  late final LoadingOverlay loadingOverlay;
  bool isOpening = false;

  Future<void> _retrieveDynamicLink() async {
    final navigator = Navigator.of(context);
    final contactBloc = BlocProvider.of<ContactBloc>(context);
    loadingOverlay.show(context);
    try {
      CardModel? card = await dynamicLinkRepository.retrieveDynamicLink();
      if (card != null) {
        navigator.push(MaterialPageRoute(
          builder: (BuildContext context) =>
              BlocProvider.value(
                value: contactBloc,
                child: ContactInfoPage(card: card, isNewCard: true),
              ),
        ));
      }
    } catch (_) {
      loadingOverlay.hide();
    }
    loadingOverlay.hide();
  }

  Future<void> _listenDynamicLink() async {
    final navigator = Navigator.of(context);
    final contactBloc = BlocProvider.of<ContactBloc>(context);
    try {
        FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
          loadingOverlay.show(context);
          // TODO: FIXED BUG WITH FIREBASE: FirebaseDynamicLinks fired multiple times
          if (isOpening == false) {
            isOpening = true;
            CardModel? card = await dynamicLinkRepository.handleDynamicLink(dynamicLinkData.link);
            if (card != null) {
              loadingOverlay.hide();
              navigator.push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    BlocProvider.value(
                      value: contactBloc,
                      child: ContactInfoPage(card: card, isNewCard: true),
                    ),
              ));
            }
            isOpening = false;
          }
        }).onError((error) {
          loadingOverlay.hide();
        });
    } catch (_) {
      loadingOverlay.hide();
    }
  }



  @override
  void initState() {
    super.initState();
    loadingOverlay = LoadingOverlay();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _retrieveDynamicLink();
      _listenDynamicLink();
    });
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
    return Scaffold(
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
