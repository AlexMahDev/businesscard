import 'package:businesscard/data/repositories/storage_repository.dart';
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

  final _validation = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TextFieldBloc>(
          create: (BuildContext context) => TextFieldBloc(),
        ),
        BlocProvider<SelectCardColorBloc>(
          create: (BuildContext context) => SelectCardColorBloc(),
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
                if (state is AddCardLoadingState) {
                  loadingOverlay.show(context);
                } else {
                  loadingOverlay.hide();
                }
                if (state is AddCardSuccessState) {
                  Navigator.of(context).pop();
                }
                if (state is AddCardErrorState) {
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
                  if(_validation.currentState!.validate()) {
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
                  offset: const Offset(-15, 60),
                ),

              ],
            ),
            body: Form(
              key: _validation,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomTextField(
                          hintText: 'Set a title (e.g. Work or Personal)',
                          controller: cardTitle),
                    ),


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

                    ExtraInfoFieldsWidget(controllerMap: _controllerMap),

                    TapFieldBelowWidget(),

                    ExtraInfoFooterWidget(controllerMap: _controllerMap)
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
