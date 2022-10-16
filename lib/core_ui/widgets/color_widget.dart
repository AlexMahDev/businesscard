import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/blocs/select_card_color_bloc/select_card_color_bloc.dart';

class ColorWidget extends StatelessWidget {

  final int color;

  const ColorWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectCardColor = BlocProvider.of<SelectCardColorBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: () {
          selectCardColor.add(SelectCardColorEvent(color));
        },
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            //color: Colors.redAccent,
            shape: BoxShape.circle,
            border: Border.all(
                color: selectCardColor.state == color
                    ? Colors.grey
                    : Colors.transparent,
                width: 2),
          ),
          child: Center(
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: Color(color),
                shape: BoxShape.circle,
                //border: Border.all(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}