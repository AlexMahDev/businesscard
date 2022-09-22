import 'package:businesscard/presentation/widgets/card_is_empty_widget.dart';
import 'package:businesscard/presentation/widgets/card_page_view_widget.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/custom_error_widget.dart';
import 'package:businesscard/presentation/widgets/page_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/card_info_bloc/card_info_bloc.dart';
import '../blocs/card_page_bloc/card_page_bloc.dart';
import 'create_card_page.dart';
import 'edit_card_page.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardInfoBloc, CardInfoState>(
      buildWhen: (previous, current) {
        if (current is CardInfoLoadingState) {
          return true;
        }
        if (current is CardInfoLoadedState) {
          return true;
        }
        if (current is CardInfoEmptyState) {
          return true;
        }
        if (current is CardInfoErrorState) {
          return true;
        }
        if (current is CardInfoInitialState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: state is CardInfoLoadedState
                ? BlocBuilder<CardPageBloc, int>(
              builder: (context, cardPageState) {
                return Text(
                    state.cards[cardPageState].generalInfo.cardTitle);
              },
            )
                : Text('BCard'),
            actions: [
              if (state is CardInfoLoadedState || state is CardInfoEmptyState)
                IconButton(
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
                ),
              if (state is CardInfoLoadedState)
                IconButton(
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
                )
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
                    child: Image.asset(
                      'assets/images/logo/BCard-logo_text.png',
                    ),

                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Image.asset(
                    //       'assets/images/business-card.png',
                    //       color: Colors.white,
                    //     ),
                    //     Text("BCard",
                    //         style: TextStyle(
                    //             fontSize: 30,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.white),
                    //         textAlign: TextAlign.center),
                    //   ],
                    // ),
                  ),
                ),
                ListTile(
                  textColor: Colors.grey,
                  leading: Image.asset('assets/images/crying.png'),
                  title: Text('Sign Out',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onTap: () {
                    context.read<AuthBloc>().add(SignOutRequested());
                  },
                )
              ],
            ),
          ),
          body: Column(
            children: [
              if (state is CardInfoLoadingState)
                Expanded(child: Center(child: CircularProgressIndicator())),
              if (state is CardInfoLoadedState)
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CardPageViewWidget(cards: state.cards),
                      PageSelectorWidget(cards: state.cards)
                    ],
                  ),
                ),
              if (state is CardInfoEmptyState)
                Expanded(child: CardIsEmptyWidget()),
              if (state is CardInfoErrorState)
                Expanded(
                  child: CustomErrorWidget(onTap: () {
                    BlocProvider.of<CardInfoBloc>(context)
                        .add(GetCardInfoEvent());
                  }),
                ),
            ],
          ),
          //floatingActionButton: const CustomFloatActionButton(), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}