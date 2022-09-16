import 'dart:math';

import 'package:businesscard/blocs/card_info_bloc/card_info_bloc.dart';
import 'package:businesscard/blocs/full_name_dropdown_bloc/full_name_dropdown_bloc.dart';
import 'package:businesscard/blocs/image_bloc/image_bloc.dart';

import 'package:businesscard/blocs/select_card_color_bloc/select_card_color_bloc.dart';
import 'package:businesscard/blocs/text_clear_button_bloc/text_clear_button_bloc.dart';
import 'package:businesscard/presentation/widgets/choose_color_widget.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/custom_text_field_widget.dart';
import 'package:businesscard/presentation/widgets/extra_info_fields_widget.dart';
import 'package:businesscard/presentation/widgets/extra_info_footer_widget.dart';
import 'package:businesscard/presentation/widgets/general_info_fields_widget.dart';
import 'package:businesscard/presentation/widgets/image_section_widget.dart';
import 'package:businesscard/presentation/widgets/tap_field_below_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/text_field_bloc/text_field_bloc.dart';
import '../data/models/card_model.dart';

class EditCardPage extends StatefulWidget {

  final CardModel card;

  const EditCardPage({Key? key,required this.card}) : super(key: key);

  @override
  State<EditCardPage> createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
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
  late final ImageBloc profileImageBloc;
  late final ImageBloc companyLogoImageBloc;

  @override
  void initState() {
    super.initState();
    profileImageBloc = ImageBloc()..add(NetworkImageEvent(widget.card.generalInfo.profileImage));
    companyLogoImageBloc = ImageBloc()..add(NetworkImageEvent(widget.card.generalInfo.logoImage));
    cardTitle = TextEditingController(text: widget.card.generalInfo.cardTitle);
    fullName = TextEditingController(text: '${widget.card.generalInfo.firstName} ${widget.card.generalInfo.middleName} ${widget.card.generalInfo.lastName}'.trim());
    firstName = TextEditingController(text: widget.card.generalInfo.firstName);
    middleName = TextEditingController(text: widget.card.generalInfo.middleName);
    lastName = TextEditingController(text: widget.card.generalInfo.lastName);
    firstName.addListener(() {
      fullName.text =
          '${firstName.text} ${middleName.text} ${lastName.text}'.trim();
    });
    lastName.addListener(() {
      fullName.text =
          '${firstName.text} ${middleName.text} ${lastName.text}'.trim();
    });
    middleName.addListener(() {
      fullName.text =
          '${firstName.text} ${middleName.text} ${lastName.text}'.trim();
    });
    // firstName = TextEditingController();
    // middleName = TextEditingController();
    // lastName = TextEditingController();
    jobTitle = TextEditingController(text: widget.card.generalInfo.jobTitle);
    department = TextEditingController(text: widget.card.generalInfo.department);
    companyName = TextEditingController(text: widget.card.generalInfo.companyName);
    headLine = TextEditingController(text: widget.card.generalInfo.headLine);

    for(TextFieldModel textField in widget.card.extraInfo.listOfFields) {

      TextEditingController controller = TextEditingController(text: textField.value);

      _controllerMap[textField.key] = controller;

    }

  }

  @override
  void dispose() {
    cardTitle.dispose();
    fullName.dispose();
    firstName.dispose();
    middleName.dispose();
    lastName.dispose();
    jobTitle.dispose();
    department.dispose();
    companyName.dispose();
    headLine.dispose();
    _controllerMap.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<NewCardBloc>(
        //   create: (BuildContext context) => NewCardBloc(),
        // ),
        BlocProvider<TextFieldBloc>(
          create: (BuildContext context) => TextFieldBloc(),
        ),
        BlocProvider<SelectCardColorBloc>(
          create: (BuildContext context) => SelectCardColorBloc()..add(SelectCardColorEvent(widget.card.settings.cardColor)),
        ),
        BlocProvider<FullNameDropdownBloc>(
          create: (BuildContext context) => FullNameDropdownBloc(),
        ),
        // BlocProvider<ImageBloc>(
        //   create: (BuildContext context) => imageBloc
        // ),
        BlocProvider<ImageBloc>(
            create: (BuildContext context) => profileImageBloc),
        BlocProvider<ImageBloc>(
            create: (BuildContext context) => companyLogoImageBloc),

        // BlocProvider<CardInfoBloc>(
        //   create: (BuildContext context) =>  CardInfoBloc(),
        // ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: CustomAppBar(
            title: Text('Edit Your Card'),
            leading: IconButton(
              icon: const Icon(Icons.check),
              splashRadius: 20,
              onPressed: () {
                final cardsInfoBloc = BlocProvider.of<CardInfoBloc>(context);
                final cardColorBloc =
                    BlocProvider.of<SelectCardColorBloc>(context);

                final cardsInfoState = cardsInfoBloc.state;

                CardModel newCard = CardModel(
                    cardId: widget.card.cardId,
                    settings: SettingsModel(
                        cardColor: cardColorBloc.state),
                    generalInfo: GeneralInfoModel(
                        cardTitle: cardTitle.text.isNotEmpty
                            ? cardTitle.text
                            : 'Card',
                        firstName: firstName.text,
                        middleName: middleName.text,
                        lastName: lastName.text,
                        jobTitle: jobTitle.text,
                        department: department.text,
                        companyName: companyName.text,
                        headLine: headLine.text,
                        profileImage: '',
                        logoImage: ''),
                    extraInfo: ExtraInfoModel(listOfFields: []));

                _controllerMap.forEach((key, value) {
                  newCard.extraInfo.listOfFields
                      .add(TextFieldModel(key: key, value: value.text));
                });

                if (cardsInfoState is CardInfoLoadedState) {

                  List<CardModel> currentCards = cardsInfoState.cards;

                  cardsInfoBloc.add(AddCardEvent(currentCards, newCard));

                } else if (cardsInfoState is CardInfoEmptyState) {

                  cardsInfoBloc.add(AddCardEvent(const [], newCard));

                }

                //Navigator.of(context).pop();
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
        //   cardTitle.text = state.cards[widget.cardIndex].settings.cardTitle;
        //   firstName.text = state.cards[widget.cardIndex].generalInfo.firstName;
        //   middleName.text = state.cards[widget.cardIndex].generalInfo.middleName;
        //   lastName.text = state.cards[widget.cardIndex].generalInfo.lastName;
        //   jobTitle.text = state.cards[widget.cardIndex].generalInfo.jobTitle;
        //   department.text = state.cards[widget.cardIndex].generalInfo.department;
        //   companyName.text = state.cards[widget.cardIndex].generalInfo.companyName;
        // headLine.text = state.cards[widget.cardIndex].generalInfo.headLine;
          body: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomTextField(
                    hintText: 'Set a title (e.g. Work or Personal)',
                    controller: cardTitle,
                  ),
                ),

                // SizedBox(
                //   height: 20,
                // ),

                ChooseColorWidget(),

                ImageSectionWidget(
                    imageBloc: profileImageBloc,
                    addTitle: 'Add Profile Picture',
                    editTitle: 'Edit Profile Picture',
                    removeTitle: 'Remove Profile Picture'),

                SizedBox(
                  height: 30,
                ),

                ImageSectionWidget(
                    imageBloc: companyLogoImageBloc,
                    addTitle: 'Add Company Logo',
                    editTitle: 'Edit Company Logo',
                    removeTitle: 'Remove Company Logo'),



                GeneralInfoFieldsWidget(
                  fullName: CustomTextField(
                      hintText: 'Full Name',
                      enabled: false,
                      controller: fullName),
                  firstName: CustomTextField(
                      hintText: 'First Name',
                      controller: firstName),
                  middleName: CustomTextField(
                      hintText: 'Middle Name',
                      controller: middleName),
                  lastName: CustomTextField(
                      hintText: 'Last Name',
                      controller: lastName),
                  jobTitle: CustomTextField(
                      hintText: 'Job Title', controller: jobTitle),
                  department: CustomTextField(
                      hintText: 'Department', controller: department),
                  companyName: CustomTextField(
                      hintText: 'Company Name', controller: companyName),
                  headLine: CustomTextField(
                      hintText: 'Headline', controller: headLine),
                ),

                // ///STATIC TEXT FIELDS
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 15.0, vertical: 30),
                //   child: GeneralTextFields(controller: TextEditingController())
                // ),

                ///DYNAMIC TEXT FIELDS
                ExtraInfoFieldsWidget(controllerMap: _controllerMap),

                TapFieldBelowWidget(),


                ExtraInfoFooterWidget(controllerMap: _controllerMap)

              ],
            ),
          )
        );
      }),
    );
  }
}


// class ImagePickSourceBottomSheet extends StatelessWidget {
//   final ImageBloc imageBloc;
//
//   const ImagePickSourceBottomSheet({Key? key, required this.imageBloc})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     //final imageBloc = BlocProvider.of<ImageBloc>(context);
//
//     return SizedBox(
//       height: 250,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               height: 110,
//               decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.9),
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         imageBloc.add(PickImageEvent(true));
//                         Navigator.pop(context);
//                       },
//                       child: Center(
//                           child: Text('Select from photo library',
//                               style: TextStyle(
//                                   color: Colors.redAccent, fontSize: 18))),
//                     ),
//                   ),
//                   Divider(
//                     height: 1,
//                   ),
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         imageBloc.add(PickImageEvent(false));
//                         Navigator.pop(context);
//                       },
//                       child: Center(
//                           child: Text('Take photo',
//                               style: TextStyle(
//                                   color: Colors.redAccent, fontSize: 18))),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 height: 55,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 child: Center(
//                     child: Text('Cancel',
//                         style: TextStyle(
//                             color: Colors.redAccent,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18))),
//               ),
//             ),
//           ],
//         ),
//       ),
//       // child: Center(
//       //   child: Column(
//       //     mainAxisAlignment: MainAxisAlignment.center,
//       //     mainAxisSize: MainAxisSize.min,
//       //     children: <Widget>[
//       //       const Text('Modal BottomSheet'),
//       //       ElevatedButton(
//       //         child: const Text('Close BottomSheet'),
//       //         onPressed: () => Navigator.pop(context),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }
//
// class ExtraInfoFooterWidget extends StatelessWidget {
//   final ExtraInfoWidget phoneNumber;
//   final ExtraInfoWidget email;
//   final ExtraInfoWidget link;
//   final ExtraInfoWidget linkedIn;
//   final ExtraInfoWidget github;
//   final ExtraInfoWidget telegram;
//
//   const ExtraInfoFooterWidget(
//       {Key? key,
//       required this.phoneNumber,
//       required this.email,
//       required this.link,
//       required this.linkedIn,
//       required this.github,
//       required this.telegram})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final selectCardColor = BlocProvider.of<SelectCardColorBloc>(context);
//
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
//       color: selectCardColor.state.withOpacity(0.2),
//       child: Column(
//         //crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [phoneNumber, email, link],
//           ),
//           SizedBox(
//             height: 25,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [linkedIn, github, telegram],
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class ExtraInfoWidget extends StatelessWidget {
//   final String title;
//   final Widget icon;
//   final VoidCallback onPressed;
//
//   const ExtraInfoWidget(
//       {Key? key,
//       required this.title,
//       required this.icon,
//       required this.onPressed})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final selectCardColor = BlocProvider.of<SelectCardColorBloc>(context);
//
//     return GestureDetector(
//       onTap: onPressed,
//       child: SizedBox(
//         width: 90,
//         height: 100,
//         child: Column(
//           //mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             CircleAvatar(
//                 radius: 20,
//                 backgroundColor: selectCardColor.state,
//                 child: icon),
//             // SizedBox(
//             //   height: 10,
//             // ),
//             Expanded(
//                 child: Center(
//                     child: Text(title,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 17))))
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ChooseColorWidget extends StatelessWidget {
//   final Color color;
//
//   const ChooseColorWidget({Key? key, required this.color}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final selectCardColor = BlocProvider.of<SelectCardColorBloc>(context);
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: GestureDetector(
//         onTap: () {
//           selectCardColor.add(SelectCardColorEvent(color));
//         },
//         child: Container(
//           width: 50.0,
//           height: 50.0,
//           decoration: BoxDecoration(
//             //color: Colors.redAccent,
//             shape: BoxShape.circle,
//             border: Border.all(
//                 color: selectCardColor.state == color
//                     ? Colors.grey
//                     : Colors.transparent,
//                 width: 2),
//           ),
//           child: Center(
//             child: Container(
//               width: 30.0,
//               height: 30.0,
//               decoration: BoxDecoration(
//                 color: color,
//                 shape: BoxShape.circle,
//                 //border: Border.all(color: Colors.black),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final bool enabled;
//
//   final Widget? icon;
//   final VoidCallback? onTextFieldRemove;
//
//   const CustomTextField(
//       {Key? key,
//       required this.controller,
//       required this.hintText,
//       this.enabled = true,
//       this.icon,
//       this.onTextFieldRemove})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final cardColorBloc = BlocProvider.of<SelectCardColorBloc>(context);
//
//     return BlocProvider<TextClearButtonBloc>(
//       create: (context) => TextClearButtonBloc(),
//       child: Builder(builder: (context) {
//         return Row(
//           children: [
//             if (icon != null)
//               Padding(
//                 padding: const EdgeInsets.only(right: 15.0),
//                 child: CircleAvatar(
//                     radius: 20,
//                     backgroundColor: cardColorBloc.state,
//                     child: icon),
//               ),
//             Expanded(
//               child: TextFormField(
//                 controller: controller,
//                 enabled: enabled,
//                 decoration: InputDecoration(
//                   //contentPadding: EdgeInsets.all(0),
//                   suffixIcon:
//                       BlocBuilder<TextClearButtonBloc, TextClearButtonState>(
//                     builder: (context, state) {
//                       if (state is ClearButtonEnableState) {
//                         return IconButton(
//                           onPressed: () {
//                             controller.clear();
//                             final clearButtonBloc =
//                                 BlocProvider.of<TextClearButtonBloc>(context);
//                             clearButtonBloc.add(ClearButtonDisableEvent());
//                           },
//                           icon: Icon(Icons.highlight_remove_outlined),
//                           splashRadius: 20,
//                         );
//                       }
//
//                       return SizedBox();
//                     },
//                   ),
//                   hintText: hintText,
//                   //labelText: 'Name *',
//                 ),
//                 onTap: () {
//                   if (controller.text.isNotEmpty) {
//                     final clearButtonBloc =
//                         BlocProvider.of<TextClearButtonBloc>(context);
//                     clearButtonBloc.add(ClearButtonEnableEvent());
//                   }
//                 },
//                 onChanged: (text) {
//                   if (controller.text.isEmpty) {
//                     final clearButtonBloc =
//                         BlocProvider.of<TextClearButtonBloc>(context);
//                     clearButtonBloc.add(ClearButtonDisableEvent());
//                   } else if (controller.text.length == 1) {
//                     final clearButtonBloc =
//                         BlocProvider.of<TextClearButtonBloc>(context);
//                     clearButtonBloc.add(ClearButtonEnableEvent());
//                   }
//                 },
//                 //textAlign: TextAlign.center,
//               ),
//             ),
//             if (icon != null)
//               IconButton(
//                   splashRadius: 20,
//                   onPressed: onTextFieldRemove,
//                   icon: Icon(Icons.remove_circle_outline))
//           ],
//         );
//       }),
//     );
//   }
// }
