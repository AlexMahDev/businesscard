import 'package:businesscard/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core_ui/widgets/main_page_navigation_bar.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/card_info_bloc/card_info_bloc.dart';
import '../blocs/card_page_bloc/card_page_bloc.dart';
import '../blocs/contact_bloc/contact_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const WelcomePage()),
            (route) => false,
          );
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CardPageBloc>(
            create: (context) => CardPageBloc(),
          ),
          BlocProvider<CardInfoBloc>(
            create: (context) => CardInfoBloc(
                cardPageBloc: BlocProvider.of<CardPageBloc>(context))
              ..add(GetCardInfoEvent()),
          ),
          BlocProvider<ContactBloc>(
            create: (context) => ContactBloc()..add(GetContactEvent()),
          ),
        ],
        child: const MainPageNavigationBar(),
      ),
    );
  }
}
