
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/select_card_color_bloc/select_card_color_bloc.dart';
import '../create_card_page.dart';

class ChooseColorWidget extends StatelessWidget {
  const ChooseColorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectCardColorBloc, Color>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ColorWidget(color: Colors.redAccent),
                ColorWidget(color: Colors.orange),
                ColorWidget(color: Colors.yellow),
                ColorWidget(color: Colors.brown),
                ColorWidget(color: Colors.green),
                ColorWidget(color: Colors.lightBlueAccent),
                ColorWidget(color: Colors.blue),
                ColorWidget(color: Colors.purple),
                ColorWidget(color: Colors.purpleAccent),
                ColorWidget(color: Colors.black),
                ColorWidget(color: Colors.grey)
              ],
            ),
          ),
        );
      },
    );
  }
}

class ColorWidget extends StatelessWidget {

  final Color color;

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
                color: color,
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