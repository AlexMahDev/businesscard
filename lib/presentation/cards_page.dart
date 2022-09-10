import 'package:businesscard/blocs/card_info_bloc/card_info_bloc.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/custom_float_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Cards'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          splashRadius: 20,
          onPressed: () {
            print('gg');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            splashRadius: 20,
            onPressed: () {

              final cardInfoBloc = BlocProvider.of<CardInfoBloc>(context);
              final state = cardInfoBloc.state;

              if (state is CardInfoLoadedState) {
                List<CardModel> cards = state.cards;
                cards.add(CardModel(settings: SettingsModel(cardTitle: '', cardColor: ''), generalInfo: GeneralInfoModel(firstName: '', middleName: '', lastName: '', jobTitle: '', department: '', companyName: '', headLine: ''), extraInfo: ExtraInfoModel(listOfFields: [])));
                cardInfoBloc.add(AddCardEvent(cards));
              }

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const CreateCardPage()));


              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => BlocProvider<CardInfoBloc>.value(
              //           value: BlocProvider.of<CardInfoBloc>(context),
              //           child: const CreateCardPage(),
              //         )));
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            splashRadius: 20,
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => const EditCardPage()));
            },
          ),
        ],
      ),
      body: BlocBuilder<CardInfoBloc, CardInfoState>(
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
                    itemBuilder: (context, position) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                                height: 250,
                                child: Image.asset('assets/images/qr_code.png')),

                            // SizedBox(
                            //     height: 120,
                            //     child: Image.asset('lib/assets/images/innowise-logo.png')
                            // ),

                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.bottomRight,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                        height: 120,
                                        child: Image.asset(
                                            'assets/images/innowise-logo.png')),
                                    Divider(
                                      thickness: 5,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 90,
                                  right: 15,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/images/avatar.jpg',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
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
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  if(state.cards[position].generalInfo.firstName.isNotEmpty || state.cards[position].generalInfo.middleName.isNotEmpty || state.cards[position].generalInfo.lastName.isNotEmpty)
                                    GeneralTextWidget(
                                        label: 'fullName',
                                        value: '${state.cards[position].generalInfo.firstName} ${state.cards[position].generalInfo.middleName} ${state.cards[position].generalInfo.lastName}'.trim()
                                    ),

                                  if(state.cards[position].generalInfo.jobTitle.isNotEmpty)
                                    GeneralTextWidget(
                                        value: state.cards[position].generalInfo.jobTitle
                                    ),

                                  if(state.cards[position].generalInfo.department.isNotEmpty)
                                    GeneralTextWidget(
                                        value: state.cards[position].generalInfo.department
                                    ),

                                  if(state.cards[position].generalInfo.companyName.isNotEmpty)
                                    GeneralTextWidget(
                                        value: state.cards[position].generalInfo.companyName
                                    ),

                                  if(state.cards[position].generalInfo.headLine.isNotEmpty)
                                    GeneralTextWidget(
                                        label: 'headline',
                                        value: state.cards[position].generalInfo.headLine
                                    ),
                                ],
                              ),
                            ),





                            // ListView.separated(
                            //   physics: NeverScrollableScrollPhysics(),
                            //   shrinkWrap: true,
                            //   padding: EdgeInsets.symmetric(horizontal: 15),
                            //   itemCount: state.card.generalInfo.listOfFields.length,
                            //   //padding: EdgeInsets.only(top: 15),
                            //   itemBuilder: (BuildContext context, int index) {
                            //
                            //     //final controller = _getControllerOf(data[index]);
                            //
                            //     // final textField = TextField(
                            //     //   controller: controller,
                            //     //   decoration: InputDecoration(
                            //     //     border: OutlineInputBorder(),
                            //     //     labelText: "name${index + 1}",
                            //     //   ),
                            //     // );
                            //     return GeneralTextWidget (
                            //       title: state.card.generalInfo.listOfFields[index].key,
                            //       value: state.card.generalInfo.listOfFields[index].value
                            //     );
                            //
                            //
                            //     //   CustomTextField(
                            //     //     controller: _getControllerOf(data["extraInfo"]!.keys.elementAt(index)),
                            //     //     hintText: data["extraInfo"]!.keys.elementAt(index)
                            //     // );
                            //     //   Container(
                            //     //   child: TextField(
                            //     //     controller: _getControllerOf(data.keys.elementAt(index)),
                            //     //     decoration: InputDecoration(
                            //     //       border: OutlineInputBorder(),
                            //     //       labelText: data[index],
                            //     //     ),
                            //     //   ),
                            //     //   padding: EdgeInsets.only(bottom: 10),
                            //     // );
                            //   }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
                            // ),


                            SizedBox(
                              height: 10,
                            ),

                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              itemCount: state.cards[position].extraInfo.listOfFields.length,
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
                                return ExtraTextWidget (
                                    label: state.cards[position].extraInfo.listOfFields[index].key,
                                    value: state.cards[position].extraInfo.listOfFields[index].value
                                );


                                //   CustomTextField(
                                //     controller: _getControllerOf(data["extraInfo"]!.keys.elementAt(index)),
                                //     hintText: data["extraInfo"]!.keys.elementAt(index)
                                // );
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
                              }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
                            ),


                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 15),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Row(
                            //         children: [
                            //           CircleAvatar(
                            //             radius: 20,
                            //             backgroundColor: Colors.black,
                            //             child:
                            //                 Icon(Icons.email, color: Colors.white),
                            //           ),
                            //           Expanded(
                            //             child: ListTile(
                            //               title: Text('testemail@gmail.com'),
                            //               subtitle: Text('email'),
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //       Row(
                            //         children: [
                            //           CircleAvatar(
                            //             radius: 20,
                            //             backgroundColor: Colors.black,
                            //             child:
                            //                 Icon(Icons.phone, color: Colors.white),
                            //           ),
                            //           Expanded(
                            //             child: ListTile(
                            //               title: Text('+375441234567'),
                            //               subtitle: Text('mobile'),
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //       Row(
                            //         children: [
                            //           CircleAvatar(
                            //             radius: 20,
                            //             backgroundColor: Colors.black,
                            //             child: Icon(Icons.web, color: Colors.white),
                            //           ),
                            //           Expanded(
                            //             child: ListTile(
                            //               title: Text('https://innowise-group.com'),
                            //               subtitle: Text('company website'),
                            //             ),
                            //           )
                            //         ],
                            //       )
                            //     ],
                            //   ),
                            // ),

                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      );
                    },
                ),
                Container(
                  height: 80,
                  color: Colors.white.withOpacity(0.6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 10.0,
                              height: 10.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 10.0,
                              height: 10.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomFloatActionButton(),
                      )
                    ],
                  ),
                )
              ],
            );
          }

          return Container();
        },
      ),
      //floatingActionButton: const CustomFloatActionButton(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



// class CardsPage extends StatelessWidget {
//   const CardsPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     //final cardInfoBloc = CardInfoBloc()..add(GetCardInfoEvent());
//
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: Text('Cards'),
//         leading: IconButton(
//           icon: const Icon(Icons.menu),
//           splashRadius: 20,
//           onPressed: () {
//             print('gg');
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             splashRadius: 20,
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => const CreateCardPage()));
//
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) => BlocProvider<CardInfoBloc>.value(
//               //           value: BlocProvider.of<CardInfoBloc>(context),
//               //           child: const CreateCardPage(),
//               //         )));
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.edit),
//             splashRadius: 20,
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => const EditCardPage()));
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<CardInfoBloc, CardInfoState>(
//         builder: (context, state) {
//           if (state is CardInfoLoadingState) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (state is CardInfoLoadedState) {
//             return Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       SizedBox(
//                           height: 250,
//                           child: Image.asset('assets/images/qr_code.png')),
//
//                       // SizedBox(
//                       //     height: 120,
//                       //     child: Image.asset('lib/assets/images/innowise-logo.png')
//                       // ),
//
//                       Stack(
//                         clipBehavior: Clip.none,
//                         alignment: Alignment.bottomRight,
//                         children: [
//                           Column(
//                             children: [
//                               SizedBox(
//                                   height: 120,
//                                   child: Image.asset(
//                                       'assets/images/innowise-logo.png')),
//                               Divider(
//                                 thickness: 5,
//                               ),
//                             ],
//                           ),
//                           Positioned(
//                             top: 90,
//                             right: 15,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 ClipOval(
//                                   child: Image.asset(
//                                     'assets/images/avatar.jpg',
//                                     width: 80,
//                                     height: 80,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//
//                       SizedBox(
//                         height: 40,
//                       ),
//
//
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//
//                             if(state.card.generalInfo.firstName.isNotEmpty || state.card.generalInfo.middleName.isNotEmpty || state.card.generalInfo.lastName.isNotEmpty)
//                               GeneralTextWidget(
//                                   label: 'fullName',
//                                   value: '${state.card.generalInfo.firstName} ${state.card.generalInfo.middleName} ${state.card.generalInfo.lastName}'.trim()
//                               ),
//
//                             if(state.card.generalInfo.jobTitle.isNotEmpty)
//                               GeneralTextWidget(
//                                   value: state.card.generalInfo.jobTitle
//                               ),
//
//                             if(state.card.generalInfo.department.isNotEmpty)
//                               GeneralTextWidget(
//                                   value: state.card.generalInfo.department
//                               ),
//
//                             if(state.card.generalInfo.companyName.isNotEmpty)
//                               GeneralTextWidget(
//                                   value: state.card.generalInfo.companyName
//                               ),
//
//                             if(state.card.generalInfo.headLine.isNotEmpty)
//                               GeneralTextWidget(
//                                   label: 'headline',
//                                   value: state.card.generalInfo.headLine
//                               ),
//                           ],
//                         ),
//                       ),
//
//
//
//
//
//                       // ListView.separated(
//                       //   physics: NeverScrollableScrollPhysics(),
//                       //   shrinkWrap: true,
//                       //   padding: EdgeInsets.symmetric(horizontal: 15),
//                       //   itemCount: state.card.generalInfo.listOfFields.length,
//                       //   //padding: EdgeInsets.only(top: 15),
//                       //   itemBuilder: (BuildContext context, int index) {
//                       //
//                       //     //final controller = _getControllerOf(data[index]);
//                       //
//                       //     // final textField = TextField(
//                       //     //   controller: controller,
//                       //     //   decoration: InputDecoration(
//                       //     //     border: OutlineInputBorder(),
//                       //     //     labelText: "name${index + 1}",
//                       //     //   ),
//                       //     // );
//                       //     return GeneralTextWidget (
//                       //       title: state.card.generalInfo.listOfFields[index].key,
//                       //       value: state.card.generalInfo.listOfFields[index].value
//                       //     );
//                       //
//                       //
//                       //     //   CustomTextField(
//                       //     //     controller: _getControllerOf(data["extraInfo"]!.keys.elementAt(index)),
//                       //     //     hintText: data["extraInfo"]!.keys.elementAt(index)
//                       //     // );
//                       //     //   Container(
//                       //     //   child: TextField(
//                       //     //     controller: _getControllerOf(data.keys.elementAt(index)),
//                       //     //     decoration: InputDecoration(
//                       //     //       border: OutlineInputBorder(),
//                       //     //       labelText: data[index],
//                       //     //     ),
//                       //     //   ),
//                       //     //   padding: EdgeInsets.only(bottom: 10),
//                       //     // );
//                       //   }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
//                       // ),
//
//
//                       SizedBox(
//                         height: 10,
//                       ),
//
//                       ListView.separated(
//                         physics: NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         padding: EdgeInsets.symmetric(horizontal: 15),
//                         itemCount: state.card.extraInfo.listOfFields.length,
//                         //padding: EdgeInsets.only(top: 15),
//                         itemBuilder: (BuildContext context, int index) {
//
//                           //final controller = _getControllerOf(data[index]);
//
//                           // final textField = TextField(
//                           //   controller: controller,
//                           //   decoration: InputDecoration(
//                           //     border: OutlineInputBorder(),
//                           //     labelText: "name${index + 1}",
//                           //   ),
//                           // );
//                           return ExtraTextWidget (
//                               label: state.card.extraInfo.listOfFields[index].key,
//                               value: state.card.extraInfo.listOfFields[index].value
//                           );
//
//
//                           //   CustomTextField(
//                           //     controller: _getControllerOf(data["extraInfo"]!.keys.elementAt(index)),
//                           //     hintText: data["extraInfo"]!.keys.elementAt(index)
//                           // );
//                           //   Container(
//                           //   child: TextField(
//                           //     controller: _getControllerOf(data.keys.elementAt(index)),
//                           //     decoration: InputDecoration(
//                           //       border: OutlineInputBorder(),
//                           //       labelText: data[index],
//                           //     ),
//                           //   ),
//                           //   padding: EdgeInsets.only(bottom: 10),
//                           // );
//                         }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
//                       ),
//
//
//                       // Padding(
//                       //   padding: const EdgeInsets.symmetric(horizontal: 15),
//                       //   child: Column(
//                       //     crossAxisAlignment: CrossAxisAlignment.start,
//                       //     children: [
//                       //       Row(
//                       //         children: [
//                       //           CircleAvatar(
//                       //             radius: 20,
//                       //             backgroundColor: Colors.black,
//                       //             child:
//                       //                 Icon(Icons.email, color: Colors.white),
//                       //           ),
//                       //           Expanded(
//                       //             child: ListTile(
//                       //               title: Text('testemail@gmail.com'),
//                       //               subtitle: Text('email'),
//                       //             ),
//                       //           )
//                       //         ],
//                       //       ),
//                       //       Row(
//                       //         children: [
//                       //           CircleAvatar(
//                       //             radius: 20,
//                       //             backgroundColor: Colors.black,
//                       //             child:
//                       //                 Icon(Icons.phone, color: Colors.white),
//                       //           ),
//                       //           Expanded(
//                       //             child: ListTile(
//                       //               title: Text('+375441234567'),
//                       //               subtitle: Text('mobile'),
//                       //             ),
//                       //           )
//                       //         ],
//                       //       ),
//                       //       Row(
//                       //         children: [
//                       //           CircleAvatar(
//                       //             radius: 20,
//                       //             backgroundColor: Colors.black,
//                       //             child: Icon(Icons.web, color: Colors.white),
//                       //           ),
//                       //           Expanded(
//                       //             child: ListTile(
//                       //               title: Text('https://innowise-group.com'),
//                       //               subtitle: Text('company website'),
//                       //             ),
//                       //           )
//                       //         ],
//                       //       )
//                       //     ],
//                       //   ),
//                       // ),
//
//                       SizedBox(
//                         height: 100,
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 80,
//                   color: Colors.white.withOpacity(0.6),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 10.0,
//                               height: 10.0,
//                               decoration: BoxDecoration(
//                                 color: Colors.black,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(color: Colors.black),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Container(
//                               width: 10.0,
//                               height: 10.0,
//                               decoration: BoxDecoration(
//                                 color: Colors.transparent,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 15.0),
//                         child: CustomFloatActionButton(),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             );
//           }
//
//           return Container();
//         },
//       ),
//       //floatingActionButton: const CustomFloatActionButton(), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }


class GeneralTextWidget extends StatelessWidget {

  final String label;
  final String value;

  const GeneralTextWidget({Key? key, this.label = '', required this.value}) : super(key: key);

  TextStyle getTextStyle() {
    if(label == "fullName") {
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

  const ExtraTextWidget({Key? key, required this.label, required this.value}) : super(key: key);

  Widget getIcon() {
    if(label == "email") {
      return Icon(Icons.email, color: Colors.white);
    } else {
      return Icon(Icons.accessibility, color: Colors.white);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.black,
          child: getIcon()
        ),
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