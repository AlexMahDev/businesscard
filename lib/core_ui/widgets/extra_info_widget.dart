import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/blocs/select_card_color_bloc/select_card_color_bloc.dart';


class ExtraInfoWidget extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onPressed;

  const ExtraInfoWidget({Key? key,
    required this.title,
    required this.icon,
    required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final selectCardColor = BlocProvider.of<SelectCardColorBloc>(context);

    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 90,
        height: 100,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
                radius: 20,
                backgroundColor: Color(selectCardColor.state),
                child: icon),
            // SizedBox(
            //   height: 10,
            // ),
            Expanded(
                child: Center(
                    child: Text(title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17))))
          ],
        ),
      ),
    );
  }
}