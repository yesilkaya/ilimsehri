import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static void openUrl(String? url) async {
    if (url != null) {
      final Uri parsedUrl = Uri.parse(url);
      await launchUrl(parsedUrl, mode: LaunchMode.externalApplication);
    }
  }

  static Future openWebsite({required String host, String? path, bool? isExternal}) async {
    final Uri uri = Uri(
      scheme: "https",
      host: host,
      path: path,
    );
    print('uri: $uri');
    await launchUrl(uri, mode: (isExternal == true) ? LaunchMode.externalApplication : LaunchMode.platformDefault);
  }
}
