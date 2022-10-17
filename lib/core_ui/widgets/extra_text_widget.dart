import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ExtraTextWidget extends StatelessWidget {
  final String label;
  final String value;
  final int color;
  final Widget icon;

  const ExtraTextWidget(
      {Key? key,
      required this.label,
      required this.value,
      required this.color,
      required this.icon})
      : super(key: key);

  Future<void> onTap() async {
    if (label == 'Phone Number') {
      final Uri launchUri = Uri(scheme: 'tel', path: value);

      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    } else if (label == 'Email') {
      final Uri emailUri = Uri(scheme: 'mailto', path: value);

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      }
    } else if (label == 'Telegram') {
      String url = value;

      if (!value.contains('http')) {
        url = 'https://t.me/${value.replaceFirst('@', '')}';
        if (await canLaunchUrlString(url)) {
          await launchUrlString(url, mode: LaunchMode.externalApplication);
        }
      } else {
        if (await canLaunchUrlString(url)) {
          await launchUrlString(url, mode: LaunchMode.externalApplication);
        }
      }
    } else {
      if (await canLaunchUrlString(value)) {
        await launchUrlString(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await onTap();
      },
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundColor: Color(color), child: icon),
          Expanded(
            child: ListTile(
              title: Text(value,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(label),
            ),
          )
        ],
      ),
    );
  }
}
