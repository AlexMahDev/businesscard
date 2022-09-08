import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';



class CreateCardPage extends StatelessWidget {
  const CreateCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {

                      },
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

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ChooseColorWidget(color: Colors.redAccent, isSelected: true),
                    ChooseColorWidget(color: Colors.orange, isSelected: false),
                    ChooseColorWidget(color: Colors.yellow, isSelected: false),
                    ChooseColorWidget(color: Colors.brown, isSelected: false),
                    ChooseColorWidget(color: Colors.green, isSelected: false),
                    ChooseColorWidget(color: Colors.lightBlueAccent, isSelected: false),
                    ChooseColorWidget(color: Colors.blue, isSelected: false),
                    ChooseColorWidget(color: Colors.purple, isSelected: false),
                    ChooseColorWidget(color: Colors.purpleAccent, isSelected: false),
                    ChooseColorWidget(color: Colors.black, isSelected: false),
                    ChooseColorWidget(color: Colors.grey, isSelected: false),
                  ],
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {

                  },
                    child: Text('Add Profile Picture', style: TextStyle(color: Colors.redAccent, fontSize: 17, fontWeight: FontWeight.bold),)
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () {

                    },
                    child: Text('Add Company Logo', style: TextStyle(color: Colors.redAccent, fontSize: 17, fontWeight: FontWeight.bold),)
                ),
              ],
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {

                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  //contentPadding: EdgeInsets.all(0),
                                  suffixIcon: IconButton(
                                    onPressed: () {

                                    },
                                    icon: Icon(Icons.highlight_remove_outlined),
                                    splashRadius: 20,
                                  ),
                                  hintText: 'Full Name',
                                  //labelText: 'Name *',
                                ),

                                //textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.keyboard_arrow_down, size: 50, color: Colors.redAccent)

                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  //contentPadding: EdgeInsets.all(0),
                                  suffixIcon: IconButton(
                                    onPressed: () {

                                    },
                                    icon: Icon(Icons.highlight_remove_outlined),
                                    splashRadius: 20,
                                  ),
                                  hintText: 'First Name',
                                  //labelText: 'Name *',
                                ),

                                //textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  //contentPadding: EdgeInsets.all(0),
                                  suffixIcon: IconButton(
                                    onPressed: () {

                                    },
                                    icon: Icon(Icons.highlight_remove_outlined),
                                    splashRadius: 20,
                                  ),
                                  hintText: 'Middle Name',
                                  //labelText: 'Name *',
                                ),

                                //textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  //contentPadding: EdgeInsets.all(0),
                                  suffixIcon: IconButton(
                                    onPressed: () {

                                    },
                                    icon: Icon(Icons.highlight_remove_outlined),
                                    splashRadius: 20,
                                  ),
                                  hintText: 'Last Name',
                                  //labelText: 'Name *',
                                ),

                                //textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        TextFormField(
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.all(0),
                            suffixIcon: IconButton(
                              onPressed: () {

                              },
                              icon: Icon(Icons.highlight_remove_outlined),
                              splashRadius: 20,
                            ),
                            hintText: 'Job Title',
                            //labelText: 'Name *',
                          ),

                          //textAlign: TextAlign.center,
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        TextFormField(
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.all(0),
                            suffixIcon: IconButton(
                              onPressed: () {

                              },
                              icon: Icon(Icons.highlight_remove_outlined),
                              splashRadius: 20,
                            ),
                            hintText: 'Department',
                            //labelText: 'Name *',
                          ),

                          //textAlign: TextAlign.center,
                        ),


                        SizedBox(
                          height: 15,
                        ),

                        TextFormField(
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.all(0),
                            suffixIcon: IconButton(
                              onPressed: () {

                              },
                              icon: Icon(Icons.highlight_remove_outlined),
                              splashRadius: 20,
                            ),
                            hintText: 'Company Name',
                            //labelText: 'Name *',
                          ),

                          //textAlign: TextAlign.center,
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        TextFormField(
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.all(0),
                            suffixIcon: IconButton(
                              onPressed: () {

                              },
                              icon: Icon(Icons.highlight_remove_outlined),
                              splashRadius: 20,
                            ),
                            hintText: 'Headline',
                            //labelText: 'Name *',
                          ),

                          //textAlign: TextAlign.center,
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.all(50),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tap a field below to add it', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.add, size: 30)
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              color: Colors.redAccent[100],
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 80,
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
                            Expanded(child: Center(child: Text('Phone Number', textAlign: TextAlign.center, style: TextStyle(fontSize: 17))))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 80,
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
                            Expanded(child: Center(child: Text('Email', textAlign: TextAlign.center, style: TextStyle(fontSize: 17))))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 80,
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
                            Expanded(child: Center(child: Text('Link', textAlign: TextAlign.center, style: TextStyle(fontSize: 17))))
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
  }
}



class ChooseColorWidget extends StatelessWidget {

  final bool isSelected;
  final Color color;

  const ChooseColorWidget({Key? key, required this.isSelected, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration:  BoxDecoration(
          //color: Colors.redAccent,
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? Colors.grey : Colors.transparent, width: 2),
        ),
        child: Center(
          child: Container(
            width: 30.0,
            height: 30.0,
            decoration:  BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              //border: Border.all(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}





// class CreateCardPage extends StatefulWidget {
//   const CreateCardPage({Key? key}) : super(key: key);
//
//   @override
//   State<CreateCardPage> createState() => _CreateCardPageState();
// }
//
// class _CreateCardPageState extends State<CreateCardPage> {
//
//
//   late final TextEditingController titleController;
//
//   @override
//   void initState() {
//     super.initState();
//     titleController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     titleController.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: Text('Create A Card'),
//         leading: IconButton(
//           icon: const Icon(Icons.check),
//           splashRadius: 20,
//           onPressed: () {
//             print('gg');
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.more_horiz),
//             splashRadius: 20,
//             onPressed: () {
//               //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const CreateCardPage()));
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           TextFormField(
//             decoration: const InputDecoration(
//               //contentPadding: EdgeInsets.all(0),
//               icon: Icon(Icons.person),
//               hintText: 'Set a title (e.g. Work or Personal)',
//               //labelText: 'Name *',
//             ),
//
//             textAlign: TextAlign.center,
//           )
//         ],
//       ),
//     );
//   }
// }


