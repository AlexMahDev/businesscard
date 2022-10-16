import 'package:businesscard/data/repositories/contact_repository.dart';
import 'package:businesscard/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:businesscard/presentation/blocs/card_info_bloc/card_info_bloc.dart';
import 'package:businesscard/presentation/blocs/card_page_bloc/card_page_bloc.dart';
import 'package:businesscard/presentation/blocs/contact_bloc/contact_bloc.dart';
import 'package:businesscard/presentation/pages/main_page.dart';
import 'package:businesscard/presentation/pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/card_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final CardPageBloc cardPageBloc = CardPageBloc();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => CardRepository(),
        ),
        RepositoryProvider(
          create: (context) => ContactRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(
                  authRepository: RepositoryProvider.of<AuthRepository>(
                      context),
                ),
          ),
          BlocProvider<CardPageBloc>(
            create: (context) => cardPageBloc,
          ),
          BlocProvider<CardInfoBloc>(
            create: (context) => CardInfoBloc(cardRepository: RepositoryProvider.of<CardRepository>(context), cardPageBloc: cardPageBloc),
          ),
          BlocProvider<ContactBloc>(
            create: (context) => ContactBloc(contactRepository: RepositoryProvider.of<ContactRepository>(context))..add(GetContactEvent()),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red,
            scaffoldBackgroundColor: Colors.white,

            //primaryColor: Colors.redAccent,
            fontFamily: 'OpenSans',
            appBarTheme: AppBarTheme(
              centerTitle: true,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Colors.redAccent, size: 30),
              foregroundColor: Colors.black, //<-- SEE HERE
              //titleTextStyle: TextStyle()
            ),
          ),
          title: 'BCard',
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.hasData) {
                  //BlocProvider.of<CardInfoBloc>(context).add(GetCardInfoEvent());
                  return MainPageNavigationBar();

                  //   BlocProvider<CardInfoBloc>.value(
                  //   value: BlocProvider.of<CardInfoBloc>(context)
                  //     ..add(GetCardInfoEvent()),
                  //   child: CustomBottomNavigationBar(),
                  // );
                }
                // Otherwise, they're not signed in. Show the sign in page.
                return WelcomePage();
              }),
          //home: const CustomBottomNavigationBar()
        ),
      ),
    );
  }
}
