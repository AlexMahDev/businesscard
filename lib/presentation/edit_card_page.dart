import 'dart:math';

import 'package:businesscard/blocs/card_info_bloc/card_info_bloc.dart';
import 'package:businesscard/blocs/full_name_dropdown_bloc/full_name_dropdown_bloc.dart';
import 'package:businesscard/blocs/select_card_color_bloc/select_card_color_bloc.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCardPage extends StatefulWidget {
  const EditCardPage({Key? key}) : super(key: key);

  @override
  State<EditCardPage> createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
  final Map<String, TextEditingController> _controllerMap = {};

  // @override
  // void initState() {
  //   super.initState();
  //   _controllerMap["name"] = TextEditingController();
  // }

  @override
  void dispose() {
    _controllerMap.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  TextEditingController _getControllerOf(String key, String value) {
    var controller = _controllerMap[key];
    if (controller == null) {
      controller = TextEditingController(text: value);
      _controllerMap[key] = controller;
    }
    //print(_controllerMap.length);
    return controller;
  }

  // Map<String, String> data =
  // {
  //   "Name": "Alexander",
  //   "Department": "Mobile",
  //   "Link": "hello.com"
  // };

  // Map<String, Map<String, String>> data =
  //
  // {
  //   "generalInfo": {
  //     "Name": "Alexander",
  //     "Department": "Mobile",
  //     "Link": "hello.com"
  //   },
  //   "extraInfo": {
  //     "Name": "Alexander",
  //     "Department": "Mobile",
  //     "Link": "hello.com"
  //   },
  //
  // };

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
                  child: TextFormField(
                    decoration: InputDecoration(
                      //contentPadding: EdgeInsets.all(0),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.highlight_remove_outlined),
                        splashRadius: 20,
                      ),
                      hintText: 'Set a title (e.g. Work or Personal)',
                      //labelText: 'Name *',
                    ),

                    //textAlign: TextAlign.center,
                  ),
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

                ///STATIC TEXT FIELDS
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 30),
                    child:
                        GeneralTextFields(controller: TextEditingController())),

                ///DYNAMIC TEXT FIELDS
                BlocBuilder<CardInfoBloc, CardInfoState>(
                  builder: (context, state) {

                    if(state is CardInfoLoadedState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 30),
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.card.extraInfo.listOfFields.length, //data["extraInfo"]!.length,
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
                                controller: _getControllerOf(state.card.extraInfo.listOfFields[index].key, state.card.extraInfo.listOfFields[index].value),
                                hintText: state.card.extraInfo.listOfFields[index].key,
                              withIcon: true,
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
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 15),
                        ),
                      );
                    }

                    return Container();

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

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                  color: Colors.redAccent.withOpacity(0.2),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 90,
                            height: 100,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.redAccent,
                                  child: Icon(Icons.phone, color: Colors.white),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Expanded(
                                    child: Center(
                                        child: Text('Phone Number',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 17))))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            height: 100,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.redAccent,
                                  child: Icon(Icons.email, color: Colors.white),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Expanded(
                                    child: Center(
                                        child: Text('Email',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 17))))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            height: 100,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.redAccent,
                                  child: Icon(Icons.link, color: Colors.white),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Expanded(
                                    child: Center(
                                        child: Text('Link',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 17))))
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 90,
                            height: 100,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.redAccent,
                                  child: Icon(Icons.phone, color: Colors.white),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Expanded(
                                    child: Center(
                                        child: Text('LinkedIn',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 17))))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            height: 100,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.redAccent,
                                  child: Icon(Icons.email, color: Colors.white),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Expanded(
                                    child: Center(
                                        child: Text('GitHub',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 17))))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            height: 100,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.redAccent,
                                  child: Icon(Icons.link, color: Colors.white),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Expanded(
                                    child: Center(
                                        child: Text('Telegram',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 17))))
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
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

class GeneralTextFields extends StatelessWidget {
  final TextEditingController controller;

  const GeneralTextFields({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            final fullNameDropdownBloc =
                BlocProvider.of<FullNameDropdownBloc>(context);

            final fullNameDropdownState = fullNameDropdownBloc.state;

            if (fullNameDropdownState is FullNameDropdownCloseState) {
              fullNameDropdownBloc.add(FullNameDropdownOpenEvent());
            } else {
              fullNameDropdownBloc.add(FullNameDropdownCloseEvent());
            }
          },
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                    hintText: 'Full Name',
                    enabled: false,
                    controller: controller),
              ),
              SizedBox(
                width: 20,
              ),
              BlocBuilder<FullNameDropdownBloc, FullNameDropdownState>(
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
                        hintText: 'First Name', controller: controller),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                        hintText: 'Middle Name', controller: controller),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                        hintText: 'Last Name', controller: controller),
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
        CustomTextField(hintText: 'Job Title', controller: controller),
        SizedBox(
          height: 15,
        ),
        CustomTextField(hintText: 'Department', controller: controller),
        SizedBox(
          height: 15,
        ),
        CustomTextField(hintText: 'Company Name', controller: controller),
        SizedBox(
          height: 15,
        ),
        CustomTextField(hintText: 'Headline', controller: controller)
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final bool enabled;
  final bool withIcon;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.enabled = true, this.withIcon = false})
      : super(key: key);

  Widget getIcon() {
    if(hintText == "Email") {
      return Icon(Icons.email, color: Colors.white);
    } else {
      return Icon(Icons.accessibility, color: Colors.white);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (withIcon)
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: getIcon()
            ),
          ),
        Expanded(
          child: TextFormField(
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
              //contentPadding: EdgeInsets.all(0),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.highlight_remove_outlined),
                splashRadius: 20,
              ),
              hintText: hintText,
              //labelText: 'Name *',
            ),

            //textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// class CreateCardPage extends StatelessWidget {
//   const CreateCardPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<SelectCardColorBloc>(
//           create: (BuildContext context) => SelectCardColorBloc(),
//         ),
//         BlocProvider<FullNameDropdownBloc>(
//           create: (BuildContext context) => FullNameDropdownBloc(),
//         ),
//       ],
//       child: Builder(builder: (context) {
//         return Scaffold(
//           appBar: CustomAppBar(
//             title: Text('Create A Card'),
//             leading: IconButton(
//               icon: const Icon(Icons.check),
//               splashRadius: 20,
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.more_horiz),
//                 splashRadius: 20,
//                 onPressed: () {
//                   //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const CreateCardPage()));
//                 },
//               ),
//             ],
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               //crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       //contentPadding: EdgeInsets.all(0),
//                       suffixIcon: IconButton(
//                         onPressed: () {},
//                         icon: Icon(Icons.highlight_remove_outlined),
//                         splashRadius: 20,
//                       ),
//                       hintText: 'Set a title (e.g. Work or Personal)',
//                       //labelText: 'Name *',
//                     ),
//
//                     //textAlign: TextAlign.center,
//                   ),
//                 ),
//
//                 // SizedBox(
//                 //   height: 20,
//                 // ),
//
//                 BlocBuilder<SelectCardColorBloc, Color>(
//                   builder: (context, state) {
//                     return SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10.0, vertical: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             ChooseColorWidget(color: Colors.redAccent),
//                             ChooseColorWidget(color: Colors.orange),
//                             ChooseColorWidget(color: Colors.yellow),
//                             ChooseColorWidget(color: Colors.brown),
//                             ChooseColorWidget(color: Colors.green),
//                             ChooseColorWidget(color: Colors.lightBlueAccent),
//                             ChooseColorWidget(color: Colors.blue),
//                             ChooseColorWidget(color: Colors.purple),
//                             ChooseColorWidget(color: Colors.purpleAccent),
//                             ChooseColorWidget(color: Colors.black),
//                             ChooseColorWidget(color: Colors.grey),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                         onTap: () {},
//                         child: Text(
//                           'Add Profile Picture',
//                           style: TextStyle(
//                               color: Colors.redAccent,
//                               fontSize: 17,
//                               fontWeight: FontWeight.bold),
//                         )),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     GestureDetector(
//                         onTap: () {},
//                         child: Text(
//                           'Add Company Logo',
//                           style: TextStyle(
//                               color: Colors.redAccent,
//                               fontSize: 17,
//                               fontWeight: FontWeight.bold),
//                         )),
//                   ],
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 15.0, vertical: 30),
//                   child: Column(
//                     //crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Column(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               final fullNameDropdownBloc =
//                                   BlocProvider.of<FullNameDropdownBloc>(
//                                       context);
//
//                               final fullNameDropdownState =
//                                   fullNameDropdownBloc.state;
//
//                               if (fullNameDropdownState
//                                   is FullNameDropdownCloseState) {
//                                 fullNameDropdownBloc
//                                     .add(FullNameDropdownOpenEvent());
//                               } else {
//                                 fullNameDropdownBloc
//                                     .add(FullNameDropdownCloseEvent());
//                               }
//                             },
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: TextFormField(
//                                     enabled: false,
//                                     decoration: InputDecoration(
//                                       //contentPadding: EdgeInsets.all(0),
//                                       suffixIcon: IconButton(
//                                         onPressed: () {},
//                                         icon: Icon(
//                                             Icons.highlight_remove_outlined),
//                                         splashRadius: 20,
//                                       ),
//                                       hintText: 'Full Name',
//                                       //labelText: 'Name *',
//                                     ),
//
//                                     //textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 20,
//                                 ),
//                                 BlocBuilder<FullNameDropdownBloc,
//                                     FullNameDropdownState>(
//                                   builder: (context, state) {
//                                     if(state is FullNameDropdownOpenState) {
//                                       return Icon(Icons.keyboard_arrow_up,
//                                           size: 50, color: Colors.redAccent);
//                                     }
//                                     if(state is FullNameDropdownCloseState) {
//                                       return Icon(Icons.keyboard_arrow_down,
//                                           size: 50, color: Colors.redAccent);
//                                     }
//
//                                     return Container();
//                                   },
//                                 )
//                               ],
//                             ),
//                           ),
//                           BlocBuilder<FullNameDropdownBloc,
//                               FullNameDropdownState>(
//                             builder: (context, state) {
//                               if (state is FullNameDropdownOpenState) {
//                                 return Padding(
//                                   padding:
//                                       const EdgeInsets.only(left: 20, top: 15),
//                                   child: Column(
//                                     children: [
//                                       TextFormField(
//                                         decoration: InputDecoration(
//                                           //contentPadding: EdgeInsets.all(0),
//                                           suffixIcon: IconButton(
//                                             onPressed: () {},
//                                             icon: Icon(Icons
//                                                 .highlight_remove_outlined),
//                                             splashRadius: 20,
//                                           ),
//                                           hintText: 'First Name',
//                                           //labelText: 'Name *',
//                                         ),
//
//                                         //textAlign: TextAlign.center,
//                                       ),
//                                       SizedBox(
//                                         height: 15,
//                                       ),
//                                       TextFormField(
//                                         decoration: InputDecoration(
//                                           //contentPadding: EdgeInsets.all(0),
//                                           suffixIcon: IconButton(
//                                             onPressed: () {},
//                                             icon: Icon(Icons
//                                                 .highlight_remove_outlined),
//                                             splashRadius: 20,
//                                           ),
//                                           hintText: 'Middle Name',
//                                           //labelText: 'Name *',
//                                         ),
//
//                                         //textAlign: TextAlign.center,
//                                       ),
//                                       SizedBox(
//                                         height: 15,
//                                       ),
//                                       TextFormField(
//                                         decoration: InputDecoration(
//                                           //contentPadding: EdgeInsets.all(0),
//                                           suffixIcon: IconButton(
//                                             onPressed: () {},
//                                             icon: Icon(Icons
//                                                 .highlight_remove_outlined),
//                                             splashRadius: 20,
//                                           ),
//                                           hintText: 'Last Name',
//                                           //labelText: 'Name *',
//                                         ),
//
//                                         //textAlign: TextAlign.center,
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }
//
//                               return Container();
//                             },
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               //contentPadding: EdgeInsets.all(0),
//                               suffixIcon: IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(Icons.highlight_remove_outlined),
//                                 splashRadius: 20,
//                               ),
//                               hintText: 'Job Title',
//                               //labelText: 'Name *',
//                             ),
//
//                             //textAlign: TextAlign.center,
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               //contentPadding: EdgeInsets.all(0),
//                               suffixIcon: IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(Icons.highlight_remove_outlined),
//                                 splashRadius: 20,
//                               ),
//                               hintText: 'Department',
//                               //labelText: 'Name *',
//                             ),
//
//                             //textAlign: TextAlign.center,
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               //contentPadding: EdgeInsets.all(0),
//                               suffixIcon: IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(Icons.highlight_remove_outlined),
//                                 splashRadius: 20,
//                               ),
//                               hintText: 'Company Name',
//                               //labelText: 'Name *',
//                             ),
//
//                             //textAlign: TextAlign.center,
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               //contentPadding: EdgeInsets.all(0),
//                               suffixIcon: IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(Icons.highlight_remove_outlined),
//                                 splashRadius: 20,
//                               ),
//                               hintText: 'Headline',
//                               //labelText: 'Name *',
//                             ),
//
//                             //textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 Container(
//                   margin: EdgeInsets.all(50),
//                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: FittedBox(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Tap a field below to add it',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20)),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Icon(Icons.add, size: 30)
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
//                   color: Colors.redAccent.withOpacity(0.2),
//                   child: Column(
//                     //crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 90,
//                             height: 100,
//                             child: Column(
//                               //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 20,
//                                   backgroundColor: Colors.redAccent,
//                                   child: Icon(Icons.phone, color: Colors.white),
//                                 ),
//                                 // SizedBox(
//                                 //   height: 10,
//                                 // ),
//                                 Expanded(
//                                     child: Center(
//                                         child: Text('Phone Number',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(fontSize: 17))))
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 90,
//                             height: 100,
//                             child: Column(
//                               //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 20,
//                                   backgroundColor: Colors.redAccent,
//                                   child: Icon(Icons.email, color: Colors.white),
//                                 ),
//                                 // SizedBox(
//                                 //   height: 10,
//                                 // ),
//                                 Expanded(
//                                     child: Center(
//                                         child: Text('Email',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(fontSize: 17))))
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 90,
//                             height: 100,
//                             child: Column(
//                               //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 20,
//                                   backgroundColor: Colors.redAccent,
//                                   child: Icon(Icons.link, color: Colors.white),
//                                 ),
//                                 // SizedBox(
//                                 //   height: 10,
//                                 // ),
//                                 Expanded(
//                                     child: Center(
//                                         child: Text('Link',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(fontSize: 17))))
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 25,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 90,
//                             height: 100,
//                             child: Column(
//                               //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 20,
//                                   backgroundColor: Colors.redAccent,
//                                   child: Icon(Icons.phone, color: Colors.white),
//                                 ),
//                                 // SizedBox(
//                                 //   height: 10,
//                                 // ),
//                                 Expanded(
//                                     child: Center(
//                                         child: Text('LinkedIn',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(fontSize: 17))))
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 90,
//                             height: 100,
//                             child: Column(
//                               //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 20,
//                                   backgroundColor: Colors.redAccent,
//                                   child: Icon(Icons.email, color: Colors.white),
//                                 ),
//                                 // SizedBox(
//                                 //   height: 10,
//                                 // ),
//                                 Expanded(
//                                     child: Center(
//                                         child: Text('GitHub',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(fontSize: 17))))
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 90,
//                             height: 100,
//                             child: Column(
//                               //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 20,
//                                   backgroundColor: Colors.redAccent,
//                                   child: Icon(Icons.link, color: Colors.white),
//                                 ),
//                                 // SizedBox(
//                                 //   height: 10,
//                                 // ),
//                                 Expanded(
//                                     child: Center(
//                                         child: Text('Telegram',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(fontSize: 17))))
//                               ],
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       }),
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
