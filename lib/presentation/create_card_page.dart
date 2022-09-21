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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
        return MultiBlocListener(
          listeners: [
            BlocListener<CardInfoBloc, CardInfoState>(
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
                      .showSnackBar(
                      SnackBar(content: Text('Something went wrong :(')));
                }
              },
            ),
            BlocListener<ImageBloc, ImageState>(
              bloc: profileImageBloc,
              listener: (context, state) {
                if (state is ImageLoadingState) {
                  loadingOverlay.show(context);
                } else if (state is ImageDeletingState) {
                  loadingOverlay.show(context);
                } else {
                  loadingOverlay.hide();
                }
                if (state is ImagePickErrorState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                      SnackBar(content: Text('Something went wrong :(')));
                }
              },
            ),
            BlocListener<ImageBloc, ImageState>(
              bloc: companyLogoImageBloc,
              listener: (context, state) {
                if (state is ImageLoadingState) {
                  loadingOverlay.show(context);
                } else if (state is ImageDeletingState) {
                  loadingOverlay.show(context);
                } else {
                  loadingOverlay.hide();
                }

                if (state is ImagePickErrorState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                      SnackBar(content: Text('Something went wrong :(')));
                }
              },
            ),
          ],
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
                      qrLink: '',
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
                PopupMenuButton<int>(
                  icon: const Icon(Icons.more_horiz),
                  splashRadius: 20,
                  onSelected: (item) async {
                    switch (item) {
                      case 1:
                        Navigator.pop(context);
                        break;
                    }
                  },
                  itemBuilder: (context) =>
                  [
                    const PopupMenuItem(
                      value: 1,
                      child: Text(
                        "Not save",
                        style: TextStyle(fontWeight: FontWeight.w700,
                            color: Colors.redAccent),
                      ),
                    )
                  ],
                  //icon: Icon(Icons.menu),
                  offset: const Offset(-15, 60),
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
