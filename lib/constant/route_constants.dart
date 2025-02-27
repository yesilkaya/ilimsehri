const String SplashScreenRoute = "splash_screen";
const String homeScreenRoute = "home_screen";
const String kuranScreenRoute = "kuran_screen";
const String sahifeiSeccadiyeScreenRoute = "sahifeiSeccadiye_screen";
const String duaScreenRoute = "dua_screen";
const String munacatScreenRoute = "munacat_screen";
const String zikirScreenRoute = "zikir_screen";
const String cocukScreenRoute = "cocuk_screen";
const String gaybScreenRoute = "gayb_screen";
const String ramazanScreenRoute = "ramazan_screen";
const String eyyamullahScreenRoute = "eyyamullah_screen";
const String settingsScreenRoute = "settings_screen_route";
const String bookDetailScreenRoute = "book_detail_screen_route";

class Routes {
  static String whatsappUrl(String contact) =>
      "whatsapp://send?phone=$contact&text=${"Merhaba Hekimane, Kitap siparişi için yardımcı olabilir misiniz?"}";

  static String whatsappUrlWithoutNumber(String text) => "whatsapp://send?text=$text";

  static const String appStoreWhatsappUrl = 'https://apps.apple.com/app/id310633997';
  static const String playStoreWhatsappUrl = 'https://play.google.com/store/apps/details?id=com.whatsapp';
}
