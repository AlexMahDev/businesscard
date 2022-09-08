import 'package:businesscard/presentation/cards_page.dart';
import 'package:businesscard/presentation/widgets/bottom_navigation_bar.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.redAccent),
          foregroundColor: Colors.black, //<-- SEE HERE
          //titleTextStyle: TextStyle()
        ),
      ),
      title: 'Flutter Demo',
      home: const CustomBottomNavigationBar()
    );
  }
}



