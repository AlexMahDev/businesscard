import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core_ui/widgets/choose_color_widget.dart';
import '../../core_ui/widgets/custom_app_bar.dart';
import '../../core_ui/widgets/custom_text_field_widget.dart';
import '../../core_ui/widgets/extra_info_fields_widget.dart';
import '../../core_ui/widgets/extra_info_footer_widget.dart';
import '../../core_ui/widgets/general_info_fields_widget.dart';
import '../../core_ui/widgets/image_section_widget.dart';
import '../../core_ui/widgets/loading_overlay_widget.dart';
import '../../core_ui/widgets/tap_field_below_widget.dart';
import '../../data/repositories/storage_repository.dart';
import '../../domain/models/card_model.dart';
import '../../domain/models/extra_info_model.dart';
import '../../domain/models/general_info_model.dart';
import '../../domain/models/settings_model.dart';
import '../../domain/models/text_field_model.dart';
import '../blocs/card_info_bloc/card_info_bloc.dart';
import '../blocs/full_name_dropdown_bloc/full_name_dropdown_bloc.dart';
import '../blocs/image_bloc/image_bloc.dart';
import '../blocs/select_card_color_bloc/select_card_color_bloc.dart';
import '../blocs/text_field_bloc/text_field_bloc.dart';


class EditCardPage extends StatefulWidget {
  final CardModel card;

  const EditCardPage({Key? key, required this.card}) : super(key: key);

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
  late final LoadingOverlay loadingOverlay;
  late final StorageRepository profileImageRepository;
  late final StorageRepository companyLogoRepository;

  final _validation = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    profileImageRepository = StorageRepository()
      ..url = widget.card.generalInfo.profileImage;
    companyLogoRepository = StorageRepository()
      ..url = widget.card.generalInfo.logoImage;
    profileImageBloc = ImageBloc(storageRepository: profileImageRepository)
      ..add(GetImageEvent());
    companyLogoImageBloc = ImageBloc(
        storageRepository: companyLogoRepository
          ..url = widget.card.generalInfo.logoImage)
      ..add(GetImageEvent());
    cardTitle = TextEditingController(text: widget.card.generalInfo.cardTitle);
    fullName = TextEditingController(
        text:
            '${widget.card.generalInfo.firstName} ${widget.card.generalInfo.middleName} ${widget.card.generalInfo.lastName}'
                .trim());
    firstName = TextEditingController(text: widget.card.generalInfo.firstName);
    middleName =
        TextEditingController(text: widget.card.generalInfo.middleName);
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
    jobTitle = TextEditingController(text: widget.card.generalInfo.jobTitle);
    department =
        TextEditingController(text: widget.card.generalInfo.department);
    companyName =
        TextEditingController(text: widget.card.generalInfo.companyName);
    headLine = TextEditingController(text: widget.card.generalInfo.headLine);

    for (TextFieldModel textField in widget.card.extraInfo.listOfFields) {
      TextEditingController controller =
          TextEditingController(text: textField.value);

      _controllerMap[textField.key] = controller;
    }
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TextFieldBloc>(
          create: (BuildContext context) => TextFieldBloc(),
        ),
        BlocProvider<SelectCardColorBloc>(
          create: (BuildContext context) => SelectCardColorBloc()
            ..add(SelectCardColorEvent(widget.card.settings.cardColor)),
        ),
        BlocProvider<FullNameDropdownBloc>(
          create: (BuildContext context) => FullNameDropdownBloc(),
        ),

        BlocProvider<ImageBloc>(
            create: (BuildContext context) => profileImageBloc),
        BlocProvider<ImageBloc>(
            create: (BuildContext context) => companyLogoImageBloc),
      ],
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<CardInfoBloc, CardInfoState>(
              listener: (context, state) {
                if (state is UpdateCardLoadingState) {
                  loadingOverlay.show(context);
                } else if (state is DeleteCardLoadingState) {
                  loadingOverlay.show(context);
                }  else {
                  loadingOverlay.hide();
                }

                if (state is UpdateCardSuccessState ||
                    state is DeleteCardSuccessState) {
                  Navigator.of(context).pop();
                }
                if (state is UpdateCardErrorState || state is DeleteCardErrorState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Something went wrong :(')));
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
                title: Text('Edit Your Card'),
                leading: IconButton(
                  icon: const Icon(Icons.check),
                  splashRadius: 20,
                  onPressed: () {

                    if(_validation.currentState!.validate()) {
                      final cardsInfoBloc =
                      BlocProvider.of<CardInfoBloc>(context);
                      final cardColorBloc =
                      BlocProvider.of<SelectCardColorBloc>(context);

                      final cardsInfoState = cardsInfoBloc.state;


                      CardModel newCard = CardModel(
                          timestamp: widget.card.timestamp,
                          cardId: widget.card.cardId,
                          qrLink:  widget.card.qrLink,
                          settings: SettingsModel(cardColor: cardColorBloc.state),
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
                        cardsInfoBloc.add(UpdateCardEvent(currentCards, newCard));
                      } else if (cardsInfoState is CardInfoEmptyState) {
                        List<CardModel> currentCards = cardsInfoState.cards;

                        cardsInfoBloc.add(UpdateCardEvent(currentCards, newCard));
                      }
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
                        case 2:
                          final cardInfoBloc =
                          BlocProvider.of<CardInfoBloc>(context);
                          final cardInfoState = cardInfoBloc.state;
                          if (cardInfoState is CardInfoLoadedState) {
                            List<CardModel> currentCards = cardInfoState.cards;
                            cardInfoBloc.add(
                                DeleteCardEvent(currentCards, widget.card.cardId));
                          } else if (cardInfoState is CardInfoEmptyState) {
                            List<CardModel> currentCards = cardInfoState.cards;
                            cardInfoBloc.add(
                                DeleteCardEvent(currentCards, widget.card.cardId));
                          }
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Text(
                          "Not save",
                          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.redAccent),
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: 2,
                        child: Text(
                          "Delete",
                          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.redAccent),
                        ),
                      ),
                    ],
                    //icon: Icon(Icons.menu),
                    offset: const Offset(-15, 60),
                  ),

                ],
              ),
              body: Form(
                key: _validation,
                child: SingleChildScrollView(
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
                            controller: fullName,
                            validator: (text) {
                              if(text == '') {
                                return "Name is required";
                              }
                              return null;
                            }),
                        firstName: CustomTextField(
                            hintText: 'First Name', controller: firstName),
                        middleName: CustomTextField(
                            hintText: 'Middle Name', controller: middleName),
                        lastName: CustomTextField(
                            hintText: 'Last Name', controller: lastName),
                        jobTitle: CustomTextField(
                            hintText: 'Job Title',
                            controller: jobTitle,
                            validator: (text) {
                              if(text == '') {
                                return "Job title is required";
                              }
                              return null;
                            }),
                        department: CustomTextField(
                            hintText: 'Department',
                            controller: department,
                            validator: (text) {
                              if(text == '') {
                                return "Department is required";
                              }
                              return null;
                            }),
                        companyName: CustomTextField(
                            hintText: 'Company Name',
                            controller: companyName,
                            validator: (text) {
                              if(text == '') {
                                return "Company name is required";
                              }
                              return null;
                            }),
                        headLine: CustomTextField(
                            hintText: 'Headline', controller: headLine),
                      ),


                      //DYNAMIC TEXT FIELDS
                      ExtraInfoFieldsWidget(controllerMap: _controllerMap),

                      TapFieldBelowWidget(),

                      ExtraInfoFooterWidget(controllerMap: _controllerMap)
                    ],
                  ),
                ),
              )),
        );
      }),
    );
  }
}