import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade400,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/business-card.png', color: Colors.white,),
                  Text("Welcome to BCard.", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Let's get your new BCard set up", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ],
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Text("Create your card", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            fontSize: 16
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () {

                      },
                      child: Text("Log in with existing account", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15), textAlign: TextAlign.center)
                  ),
                ],
              ),
            ),

            //Text("Developed by Aliaksandr Makhrachou", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.center)


          ],
        ),
      ),
    );
  }
}
