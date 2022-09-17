import 'package:flutter/material.dart';


class CardIsEmptyWidget extends StatelessWidget {
  const CardIsEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Looks like you don't have a card set up yet! Create a card to get started!",
              style: TextStyle(
                  fontSize: 25),
              textAlign: TextAlign.center),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {

            },
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Create a card",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}