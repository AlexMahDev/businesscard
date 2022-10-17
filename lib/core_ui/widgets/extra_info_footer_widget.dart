import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/blocs/select_card_color_bloc/select_card_color_bloc.dart';
import '../../presentation/blocs/text_field_bloc/text_field_bloc.dart';
import 'extra_info_widget.dart';


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
