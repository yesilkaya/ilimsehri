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

  static String whatsappHelpUrl(String contact) =>
      "whatsapp://send?phone=$contact&text=${"Merhaba Hekimane, bir konu danışmak istiyorum."}";

  static String whatsappUrlWithoutNumber(String text) => "whatsapp://send?text=$text";

  static const String appStoreWhatsappUrl = 'https://apps.apple.com/app/id310633997';
  static const String playStoreWhatsappUrl = 'https://play.google.com/store/apps/details?id=com.whatsapp';

  static const String imagesRoute = "assets/img";
  static const String iconsRoute = "assets/img/icons";

  // socialMedia routes
  static const String instagram = "instagram.com";
  static String? instagramAccount = 'hekimane14/';
  static const String twitter = "twitter.com";
  static String? twitterAccount = 'hekimane14';
  static const String facebook = "facebook.com";
  static String? facebookAccount = 'hekimane14';
  static const String youtube = "youtube.com";
  static String? youtubeAccount = '@hekimane';
}
