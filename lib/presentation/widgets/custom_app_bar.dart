import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Cards'),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          splashRadius: 20,
          onPressed: () {
            print('gg');
          },
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          splashRadius: 20,
          onPressed: () {
            print('gg');
          },
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.menu),
        splashRadius: 20,
        onPressed: () {
          print('gg');
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
