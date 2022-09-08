import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';


class CardsPage extends StatelessWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 300,
                child: Image.asset('lib/assets/images/qr_code.png')
            ),

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
                        child: Image.asset('lib/assets/images/innowise-logo.png')
                    ),
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
                          'lib/assets/images/avatar.jpg',
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Alexander Makhrachyov', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Innowise', style: TextStyle(fontSize: 20, color: Colors.grey)),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Head Of Mobile Department', style: TextStyle(fontSize: 15, color: Colors.grey)),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.email, color: Colors.white),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text('testemail@gmail.com'),
                          subtitle: Text('email'),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.phone, color: Colors.white),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text('+375441234567'),
                          subtitle: Text('mobile'),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.web, color: Colors.white),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text('https://innowise-group.com'),
                          subtitle: Text('company website'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )




          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
