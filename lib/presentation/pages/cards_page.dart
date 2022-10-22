import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core_ui/themes/text_theme.dart';
import '../../core_ui/widgets/card_is_empty_widget.dart';
import '../../core_ui/widgets/card_page_view_widget.dart';
import '../../core_ui/widgets/custom_app_bar.dart';
import '../../core_ui/widgets/custom_error_widget.dart';
import '../../core_ui/widgets/page_selector_widget.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/card_info_bloc/card_info_bloc.dart';
import '../blocs/card_page_bloc/card_page_bloc.dart';
import 'create_card_page.dart';
import 'edit_card_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CardsPage extends StatelessWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);
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
                : Text(localText!.appTitle),
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
                              child: const CreateCardPage(),
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
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                    ),
                    child: Image.asset(
                      'assets/images/logo/BCard-logo_text.png',
                    ),
                  ),
                ),
                ListTile(
                  textColor: Colors.grey,
                  leading: Image.asset('assets/images/crying.png'),
                  title: Text(localText!.signOutButton,
                      style: TextThemeCustom.signOutButtonTextTheme),
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
                const Expanded(
                    child: Center(child: CircularProgressIndicator())),
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
                const Expanded(child: CardIsEmptyWidget()),
              if (state is CardInfoErrorState)
                Expanded(
                  child: CustomErrorWidget(onTap: () {
                    BlocProvider.of<CardInfoBloc>(context)
                        .add(GetCardInfoEvent());
                  }),
                ),
            ],
          ),
        );
      },
    );
  }
}
