import 'package:businesscard/core_ui/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onTap;

  const CustomErrorWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/error.png'),
          Center(
              child: Text(localText!.tapToRefresh,
                  style: TextThemeCustom.tapToRefreshTextTheme))
        ],
      ),
    );
  }
}
