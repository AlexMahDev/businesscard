import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/blocs/select_card_color_bloc/select_card_color_bloc.dart';
import '../../presentation/blocs/text_field_bloc/text_field_bloc.dart';


class ExtraInfoFooterWidget extends StatelessWidget {

  final Map<String, TextEditingController> controllerMap;


  const ExtraInfoFooterWidget({Key? key, required this.controllerMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectCardColorBloc, int>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          color: Color(state).withOpacity(0.2),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExtraInfoWidget(
                      title: 'Phone Number',
                      icon: Icon(Icons.phone, color: Colors.white),
                      onPressed: () {
                        final textFieldBloc =
                        BlocProvider.of<TextFieldBloc>(context);
                        final state = textFieldBloc.state;

                        if (state is TextFieldInitialState) {
                          if(controllerMap['phoneNumber'] == null) {
                            controllerMap['phoneNumber'] =
                                TextEditingController();
                            textFieldBloc.add(AddTextFieldEvent());
                          }
                        }
                      }),
                  ExtraInfoWidget(
                      title: 'Email',
                      icon: Icon(Icons.email, color: Colors.white),
                      onPressed: () {
                        final textFieldBloc =
                        BlocProvider.of<TextFieldBloc>(context);
                        final state = textFieldBloc.state;

                        if (state is TextFieldInitialState) {
                          if(controllerMap['email'] == null) {
                            controllerMap['email'] =
                                TextEditingController();
                            textFieldBloc.add(AddTextFieldEvent());
                          }
                        }
                      }),
                  ExtraInfoWidget(
                      title: 'Link',
                      icon: Icon(Icons.link, color: Colors.white),
                      onPressed: () {
                        final textFieldBloc =
                        BlocProvider.of<TextFieldBloc>(context);
                        final state = textFieldBloc.state;

                        if (state is TextFieldInitialState) {
                          if(controllerMap['link'] == null) {
                            controllerMap['link'] =
                                TextEditingController();
                            textFieldBloc.add(AddTextFieldEvent());
                          }
                        }
                      }),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExtraInfoWidget(
                      title: 'LinkedIn',
                      icon: Image.asset(
                          'assets/images/icons/linkedin-icon.png',
                          color: Colors.white,
                          height: 20),
                      onPressed: () {
                        final textFieldBloc =
                        BlocProvider.of<TextFieldBloc>(context);
                        final state = textFieldBloc.state;

                        if (state is TextFieldInitialState) {
                          if(controllerMap['linkedIn'] == null) {
                            controllerMap['linkedIn'] =
                                TextEditingController();
                            textFieldBloc.add(AddTextFieldEvent());
                          }
                        }
                      }),
                  ExtraInfoWidget(
                      title: 'GitHub',
                      icon: Image.asset(
                          'assets/images/icons/github-icon.png',
                          color: Colors.white,
                          height: 20),
                      onPressed: () {
                        final textFieldBloc =
                        BlocProvider.of<TextFieldBloc>(context);
                        final state = textFieldBloc.state;

                        if (state is TextFieldInitialState) {
                          if(controllerMap['gitHub'] == null) {
                            controllerMap['gitHub'] =
                                TextEditingController();
                            textFieldBloc.add(AddTextFieldEvent());
                          }
                        }
                      }),
                  ExtraInfoWidget(
                      title: 'Telegram',
                      icon: Icon(Icons.telegram, color: Colors.white),
                      onPressed: () {
                        final textFieldBloc =
                        BlocProvider.of<TextFieldBloc>(context);
                        final state = textFieldBloc.state;

                        if (state is TextFieldInitialState) {
                          if(controllerMap['telegram'] == null) {
                            controllerMap['telegram'] =
                                TextEditingController();
                            textFieldBloc.add(AddTextFieldEvent());
                          }
                        }
                      }),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

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