class SalahTimeTypes {
  static const String imsak = 'İmsak';
  static const String fajr = 'Sabah';
  static const String sunrise = 'Güneş';
  static const String dhuhr = 'Öğle';
  static const String asr = 'İkindi';
  static const String maghrib = 'Akşam';
  static const String isha = 'Yatsı';
}

class SalahTimesNotification {
  static const String fajr = 'fajrNotification';
  static const String dhuhr = 'dhuhrNotification';
  static const String asr = 'asrNotification';
  static const String maghrib = 'maghribNotification';
  static const String isha = 'ishaNotification';

  static const List<String> all = [fajr, dhuhr, asr, maghrib, isha];
}

class NotificationBodies {
  static const String fajr =
      'Sabır ve namazla Allah’tan yardım isteyin. Doğrusu namaz çok ağır ve çetin bir iştir. Ancak o, Allah’a duyduğu derin saygıdan kalbi ürperenlere ağır gelmez.';
  static const String dhuhr =
      'Sonra Âdem, Rabbinden öğrendiği sözlerle Allah’a yalvardı, tevbe etti, Allah da tevbesini kabul buyurdu. Doğrusu O, tevbeleri çok kabul eden, nihâyetsiz merhamet sahibi olandır.';
  static const String asr =
      'Onlar, kendilerinin Rablerine kavuşacaklarını ve günün birinde O’na döneceklerini kesinlikle bilen kimselerdir.';
  static const String maghrib =
      'Doğu da Allah’ındır, batı da. O halde nereye dönerseniz dönün, Allah’a yönelmiş olur, O’nu karşınızda bulursunuz. Elbette Allah lutf u keremi çok geniş olan ve her şeyi hakkıyla bilendir.';
  static const String isha = 'Namazı dosdoğru kılın, zekâtı verin ve rukû edenlerle beraber siz de rukû edin.';

  static const List<String> all = [fajr, dhuhr, asr, maghrib, isha];
}

class NotificationTitles {
  static const String fajr = 'Sabah Namazı Vakti';
  static const String dhuhr = 'Öğle Namazı Vakti';
  static const String asr = 'İkindi Namazı Vakti';
  static const String maghrib = 'Akşam Namazı Vakti';
  static const String isha = 'Yatsı Namazı Vakti';

  static const List<String> all = [fajr, dhuhr, asr, maghrib, isha];
}
