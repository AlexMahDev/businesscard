import 'dart:math';

import 'package:businesscard/blocs/card_info_bloc/card_info_bloc.dart';
import 'package:businesscard/blocs/full_name_dropdown_bloc/full_name_dropdown_bloc.dart';
import 'package:businesscard/blocs/new_card_bloc/new_card_bloc.dart';
import 'package:businesscard/blocs/select_card_color_bloc/select_card_color_bloc.dart';
import 'package:businesscard/blocs/text_clear_button_bloc/text_clear_button_bloc.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/card_model.dart';


class CreateCardPage extends StatefulWidget {
  const CreateCardPage({Key? key}) : super(key: key);

  @override
  State<CreateCardPage> createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  final Map<String, TextEditingController> _controllerMap = {};

  late final TextEditingController cardTitle;
  late final TextEditingController fullName;
  late final TextEditingController firstName;
  late final TextEditingController middleName;
  late final TextEditingController lastName;
  late final TextEditingController jobTitle;
  late final TextEditingController department;
  late final TextEditingController companyName;
  late final TextEditingController headLine;

  @override
  void initState() {
    super.initState();
    cardTitle = TextEditingController();
    fullName = TextEditingController();
    firstName = TextEditingController();
    middleName = TextEditingController();
    lastName = TextEditingController();
    firstName.addListener(() {
      fullName.text = '${firstName.text} ${middleName.text} ${lastName.text}'.trim();
    });
    lastName.addListener(() {
      fullName.text = '${firstName.text} ${middleName.text} ${lastName.text}'.trim();
    });
    middleName.addListener(() {
      fullName.text = '${firstName.text} ${middleName.text} ${lastName.text}'.trim();
    });
    // firstName = TextEditingController();
    // middleName = TextEditingController();
    // lastName = TextEditingController();
    jobTitle = TextEditingController();
    department = TextEditingController();
    companyName = TextEditingController();
    headLine = TextEditingController();
  }

  @override
  void dispose() {
    _controllerMap.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  TextEditingController _getControllerOf(String name) {
    var controller = _controllerMap[name];
    if (controller == null) {
      controller = TextEditingController();
      _controllerMap[name] = controller;
    }
    //print(_controllerMap.length);
    return controller;
  }


  String getHintText(String key) {

    if(key == 'phoneNumber') {
      return 'Phone Number';
    } else if(key == 'email'){
      return 'Email';
    } else if(key == 'link'){
      return 'Link';
    } else if(key == 'linkedIn'){
      return 'LinkedIn';
    } else if(key == 'gitHub'){
      return 'GitHub';
    } else if(key == 'telegram'){
      return 'Telegram';
    } else {
      return '';
    }

  }

  Widget getIcon(String key) {
    if(key == 'phoneNumber') {
      return Icon(Icons.phone, color: Colors.white);
    } else if(key == 'email'){
      return Icon(Icons.email, color: Colors.white);
    } else if(key == 'link'){
      return Icon(Icons.link, color: Colors.white);
    } else if(key == 'linkedIn'){
      return Image.asset('assets/images/icons/linkedin-icon.png', color: Colors.white, height: 20);
    } else if(key == 'gitHub'){
      return Image.asset('assets/images/icons/github-icon.png', color: Colors.white, height: 20);
    } else if(key == 'telegram'){
      return Icon(Icons.telegram, color: Colors.white);
    } else {
      return Icon(Icons.add_circle_outline_rounded, color: Colors.white);
    }
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewCardBloc>(
          create: (BuildContext context) => NewCardBloc(),
        ),
        BlocProvider<SelectCardColorBloc>(
          create: (BuildContext context) => SelectCardColorBloc(),
        ),
        BlocProvider<FullNameDropdownBloc>(
          create: (BuildContext context) => FullNameDropdownBloc(),
        ),
        // BlocProvider<CardInfoBloc>(
        //   create: (BuildContext context) =>  CardInfoBloc(),
        // ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: CustomAppBar(
            title: Text('Create A Card'),
            leading: IconButton(
              icon: const Icon(Icons.check),
              splashRadius: 20,
              onPressed: () {

                final cardsInfoBloc = BlocProvider.of<CardInfoBloc>(context);
                final cardColorBloc =
                BlocProvider.of<SelectCardColorBloc>(context);

                final cardsInfoState = cardsInfoBloc.state;


                if (cardsInfoState is CardInfoLoadedState) {
                  List<CardModel> currentCards = cardsInfoState.cards;

                  CardModel newCard = CardModel(
                      settings: SettingsModel(
                          cardTitle: cardTitle.text.isNotEmpty ? cardTitle.text : 'Card',
                          cardColor: cardColorBloc.state.value),
                      generalInfo: GeneralInfoModel(
                          firstName: firstName.text,
                          middleName: middleName.text,
                          lastName: lastName.text,
                          jobTitle: jobTitle.text,
                          department: department.text,
                          companyName: companyName.text,
                          headLine: headLine.text),
                      extraInfo: ExtraInfoModel(listOfFields: []));

                  _controllerMap.forEach((key, value) {
                    newCard.extraInfo.listOfFields
                        .add(TextFieldModel(key: key, value: value.text));
                  });


                  currentCards.add(newCard);

                  // newCard.settings = SettingsModel(cardTitle: cardTitle.text, cardColor: cardColorBloc.state.toString());
                  // newCard.generalInfo = GeneralInfoModel(firstName: firstName.text, middleName: middleName.text, lastName: lastName.text, jobTitle: jobTitle.text, department: department.text, companyName: companyName.text, headLine: headLine.text);
                  // newCard.extraInfo.listOfFields.clear();
                  // _controllerMap.forEach((key, value) {
                  //   newCard.extraInfo.listOfFields.add(TextFieldModel(key: key, value: value.text));
                  // });

                  cardsInfoBloc.add(AddCardEvent(currentCards));
                }

                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_horiz),
                splashRadius: 20,
                onPressed: () {
                  //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const CreateCardPage()));
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomTextField(
                      hintText: 'Set a title (e.g. Work or Personal)',
                      controller: cardTitle),
                ),

                // SizedBox(
                //   height: 20,
                // ),

                BlocBuilder<SelectCardColorBloc, Color>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ChooseColorWidget(color: Colors.redAccent),
                            ChooseColorWidget(color: Colors.orange),
                            ChooseColorWidget(color: Colors.yellow),
                            ChooseColorWidget(color: Colors.brown),
                            ChooseColorWidget(color: Colors.green),
                            ChooseColorWidget(color: Colors.lightBlueAccent),
                            ChooseColorWidget(color: Colors.blue),
                            ChooseColorWidget(color: Colors.purple),
                            ChooseColorWidget(color: Colors.purpleAccent),
                            ChooseColorWidget(color: Colors.black),
                            ChooseColorWidget(color: Colors.grey),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Add Profile Picture',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Add Company Logo',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 30),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final fullNameDropdownBloc =
                          BlocProvider.of<FullNameDropdownBloc>(context);

                          final fullNameDropdownState =
                              fullNameDropdownBloc.state;

                          if (fullNameDropdownState
                          is FullNameDropdownCloseState) {
                            fullNameDropdownBloc
                                .add(FullNameDropdownOpenEvent());
                          } else {
                            fullNameDropdownBloc
                                .add(FullNameDropdownCloseEvent());
                          }
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  hintText: 'Full Name',
                                  enabled: false,
                                  controller: fullName),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            BlocBuilder<FullNameDropdownBloc,
                                FullNameDropdownState>(
                              builder: (context, state) {
                                if (state is FullNameDropdownOpenState) {
                                  return Icon(Icons.keyboard_arrow_up,
                                      size: 50, color: Colors.redAccent);
                                }
                                if (state is FullNameDropdownCloseState) {
                                  return Icon(Icons.keyboard_arrow_down,
                                      size: 50, color: Colors.redAccent);
                                }

                                return Container();
                              },
                            )
                          ],
                        ),
                      ),
                      BlocBuilder<FullNameDropdownBloc, FullNameDropdownState>(
                        builder: (context, state) {
                          if (state is FullNameDropdownOpenState) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20, top: 15),
                              child: Column(
                                children: [
                                  CustomTextField(
                                      hintText: 'First Name',
                                      controller: firstName),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                      hintText: 'Middle Name',
                                      controller: middleName),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                      hintText: 'Last Name',
                                      controller: lastName),
                                ],
                              ),
                            );
                          }

                          return Container();
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          hintText: 'Job Title', controller: jobTitle),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          hintText: 'Department', controller: department),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          hintText: 'Company Name', controller: companyName),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          hintText: 'Headline', controller: headLine)
                    ],
                  ),
                ),

                // ///STATIC TEXT FIELDS
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 15.0, vertical: 30),
                //   child: GeneralTextFields(controller: TextEditingController())
                // ),

                ///DYNAMIC TEXT FIELDS
                BlocBuilder<SelectCardColorBloc, Color>(
                  builder: (context, state) {
                    return BlocBuilder<NewCardBloc, NewCardState>(
                      builder: (context, state) {
                        if (state is NewCardInitialState && _controllerMap.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 30),
                            child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _controllerMap.length,
                              //padding: EdgeInsets.only(top: 15),
                              itemBuilder: (BuildContext context, int index) {
                                //final controller = _getControllerOf(data[index]);

                                // final textField = TextField(
                                //   controller: controller,
                                //   decoration: InputDecoration(
                                //     border: OutlineInputBorder(),
                                //     labelText: "name${index + 1}",
                                //   ),
                                // );
                                return CustomTextField(
                                  controller: _getControllerOf(_controllerMap.keys.elementAt(index)),
                                  hintText: getHintText(_controllerMap.keys.elementAt(index)),
                                  icon: getIcon(_controllerMap.keys.elementAt(index)),
                                  onTextFieldRemove: () {

                                    _controllerMap.remove(_controllerMap.keys.elementAt(index));
                                    final newCardBloc = BlocProvider.of<NewCardBloc>(context);
                                    CardModel card = state.card;
                                    newCardBloc.add(AddCardInfoEvent(card));

                                  },
                                );
                                //   Container(
                                //   child: TextField(
                                //     controller: _getControllerOf(data.keys.elementAt(index)),
                                //     decoration: InputDecoration(
                                //       border: OutlineInputBorder(),
                                //       labelText: data[index],
                                //     ),
                                //   ),
                                //   padding: EdgeInsets.only(bottom: 10),
                                // );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                  SizedBox(height: 15),
                            ),
                          );
                        }

                        return Container();
                      },
                    );
                  },
                ),

                Container(
                  margin: EdgeInsets.all(50),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Tap a field below to add it',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.add, size: 30)
                      ],
                    ),
                  ),
                ),

                BlocBuilder<SelectCardColorBloc, Color>(
                  builder: (context, state) {
                    return ExtraInfoFooterWidget(
                        phoneNumber: ExtraInfoWidget(
                            title: 'Phone Number',
                            icon: Icon(Icons.phone, color: Colors.white),
                            onPressed: () {
                              final newCardBloc =
                              BlocProvider.of<NewCardBloc>(context);
                              final state = newCardBloc.state;

                              if (state is NewCardInitialState) {
                                _controllerMap['phoneNumber'] = TextEditingController();
                                CardModel card = state.card;
                                newCardBloc.add(AddCardInfoEvent(card));
                              }
                            }),
                        email: ExtraInfoWidget(
                            title: 'Email',
                            icon: Icon(Icons.email, color: Colors.white),
                            onPressed: () {
                              final newCardBloc =
                              BlocProvider.of<NewCardBloc>(context);
                              final state = newCardBloc.state;

                              if (state is NewCardInitialState) {
                                _controllerMap['email'] = TextEditingController();
                                CardModel card = state.card;
                                newCardBloc.add(AddCardInfoEvent(card));
                              }
                            }),
                        link: ExtraInfoWidget(
                            title: 'Link',
                            icon: Icon(Icons.link, color: Colors.white),
                            onPressed: () {
                              final newCardBloc =
                              BlocProvider.of<NewCardBloc>(context);
                              final state = newCardBloc.state;

                              if (state is NewCardInitialState) {
                                _controllerMap['link'] = TextEditingController();
                                CardModel card = state.card;
                                newCardBloc.add(AddCardInfoEvent(card));
                              }
                            }),
                        linkedIn: ExtraInfoWidget(
                            title: 'LinkedIn',
                            icon: Image.asset('assets/images/icons/linkedin-icon.png', color: Colors.white, height: 20),
                            onPressed: () {
                              final newCardBloc =
                              BlocProvider.of<NewCardBloc>(context);
                              final state = newCardBloc.state;

                              if (state is NewCardInitialState) {
                                _controllerMap['linkedIn'] = TextEditingController();
                                CardModel card = state.card;
                                newCardBloc.add(AddCardInfoEvent(card));
                              }
                            }),
                        github: ExtraInfoWidget(
                            title: 'GitHub',
                            icon: Image.asset('assets/images/icons/github-icon.png', color: Colors.white, height: 20),
                            onPressed: () {
                              final newCardBloc =
                              BlocProvider.of<NewCardBloc>(context);
                              final state = newCardBloc.state;

                              if (state is NewCardInitialState) {
                                _controllerMap['gitHub'] = TextEditingController();
                                CardModel card = state.card;
                                newCardBloc.add(AddCardInfoEvent(card));
                              }
                            }),
                        telegram: ExtraInfoWidget(
                            title: 'Telegram',
                            icon: Icon(Icons.telegram, color: Colors.white),
                            onPressed: () {
                              final newCardBloc =
                              BlocProvider.of<NewCardBloc>(context);
                              final state = newCardBloc.state;

                              if (state is NewCardInitialState) {
                                _controllerMap['telegram'] = TextEditingController();
                                CardModel card = state.card;
                                newCardBloc.add(AddCardInfoEvent(card));
                              }
                            }));
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ExtraInfoFooterWidget extends StatelessWidget {

  final ExtraInfoWidget phoneNumber;
  final ExtraInfoWidget email;
  final ExtraInfoWidget link;
  final ExtraInfoWidget linkedIn;
  final ExtraInfoWidget github;
  final ExtraInfoWidget telegram;

  const ExtraInfoFooterWidget({Key? key,
    required this.phoneNumber,
    required this.email,
    required this.link,
    required this.linkedIn,
    required this.github,
    required this.telegram})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectCardColor = BlocProvider.of<SelectCardColorBloc>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
      color: selectCardColor.state.withOpacity(0.2),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [phoneNumber, email, link],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [linkedIn, github, telegram],
          )
        ],
      ),
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
              backgroundColor: selectCardColor.state,
              child: icon
            ),
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

class ChooseColorWidget extends StatelessWidget {
  final Color color;

  const ChooseColorWidget({Key? key, required this.color}) : super(key: key);

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


class CustomTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final bool enabled;


  final Widget? icon;
  final VoidCallback? onTextFieldRemove;


  const CustomTextField({Key? key,
    required this.controller,
    required this.hintText,
    this.enabled = true, this.icon, this.onTextFieldRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColorBloc = BlocProvider.of<SelectCardColorBloc>(context);

    return BlocProvider<TextClearButtonBloc>(
      create: (context) => TextClearButtonBloc(),
      child: Builder(builder: (context) {
        return Row(
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: cardColorBloc.state,
                    child: icon),
              ),
            Expanded(
              child: TextFormField(
                controller: controller,
                enabled: enabled,
                decoration: InputDecoration(
                  //contentPadding: EdgeInsets.all(0),
                  suffixIcon:
                  BlocBuilder<TextClearButtonBloc, TextClearButtonState>(
                    builder: (context, state) {
                      if (state is ClearButtonEnableState) {
                        return IconButton(
                          onPressed: () {
                            controller.clear();
                            final clearButtonBloc =
                            BlocProvider.of<TextClearButtonBloc>(context);
                            clearButtonBloc.add(ClearButtonDisableEvent());
                          },
                          icon: Icon(Icons.highlight_remove_outlined),
                          splashRadius: 20,
                        );
                      }

                      return SizedBox();
                    },
                  ),
                  hintText: hintText,
                  //labelText: 'Name *',
                ),
                onTap: () {
                  if (controller.text.isNotEmpty) {
                    final clearButtonBloc =
                    BlocProvider.of<TextClearButtonBloc>(context);
                    clearButtonBloc.add(ClearButtonEnableEvent());
                  }
                },
                onChanged: (text) {
                  if (controller.text.isEmpty) {
                    final clearButtonBloc =
                    BlocProvider.of<TextClearButtonBloc>(context);
                    clearButtonBloc.add(ClearButtonDisableEvent());
                  } else if (controller.text.length == 1) {
                    final clearButtonBloc =
                    BlocProvider.of<TextClearButtonBloc>(context);
                    clearButtonBloc.add(ClearButtonEnableEvent());
                  }
                },
                //textAlign: TextAlign.center,
              ),
            ),
            if(icon != null)
              IconButton(
                  splashRadius: 20,
                  onPressed: onTextFieldRemove,
                  icon: Icon(Icons.remove_circle_outline)
              )
          ],
        );
      }),
    );
  }
}
