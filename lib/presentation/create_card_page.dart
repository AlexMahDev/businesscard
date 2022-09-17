import 'dart:math';

import 'package:businesscard/blocs/card_info_bloc/card_info_bloc.dart';
import 'package:businesscard/blocs/full_name_dropdown_bloc/full_name_dropdown_bloc.dart';
import 'package:businesscard/blocs/image_bloc/image_bloc.dart';
import 'package:businesscard/blocs/select_card_color_bloc/select_card_color_bloc.dart';
import 'package:businesscard/blocs/text_clear_button_bloc/text_clear_button_bloc.dart';
import 'package:businesscard/blocs/text_field_bloc/text_field_bloc.dart';
import 'package:businesscard/data/repositories/storage_repository.dart';
import 'package:businesscard/presentation/widgets/choose_color_widget.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/custom_text_field_widget.dart';
import 'package:businesscard/presentation/widgets/extra_info_fields_widget.dart';
import 'package:businesscard/presentation/widgets/extra_info_footer_widget.dart';
import 'package:businesscard/presentation/widgets/general_info_fields_widget.dart';
import 'package:businesscard/presentation/widgets/image_section_widget.dart';
import 'package:businesscard/presentation/widgets/loading_overlay_widget.dart';
import 'package:businesscard/presentation/widgets/tap_field_below_widget.dart';
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
  late final ImageBloc profileImageBloc;
  late final ImageBloc companyLogoImageBloc;
  late final LoadingOverlay loadingOverlay;
  late final StorageRepository profileImageRepository;
  late final StorageRepository companyLogoRepository;

  @override
  void initState() {
    super.initState();
    profileImageRepository = StorageRepository();
    companyLogoRepository = StorageRepository();
    profileImageBloc = ImageBloc(storageRepository: profileImageRepository);
    companyLogoImageBloc = ImageBloc(storageRepository: companyLogoRepository);
    cardTitle = TextEditingController();
    fullName = TextEditingController();
    firstName = TextEditingController();
    middleName = TextEditingController();
    lastName = TextEditingController();
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
    jobTitle = TextEditingController();
    department = TextEditingController();
    companyName = TextEditingController();
    headLine = TextEditingController();
    loadingOverlay = LoadingOverlay();
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

  // TextEditingController _getControllerOf(String name) {
  //   var controller = _controllerMap[name];
  //   if (controller == null) {
  //     controller = TextEditingController();
  //     _controllerMap[name] = controller;
  //   }
  //   //print(_controllerMap.length);
  //   return controller;
  // }
  //
  // String getHintText(String key) {
  //   if (key == 'phoneNumber') {
  //     return 'Phone Number';
  //   } else if (key == 'email') {
  //     return 'Email';
  //   } else if (key == 'link') {
  //     return 'Link';
  //   } else if (key == 'linkedIn') {
  //     return 'LinkedIn';
  //   } else if (key == 'gitHub') {
  //     return 'GitHub';
  //   } else if (key == 'telegram') {
  //     return 'Telegram';
  //   } else {
  //     return '';
  //   }
  // }
  //
  // Widget getIcon(String key) {
  //   if (key == 'phoneNumber') {
  //     return Icon(Icons.phone, color: Colors.white);
  //   } else if (key == 'email') {
  //     return Icon(Icons.email, color: Colors.white);
  //   } else if (key == 'link') {
  //     return Icon(Icons.link, color: Colors.white);
  //   } else if (key == 'linkedIn') {
  //     return Image.asset('assets/images/icons/linkedin-icon.png',
  //         color: Colors.white, height: 20);
  //   } else if (key == 'gitHub') {
  //     return Image.asset('assets/images/icons/github-icon.png',
  //         color: Colors.white, height: 20);
  //   } else if (key == 'telegram') {
  //     return Icon(Icons.telegram, color: Colors.white);
  //   } else {
  //     return Icon(Icons.add_circle_outline_rounded, color: Colors.white);
  //   }
  // }

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
          create: (BuildContext context) => SelectCardColorBloc(),
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
        return BlocListener<CardInfoBloc, CardInfoState>(
          listener: (context, state) {
            if (state is CardInfoLoadingState) {
              loadingOverlay.show(context);
            } else {
              loadingOverlay.hide();
            }
            if (state is CardInfoLoadedState) {
              Navigator.of(context).pop();
            }
            if (state is CardInfoErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('state.error')));
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(
              title: Text('Create A Card'),
              leading: IconButton(
                icon: const Icon(Icons.check),
                splashRadius: 20,
                onPressed: () {
                  final cardsInfoBloc = BlocProvider.of<CardInfoBloc>(
                      context);
                  final cardColorBloc =
                  BlocProvider.of<SelectCardColorBloc>(context);

                  final cardsInfoState = cardsInfoBloc.state;

                  CardModel newCard = CardModel(
                      timestamp: DateTime
                          .now()
                          .millisecondsSinceEpoch,
                      cardId: '',
                      settings: SettingsModel(
                          cardColor: cardColorBloc.state),
                      generalInfo: GeneralInfoModel(
                          cardTitle: cardTitle.text.isNotEmpty
                              ? cardTitle.text
                              : 'BCard',
                          firstName: firstName.text,
                          middleName: middleName.text,
                          lastName: lastName.text,
                          jobTitle: jobTitle.text,
                          department: department.text,
                          companyName: companyName.text,
                          headLine: headLine.text,
                          profileImage: profileImageRepository.url,
                          logoImage: companyLogoRepository.url),
                      extraInfo: ExtraInfoModel(listOfFields: []));

                  _controllerMap.forEach((key, value) {
                    newCard.extraInfo.listOfFields
                        .add(TextFieldModel(key: key, value: value.text));
                  });

                  if (cardsInfoState is CardInfoLoadedState) {
                    List<CardModel> currentCards = cardsInfoState.cards;

                    cardsInfoBloc.add(AddCardEvent(currentCards, newCard));
                  } else if (cardsInfoState is CardInfoEmptyState) {
                    List<CardModel> currentCards = cardsInfoState.cards;
                    cardsInfoBloc.add(AddCardEvent(currentCards, newCard));
                  }
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

                  ChooseColorWidget(),

                  // BlocBuilder<SelectCardColorBloc, Color>(
                  //   builder: (context, state) {
                  //     return SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 10.0, vertical: 20),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             ColorWidget(color: Colors.redAccent),
                  //             ColorWidget(color: Colors.orange),
                  //             ColorWidget(color: Colors.yellow),
                  //             ColorWidget(color: Colors.brown),
                  //             ColorWidget(color: Colors.green),
                  //             ColorWidget(color: Colors.lightBlueAccent),
                  //             ColorWidget(color: Colors.blue),
                  //             ColorWidget(color: Colors.purple),
                  //             ColorWidget(color: Colors.purpleAccent),
                  //             ColorWidget(color: Colors.black),
                  //             ColorWidget(color: Colors.grey)
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),

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
                        hintText: 'First Name', controller: firstName),
                    middleName: CustomTextField(
                        hintText: 'Middle Name', controller: middleName),
                    lastName: CustomTextField(
                        hintText: 'Last Name', controller: lastName),
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
            ),
          ),
        );
      }),
    );
  }
}

// class GeneralInfoFieldsWidget extends StatelessWidget {
//
//   final CustomTextField fullName;
//   final CustomTextField firstName;
//   final CustomTextField middleName;
//   final CustomTextField lastName;
//   final CustomTextField jobTitle;
//   final CustomTextField department;
//   final CustomTextField companyName;
//   final CustomTextField headLine;
//
//
//   const GeneralInfoFieldsWidget(
//       {Key? key, required this.fullName, required this.firstName, required this.middleName, required this.lastName, required this.jobTitle, required this.department, required this.companyName, required this.headLine})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: 15.0, vertical: 30),
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: () {
//               final fullNameDropdownBloc =
//               BlocProvider.of<FullNameDropdownBloc>(context);
//
//               final fullNameDropdownState =
//                   fullNameDropdownBloc.state;
//
//               if (fullNameDropdownState
//               is FullNameDropdownCloseState) {
//                 fullNameDropdownBloc
//                     .add(FullNameDropdownOpenEvent());
//               } else {
//                 fullNameDropdownBloc
//                     .add(FullNameDropdownCloseEvent());
//               }
//             },
//             child: Row(
//               children: [
//                 Expanded(
//                   child: fullName,
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 BlocBuilder<FullNameDropdownBloc,
//                     FullNameDropdownState>(
//                   builder: (context, state) {
//                     if (state is FullNameDropdownOpenState) {
//                       return Icon(Icons.keyboard_arrow_up,
//                           size: 50, color: Colors.redAccent);
//                     }
//                     if (state is FullNameDropdownCloseState) {
//                       return Icon(Icons.keyboard_arrow_down,
//                           size: 50, color: Colors.redAccent);
//                     }
//
//                     return Container();
//                   },
//                 )
//               ],
//             ),
//           ),
//           BlocBuilder<FullNameDropdownBloc, FullNameDropdownState>(
//             builder: (context, state) {
//               if (state is FullNameDropdownOpenState) {
//                 return Padding(
//                   padding: const EdgeInsets.only(left: 20, top: 15),
//                   child: Column(
//                     children: [
//                       firstName,
//                       SizedBox(
//                         height: 15,
//                       ),
//                       middleName,
//                       SizedBox(
//                         height: 15,
//                       ),
//                       lastName,
//                     ],
//                   ),
//                 );
//               }
//
//               return Container();
//             },
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           jobTitle,
//           SizedBox(
//             height: 15,
//           ),
//           department,
//           SizedBox(
//             height: 15,
//           ),
//           companyName,
//           SizedBox(
//             height: 15,
//           ),
//           headLine
//         ],
//       ),
//     );
//   }
// }

//
// class ImagePickSourceBottomSheet extends StatelessWidget {
//   //final ImageBloc imageBloc;
//
//   const ImagePickSourceBottomSheet({Key? key})
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
//                         final imageBloc = BlocProvider.of<ImageBloc>(context);
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
//                         final imageBloc = BlocProvider.of<ImageBloc>(context);
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
//
//   final Map<String, TextEditingController> controllerMap;
//
//
//   const ExtraInfoFooterWidget({Key? key, required this.controllerMap})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SelectCardColorBloc, Color>(
//       builder: (context, state) {
//         return Container(
//           padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
//           color: state.withOpacity(0.2),
//           child: Column(
//             //crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ExtraInfoWidget(
//                     title: 'Phone Number',
//                     icon: Icon(Icons.phone, color: Colors.white),
//                     onPressed: () {
//                       final textFieldBloc =
//                       BlocProvider.of<TextFieldBloc>(context);
//                       final state = textFieldBloc.state;
//
//                       if (state is TextFieldInitialState) {
//                         controllerMap['phoneNumber'] =
//                             TextEditingController();
//                         textFieldBloc.add(AddTextFieldEvent());
//                       }
//                     }),
//                   ExtraInfoWidget(
//                       title: 'Email',
//                       icon: Icon(Icons.phone, color: Colors.white),
//                       onPressed: () {
//                         final textFieldBloc =
//                         BlocProvider.of<TextFieldBloc>(context);
//                         final state = textFieldBloc.state;
//
//                         if (state is TextFieldInitialState) {
//                           controllerMap['email'] =
//                               TextEditingController();
//                           textFieldBloc.add(AddTextFieldEvent());
//                         }
//                       }),
//                   ExtraInfoWidget(
//                       title: 'Link',
//                       icon: Icon(Icons.phone, color: Colors.white),
//                       onPressed: () {
//                         final textFieldBloc =
//                         BlocProvider.of<TextFieldBloc>(context);
//                         final state = textFieldBloc.state;
//
//                         if (state is TextFieldInitialState) {
//                           controllerMap['link'] =
//                               TextEditingController();
//                           textFieldBloc.add(AddTextFieldEvent());
//                         }
//                       }),
//                 ],
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ExtraInfoWidget(
//                       title: 'LinkedIn',
//                       icon: Icon(Icons.phone, color: Colors.white),
//                       onPressed: () {
//                         final textFieldBloc =
//                         BlocProvider.of<TextFieldBloc>(context);
//                         final state = textFieldBloc.state;
//
//                         if (state is TextFieldInitialState) {
//                           controllerMap['linkedIn'] =
//                               TextEditingController();
//                           textFieldBloc.add(AddTextFieldEvent());
//                         }
//                       }),
//                   ExtraInfoWidget(
//                       title: 'GitHub',
//                       icon: Icon(Icons.phone, color: Colors.white),
//                       onPressed: () {
//                         final textFieldBloc =
//                         BlocProvider.of<TextFieldBloc>(context);
//                         final state = textFieldBloc.state;
//
//                         if (state is TextFieldInitialState) {
//                           controllerMap['gitHub'] =
//                               TextEditingController();
//                           textFieldBloc.add(AddTextFieldEvent());
//                         }
//                       }),
//                   ExtraInfoWidget(
//                       title: 'Telegram',
//                       icon: Icon(Icons.phone, color: Colors.white),
//                       onPressed: () {
//                         final textFieldBloc =
//                         BlocProvider.of<TextFieldBloc>(context);
//                         final state = textFieldBloc.state;
//
//                         if (state is TextFieldInitialState) {
//                           controllerMap['telegram'] =
//                               TextEditingController();
//                           textFieldBloc.add(AddTextFieldEvent());
//                         }
//                       }),
//                 ],
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class ExtraInfoWidget extends StatelessWidget {
//   final String title;
//   final Widget icon;
//   final VoidCallback onPressed;
//
//   const ExtraInfoWidget({Key? key,
//     required this.title,
//     required this.icon,
//     required this.onPressed})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
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
//
// class ImageSectionWidget extends StatelessWidget {
//
//   final ImageBloc imageBloc;
//
//   const ImageSectionWidget({Key? key, required this.imageBloc})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ImageBloc, ImageState>(
//       bloc: imageBloc,
//       builder: (context, state) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (state is ImagePickLoadedState)
//                 Expanded(
//                     child: Image.file(state.image, height: 150)),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         showModalBottomSheet<void>(
//                           context: context,
//                           backgroundColor: Colors.transparent,
//                           builder: (BuildContext context) {
//                             return BlocProvider.value(
//                               value: imageBloc,
//                               child: ImagePickSourceBottomSheet(),
//                             );
//                           },
//                         );
//                       },
//                       child: Text(
//                         state is ImagePickLoadedState
//                             ? 'Edit Profile Picture'
//                             : 'Add Profile Picture',
//                         style: TextStyle(
//                             color: Colors.redAccent,
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     if (state is ImagePickLoadedState)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20.0),
//                         child: GestureDetector(
//                           onTap: () {
//                             imageBloc
//                                 .add(RemoveImageEvent());
//                           },
//                           child: Text(
//                             'Remove Profile Picture',
//                             style: TextStyle(
//                                 color: Colors.redAccent,
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
//
// class ChooseColorWidget extends StatelessWidget {
//   const ChooseColorWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SelectCardColorBloc, Color>(
//       builder: (context, state) {
//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 10.0, vertical: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 ColorWidget(color: Colors.redAccent),
//                 ColorWidget(color: Colors.orange),
//                 ColorWidget(color: Colors.yellow),
//                 ColorWidget(color: Colors.brown),
//                 ColorWidget(color: Colors.green),
//                 ColorWidget(color: Colors.lightBlueAccent),
//                 ColorWidget(color: Colors.blue),
//                 ColorWidget(color: Colors.purple),
//                 ColorWidget(color: Colors.purpleAccent),
//                 ColorWidget(color: Colors.black),
//                 ColorWidget(color: Colors.grey)
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
//
// class ColorWidget extends StatelessWidget {
//
//   final Color color;
//
//   const ColorWidget({Key? key, required this.color}) : super(key: key);
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
//   const CustomTextField({Key? key,
//     required this.controller,
//     required this.hintText,
//     this.enabled = true,
//     this.icon,
//     this.onTextFieldRemove})
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
//                   BlocBuilder<TextClearButtonBloc, TextClearButtonState>(
//                     builder: (context, state) {
//                       if (state is ClearButtonEnableState) {
//                         return IconButton(
//                           onPressed: () {
//                             controller.clear();
//                             final clearButtonBloc =
//                             BlocProvider.of<TextClearButtonBloc>(context);
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
//                     BlocProvider.of<TextClearButtonBloc>(context);
//                     clearButtonBloc.add(ClearButtonEnableEvent());
//                   }
//                 },
//                 onChanged: (text) {
//                   if (controller.text.isEmpty) {
//                     final clearButtonBloc =
//                     BlocProvider.of<TextClearButtonBloc>(context);
//                     clearButtonBloc.add(ClearButtonDisableEvent());
//                   } else if (controller.text.length == 1) {
//                     final clearButtonBloc =
//                     BlocProvider.of<TextClearButtonBloc>(context);
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
