import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static void openUrl(String? url) async {
    if (url != null) {
      final Uri parsedUrl = Uri.parse(url);
      await launchUrl(parsedUrl, mode: LaunchMode.externalApplication);
    }
  }
}
