import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onTap;

  const CustomErrorWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/error.png'),
          const Center(
              child: Text('Tap to refresh...',
                  style: TextStyle(fontSize: 25, color: Colors.grey)))
        ],
      ),
    );
  }
}
