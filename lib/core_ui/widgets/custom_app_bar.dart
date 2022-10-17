import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget> actions;
  final Widget? title;

  const CustomAppBar(
      {Key? key, this.leading, this.actions = const [], this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: title,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [...actions],
        leading: leading);
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
