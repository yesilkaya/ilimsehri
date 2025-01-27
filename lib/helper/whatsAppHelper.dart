import 'package:ilimsehri/helper/platform_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppHelper {
  static Future<bool> isWhatsAppInstalled(String whatsappUrl) async {
    print('whatsappUrl : $whatsappUrl');
    try {
      if (PlatformHelper.isIos) {
        final canLaunch = await canLaunchUrl(Uri.parse(whatsappUrl));
        return canLaunch;
      } else {
        final canLaunch = await canLaunchUrl(Uri.parse(whatsappUrl));
        return canLaunch;
      }
    } on Exception {
      return false;
    }
  }
}
