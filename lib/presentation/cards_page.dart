import 'package:businesscard/blocs/card_info_bloc/card_info_bloc.dart';
import 'package:businesscard/blocs/card_page_bloc/card_page_bloc.dart';
import 'package:businesscard/blocs/select_card_color_bloc/select_card_color_bloc.dart';
import 'package:businesscard/presentation/welcome_page.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/custom_float_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../data/models/card_model.dart';
import 'create_card_page.dart';
import 'edit_card_page.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  String getHintText(String key) {
    if (key == 'phoneNumber') {
      return 'Phone Number';
    } else if (key == 'email') {
      return 'Email';
    } else if (key == 'link') {
      return 'Link';
    } else if (key == 'linkedIn') {
      return 'LinkedIn';
    } else if (key == 'gitHub') {
      return 'GitHub';
    } else if (key == 'telegram') {
      return 'Telegram';
    } else {
      return '';
    }
  }

  Widget getIcon(String key) {
    if (key == 'phoneNumber') {
      return Icon(Icons.phone, color: Colors.white);
    } else if (key == 'email') {
      return Icon(Icons.email, color: Colors.white);
    } else if (key == 'link') {
      return Icon(Icons.link, color: Colors.white);
    } else if (key == 'linkedIn') {
      return Image.asset('assets/images/icons/linkedin-icon.png',
          color: Colors.white, height: 20);
    } else if (key == 'gitHub') {
      return Image.asset('assets/images/icons/github-icon.png',
          color: Colors.white, height: 20);
    } else if (key == 'telegram') {
      return Icon(Icons.telegram, color: Colors.white);
    } else {
      return Icon(Icons.add_circle_outline_rounded, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    // print(user.uid);
    return BlocProvider<CardPageBloc>(
      create: (context) => CardPageBloc(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: BlocBuilder<CardInfoBloc, CardInfoState>(
            builder: (context, cardInfoState) {
              if (cardInfoState is CardInfoLoadedState) {
                return BlocBuilder<CardPageBloc, int>(
                  builder: (context, cardPageState) {
                    return Text(cardInfoState
                        .cards[cardPageState].generalInfo.cardTitle);
                  },
                );
              }
              return Text('Cards');
            },
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            splashRadius: 20,
            onPressed: () async {

              // final doc = FirebaseFirestore.instance.collection("users").doc("S4lc2BkgjnPbjlnUPMmfMcb2F012").collection("contacts");
              //
              // await doc.doc().set({'test' : 'test'});

              // final info = await FirebaseFirestore.instance.collection("users").doc('uid-1').collection("cards").get();
              // print(info.docs.first.data());
              context.read<AuthBloc>().add(SignOutRequested());
            },
          ),
          actions: [
            BlocBuilder<CardInfoBloc, CardInfoState>(
              builder: (context, state) {
                if (state is CardInfoLoadedState) {
                  return IconButton(
                    icon: const Icon(Icons.add),
                    splashRadius: 20,
                    onPressed: () {
                      final cardInfoBloc =
                          BlocProvider.of<CardInfoBloc>(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => BlocProvider.value(
                                value: cardInfoBloc,
                                child: CreateCardPage(),
                              )));
                    },
                  );
                }
                return Container();
              },
            ),
            BlocBuilder<CardInfoBloc, CardInfoState>(
              builder: (context, state) {
                if (state is CardInfoLoadedState) {
                  return IconButton(
                    icon: const Icon(Icons.edit),
                    splashRadius: 20,
                    onPressed: () {
                      final cardInfoBloc =
                          BlocProvider.of<CardInfoBloc>(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => BlocProvider.value(
                                value: cardInfoBloc,
                                child: EditCardPage(
                                    card: state.cards[
                                        pageController.page?.round() ?? 0]),
                              )));
                    },
                  );
                }

                return Container();
              },
            ),
          ],
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              // Navigate to the sign in screen when the user Signs Out
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomePage()),
                (route) => false,
              );
            }
          },
          child: BlocBuilder<CardInfoBloc, CardInfoState>(
            builder: (context, state) {
              if (state is CardInfoLoadingState) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is CardInfoLoadedState) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemCount: state.cards.length,
                      onPageChanged: (page) {
                        final cardPageBloc =
                            BlocProvider.of<CardPageBloc>(context);

                        cardPageBloc.add(ChangeCardPageEvent(page));
                      },
                      itemBuilder: (context, position) {
                        //print(state.cards[position].settings.cardColor);
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                  height: 250,
                                  child:
                                      Image.asset('assets/images/qr_code.png')),
                              Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.bottomRight,
                                children: [
                                  Column(
                                    children: [
                                      if (state.cards[position].generalInfo
                                          .logoImage.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40.0),
                                          child: Image.network(
                                              state.cards[position].generalInfo
                                                  .logoImage,
                                              height: 200, errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                            return Container();
                                          }),
                                          // Image.asset(
                                          //     'assets/images/innowise-logo.png')),
                                        ),
                                      Divider(
                                        color: Color(state.cards[position]
                                                .settings.cardColor)
                                            .withOpacity(0.2),
                                        thickness: 5,
                                      ),
                                    ],
                                  ),
                                  if (state.cards[position].generalInfo
                                      .profileImage.isNotEmpty)
                                    Positioned(
                                      //top: 170,
                                      bottom: -30,
                                      right: 15,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ClipOval(
                                            child: Image.network(
                                                state.cards[position]
                                                    .generalInfo.profileImage,
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover, errorBuilder:
                                                    (BuildContext context,
                                                        Object exception,
                                                        StackTrace?
                                                            stackTrace) {
                                              return Container();
                                            }),

                                            // Image.asset(
                                            //   'assets/images/avatar.jpg',
                                            //   width: 80,
                                            //   height: 80,
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (state.cards[position].generalInfo
                                            .firstName.isNotEmpty ||
                                        state.cards[position].generalInfo
                                            .middleName.isNotEmpty ||
                                        state.cards[position].generalInfo
                                            .lastName.isNotEmpty)
                                      GeneralTextWidget(
                                          label: 'fullName',
                                          value:
                                              '${state.cards[position].generalInfo.firstName} ${state.cards[position].generalInfo.middleName} ${state.cards[position].generalInfo.lastName}'
                                                  .trim()),
                                    if (state.cards[position].generalInfo
                                        .jobTitle.isNotEmpty)
                                      GeneralTextWidget(
                                          value: state.cards[position]
                                              .generalInfo.jobTitle),
                                    if (state.cards[position].generalInfo
                                        .department.isNotEmpty)
                                      GeneralTextWidget(
                                          value: state.cards[position]
                                              .generalInfo.department),
                                    if (state.cards[position].generalInfo
                                        .companyName.isNotEmpty)
                                      GeneralTextWidget(
                                          value: state.cards[position]
                                              .generalInfo.companyName),
                                    if (state.cards[position].generalInfo
                                        .headLine.isNotEmpty)
                                      GeneralTextWidget(
                                          label: 'headline',
                                          value: state.cards[position]
                                              .generalInfo.headLine),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                itemCount: state.cards[position].extraInfo
                                    .listOfFields.length,
                                //padding: EdgeInsets.only(top: 15),
                                itemBuilder: (BuildContext context, int index) {
                                  return ExtraTextWidget(
                                      label: getHintText(state.cards[position]
                                          .extraInfo.listOfFields[index].key),
                                      value: state.cards[position].extraInfo
                                          .listOfFields[index].value,
                                      color: state
                                          .cards[position].settings.cardColor,
                                      icon: getIcon(state.cards[position]
                                          .extraInfo.listOfFields[index].key));
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(height: 10),
                              ),
                              SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    BlocBuilder<CardPageBloc, int>(
                      builder: (context, cardPageState) {
                        return Container(
                          height: 80,
                          color: Colors.white.withOpacity(0.6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int cardNumber = 0;
                                        cardNumber < state.cards.length;
                                        cardNumber++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Container(
                                          width: 10.0,
                                          height: 10.0,
                                          decoration: BoxDecoration(
                                            color: cardNumber != cardPageState
                                                ? Colors.black
                                                : Color(state
                                                    .cards[cardPageState]
                                                    .settings
                                                    .cardColor),
                                            shape: BoxShape.circle,
                                            //border: Border.all(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: CustomFloatActionButton(
                                    color: state.cards[cardPageState].settings
                                        .cardColor),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                );
              }

              return Container();
            },
          ),
        ),
        //floatingActionButton: const CustomFloatActionButton(), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class GeneralTextWidget extends StatelessWidget {
  final String label;
  final String value;

  const GeneralTextWidget({Key? key, this.label = '', required this.value})
      : super(key: key);

  TextStyle getTextStyle() {
    if (label == "fullName") {
      return TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
    } else if (label == "headline") {
      return TextStyle(fontSize: 18, color: Colors.grey);
    } else {
      return TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(value, style: getTextStyle()),
    );
  }
}

class ExtraTextWidget extends StatelessWidget {
  final String label;
  final String value;
  final int color;
  final Widget icon;

  const ExtraTextWidget(
      {Key? key,
      required this.label,
      required this.value,
      required this.color,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 20, backgroundColor: Color(color), child: icon),
        Expanded(
          child: ListTile(
            title: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(label),
          ),
        )
      ],
    );
  }
}
