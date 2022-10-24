import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CardItemOnTapUI {
  Future<void> onTap(String label, String value) async {
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
}
