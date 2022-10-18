import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core_ui/widgets/loading_overlay_widget.dart';
import '../../data/repositories/dynamic_link_repository.dart';
import '../../domain/models/card_model.dart';
import '../../presentation/blocs/contact_bloc/contact_bloc.dart';
import '../../presentation/pages/cards_page.dart';
import '../../presentation/pages/contact_info_page.dart';
import '../../presentation/pages/contacts_page.dart';

class MainPageNavigationBar extends StatefulWidget {
  const MainPageNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainPageNavigationBar> createState() => _MainPageNavigationBarState();
}

class _MainPageNavigationBarState extends State<MainPageNavigationBar> {
  DynamicLinkRepository dynamicLinkRepository = DynamicLinkRepository();
  late final TextEditingController searchController;
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
          builder: (BuildContext context) => BlocProvider.value(
            value: contactBloc,
            child: ContactInfoPage(
                card: card,
                isNewCard: true,
                searchController: searchController),
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
          CardModel? card = await dynamicLinkRepository
              .handleDynamicLink(dynamicLinkData.link);
          if (card != null) {
            loadingOverlay.hide();
            navigator.push(MaterialPageRoute(
              builder: (BuildContext context) => BlocProvider.value(
                value: contactBloc,
                child: ContactInfoPage(
                    card: card,
                    isNewCard: true,
                    searchController: searchController),
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
    searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _retrieveDynamicLink();
      _listenDynamicLink();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  Widget _selectedScreen(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const CardsPage();
      case 1:
        return ContactsPage(searchController: searchController);
      default:
        return const CardsPage();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _selectedScreen(_selectedIndex),
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
