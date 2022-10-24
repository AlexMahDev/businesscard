import 'package:businesscard/core_ui/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/blocs/card_info_bloc/card_info_bloc.dart';
import '../../presentation/pages/create_card_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardIsEmptyWidget extends StatelessWidget {
  const CardIsEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(localText!.doNotHaveCards,
              style: TextThemeCustom.doNotHaveCardsTextTheme,
              textAlign: TextAlign.center),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              final cardInfoBloc = BlocProvider.of<CardInfoBloc>(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => BlocProvider.value(
                        value: cardInfoBloc,
                        child: const CreateCardPage(),
                      )));
            },
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: Colors.white),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(localText.createCardButton,
                        style: TextThemeCustom.createCardButtonTextTheme),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
