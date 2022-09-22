import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/card_page_bloc/card_page_bloc.dart';
import '../../data/models/card_model.dart';
import 'card_widget.dart';



class CardPageViewWidget extends StatefulWidget {

  final List<CardModel> cards;

  const CardPageViewWidget({Key? key, required this.cards}) : super(key: key);

  @override
  State<CardPageViewWidget> createState() => _CardPageViewWidgetState();
}

class _CardPageViewWidgetState extends State<CardPageViewWidget> {

  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: BlocProvider.of<CardPageBloc>(context).state);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: widget.cards.length,
      onPageChanged: (page) {
        final cardPageBloc =
        BlocProvider.of<CardPageBloc>(context);

        cardPageBloc.add(ChangeCardPageEvent(page));
      },
      itemBuilder: (context, position) {
        return CardWidget(card: widget.cards[position]);

      },
    );
  }
}