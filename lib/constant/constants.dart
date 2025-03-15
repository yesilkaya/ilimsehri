import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

const childBook1ImgUrl = "https://hekimane.com/wp-content/uploads/2022/03/1HZ.MUHAMMED-1466x2048.jpg";

const sahifeiSeccadiyeImgPath = "assets/img/svg/sahife.svg";
const kuranSvgPath = "assets/img/svg/kuran.svg";
const dualarImgPath = "assets/img/svg/dua.svg";
const munacatlarImgPath = "assets/img/icons/night.png";
const zikirImgPath = "assets/img/svg/zikr.svg";
const cocukImgPath = "assets/img/svg/cocuk.svg";
const gaybImgPath = "assets/img/svg/gayb2.svg";
const eyyamullahImgPath = "assets/img/svg/takvim.svg";
const ramazanImagePath = "assets/img/svg/ramadan.svg";
const ehlibeytImagePath = "assets/img/png/ih_harem.png";

const whatsAppSvgPath = "assets/img/svg/social_media/whatsapp.svg";

const Color primaryColor = Color(0xFF7B61FF);

const MaterialColor primaryMaterialColor = MaterialColor(0xFF9581FF, <int, Color>{
  50: Color(0xFFEFECFF),
  100: Color(0xFFD7D0FF),
  200: Color(0xFFBDB0FF),
  300: Color(0xFFA390FF),
  400: Color(0xFF8F79FF),
  500: Color(0xFF7B61FF),
  600: Color(0xFF7359FF),
  700: Color(0xFF684FFF),
  800: Color(0xFF5E45FF),
  900: Color(0xFF6C56DD),
});

const Color blackColor = Color(0xFF16161E);
const Color blackColor80 = Color(0xFF45454B);
const Color blackColor60 = Color(0xFF737378);
const Color blackColor40 = Color(0xFFA2A2A5);
const Color blackColor20 = Color(0xFFD0D0D2);
const Color blackColor10 = Color(0xFFE8E8E9);
const Color blackColor5 = Color(0xFFF3F3F4);

const Color whiteColor = Colors.white;
const Color whileColor80 = Color(0xFFCCCCCC);
const Color whileColor60 = Color(0xFF999999);
const Color whileColor40 = Color(0xFF666666);
const Color whileColor20 = Color(0xFF333333);
const Color whileColor10 = Color(0xFF191919);
const Color whileColor5 = Color(0xFF0D0D0D);

const Color greyColor = Color(0xFFB8B5C3);
const Color lightGreyColor = Color(0xFFF8F8F9);
const Color darkGreyColor = Color(0xFF1C1C25);
// const Color greyColor80 = Color(0xFFC6C4CF);
// const Color greyColor60 = Color(0xFFD4D3DB);
// const Color greyColor40 = Color(0xFFE3E1E7);
// const Color greyColor20 = Color(0xFFF1F0F3);
// const Color greyColor10 = Color(0xFFF8F8F9);
// const Color greyColor5 = Color(0xFFFBFBFC);

const Color purpleColor = Color(0xFF7B61FF);
const Color successColor = Color(0xFF2ED573);
const Color warningColor = Color(0xFFFFBE21);
const Color errorColor = Color(0xFFEA5B5B);

const double defaultPadding = 16.0;
const double defaultBorderRadious = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);

const pasNotMatchErrorText = "passwords do not match";
const grandisExtendedFont = "Grandis Extended";

class Constants {
  static Color appBackGroundColor = const Color.fromRGBO(46, 45, 69, 1);
  static Color cardColor = const Color.fromRGBO(46, 45, 69, 0.5);
  static Color color2 = const Color.fromRGBO(160, 120, 37, 1);
  static Color yaziRenk = const Color.fromRGBO(46, 45, 69, 1);
  static Color gridColor = const Color.fromRGBO(81, 100, 107, 1);
  static Color gridColor2 = const Color.fromRGBO(214, 168, 117, 1);
  static Color colorSecondary = const Color.fromRGBO(238, 226, 126, 1);
  static Color white = const Color.fromRGBO(255, 255, 255, 1);

  static String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(now);
    return formattedTime;
  }

  static DateTime dateTime = DateTime.now();
  static var dayOfWeek = DateTime.now().weekday.toInt();

  static String miladiTakvimGetir() {
    String tarih = '${dateTime.day}' + " " + aylar[dateTime.month - 1] + " " + '${dateTime.year}';
    return tarih;
  }

  static String hicriTakvimGetir() {
    HijriCalendar _today = new HijriCalendar.fromDate(dateTime);
    String hicriTarih = '${_today.hDay}' + " " + hicriAylar[_today.hMonth - 1] + " " + '${_today.hYear}';
    return hicriTarih;
  }

  static var sahifeSeccadiyeArray = [
    "Mütercimin Önsözü",
    "Mukaddime",
    "Allah\'a Hamd ve Sena İle İlgili Duası",
    "Bu Hamd ve Senadan Sonra Resulullah\'a Salât ve Selâm İle İlgili Duası",
    "Arş\'ı Taşıyan ve Tüm Mukarrep Meleklere Salât İle İlgili Duası",
    "Peygamberlere Tâbi Olan ve Onları Tasdik Edenlere Salâtını İçeren Duası",
    "Kendisi ve Velâyetine İnanan Dostları Hakkındaki Duası",
    "Sabah ve Akşam Vakitlerinde Okuduğu Dua",
    "Zor Bir İşle Karşılaştığında veya Başına Üzücü Bir Hadise Geldiğinde ve Musibet Zamanlarında Okuduğu Dua",
    "Sevilmeyen Şeyler, Kötü Ahlâk ve Çirkin İşlerden Allah\'a Sığınmakla İlgili Duası",
    "Yüce Allah\'tan Bağışlanma Dilemeye Müştak Olma Hakkındaki Duası",
    "Yüce Allah\'a Sığınmakla İlgili Duası",
    "Güzel Akıbet İstemiyle İlgili Duası",
    "Günahları İtiraf ve Yüce Allah'a Dönüş (Tövbe) İstemi Hakkındaki Duası",
    "Hacetleri Yüce Allah\'tan İsteme Hakkındaki Duası",
    "Haksızlığa Uğradığı veya Zalimlerden Hoşlanmadığı Bir Davranış Gördüğü Zaman Okuduğu Dua",
    "Hastalandığı veya Bir Musibet ve Belâyla Karşılaştığı Zaman Okuduğu Dua",
    "Günahlarının Bağışlanması ve Kusurlarının Affedilmesi İçin Yalvardığı Zaman Okuduğu Dua",
    "Şeytan\'dan Söz Edildiğinde Ondan,Onun Düşmanlığından ve Tuzaklarından Allah\'a Sığınınca Okuduğu Dua",
    "Korktuğu Bir Durum Kendisinden Uzaklaştığı veya İstediği Şeye Çabuk Ulaştığı Zaman Okuduğu Dua",
    "Kuraklıktan Sonra Yağmur Talebiyle İlgili Duası",
    "Yüce Erdemler ve Beğenilen Davranışlarla İlgili Duası",
    "Bir Şey İçin Üzüldüğü ve Günahlardan Dolayı Tasalandığı Zaman Okuduğu Dua",
    "Sıkıntılı, Meşakkatli ve İşlerin Zorlaştığı Zamanlarda Okuduğu Dua",
    "Allah\'tan Afiyet ve Şükrünü İstediği Zaman Okuduğu Dua",
    "Anne ve Babası Hakkındaki Duası",
    "Çocukları Hakkındaki Duası",
    "Komşuları ve Dostlarını Andığında Okuduğu Dua",
    "Sınır Bekçileri Hakkındaki Duası",
    "Yüce Allah\'a İltica Ederek Okuduğu Dua",
    "Geçim Sıkıntısı Çektiğinde Okuduğu Dua",
    "Borcu Ödemekte Allah\'tan Yardım İsteme Hakkındaki Duası",
    "Tövbe ve Tövbe İstemiyle İlgili Duası",
    "Gece Namazının Ardından Günahları İtiraf Hususunda Kendisi İçin Duası",
    "Allah\'tan Hayırlı Olanı İsteme Hakkındaki Duası",
    "Musibete Uğradığı veya Günah Sebebiyle Kötü Duruma Düşen Birini Gördüğü Zaman Okuduğu Dua",
    "Dünya Ehline Bakınca Okuduğu Kaza ve Kadere Rıza Hakkındaki Duası",
    "Bulutlara ve Şimşeğe Baktığı ve Gök Gürültüsünü Duyduğu Zaman Okuduğu Dua",
    "Allah\'ın Şükrünü Yerine Getirmekten Âciz Olduğunu İtiraf Ettiğinde Okuduğu Dua",
    "Kulların Haklarından Dolayı Allah\'tan Özür Dileme ve Ateşten Kurtuluş İsteme Hakkındaki Duası",
    "Allah\'tan Af ve Rahmet Dileme Hakkındaki Duası",
    "Birinin Ölüm Haberini Aldığı veya Ölümü Hatırladığı Zaman Okuduğu Dua",
    "Ayıpların Örtülmesi ve Günahlardan Korunma İstemiyle İlgili Duası",
    "Kur\'an\'ı Hatmettiğinde Okuduğu Dua",
    "Hilâle Baktığı Zaman Okuduğu Dua",
    "Ramazan Ayı Girdiğinde Okuduğu Dua",
    "Ramazan Ayıyla Vedalaştığında Okuduğu Dua",
    "Ramazan Bayramı Günü Bayram Namazını Kıldıktan Sonra Ayağa Kalkıp Kıbleye Yönelerek ve Cuma Günü Okuduğu Dua",
    "Arefe Günü Okuduğu Dua",
    "Kurban Bayramı Günü ve Cuma Günü Okuduğu Dua",
    "Düşmanların Hilelerinin Def\'i ve Şerlerinin Geri Çevrilmesi Hakkındaki Duası",
    "Allah\'tan Korkma Hakkındaki Duası",
    "Allah\'a Yalvarıp Yakarma ve Düşkünlüğünü Dile Getirme Hakkındaki Duası",
    "Yüce Allah\'a Yalvarırken Israrcı Olma Hakkındaki Duası",
    "Yüce Allah Karşısında Zelillik İtirafıyla İlgili Duası",
    "Üzüntülerin Giderilmesini İsteme Hakkındaki Duası"
  ];

  static var ehlibeyt = [
    "Hz.Muhammed(s.a.a)",
    "İmam Ali(a.s)",
    "Hz.Fatıma(s.a)",
    "İmam Hasan(a.s)",
    "İmam Hüseyin(a.s)",
    "İmam Zeynel Abidin(a.s)",
    "İmam Muhammed Bagır(a.s)",
    "İmam Cafer Sadık(a.s)",
    "İmam Musa Kazım(a.s)",
    "İmam Ali Rıza(a.s)",
    "İmam Muhammed Cevad(a.s)",
    "İmam Ali Naki(a.s)",
    "İmam Hasan Askeri(a.s)",
    "İmam Mehdi(a.f)"
  ];

  static var munacatlar = [
    "Muhiblerin Münacatı",
    "Korkakların Münacatı",
    "İtaat Edenlerin Münacatı",
    "Muhtaçların Münacatı",
    "Ariflerin Münacatı",
    "Hz.Ali\'nin (a.s) Küfe Camisindeki Münacatı",
    "Münacat-ı Şabaniyye",
    "Müridlerin Münacatı",
    "Sığınanların Münacatı",
    "Şikayet edenlerin Münacatı",
    "Şükredenlerin Münacatı",
    "Tövbe edenlerin Münacatı",
    "Tevessül edenlerin Münacatı",
    "Ümit edenlerin Münacatı",
    "Yönelenlerin Münacatı",
    "Zahidlerin Münacatı",
    "Zakirlerin Münacatı"
  ];

  static var dualar = [
    "Ahd Duası",
    "Ali Yasin Ziyareti",
    "Azumel Bela Duası",
    "Camiatul Kebire Ziyareti",
    "Cevşen-i Kebir",
    "Hz.Mehdi (a.f) Duası",
    "İftitah Duası",
    "İmam Seccad Koruma Duası",
    "Kisa Hadisi",
    "Kumeyl Duası",
    "Mucir Duası",
    "Nahiye-i Mukaddese Ziyareti",
    "Namaz Sonrası Dua",
    "Nudbe Duası",
    "Tevessül Duası",
    "Ziyaret-i Aşura"
  ];

  static var ramazanAyiAmelleri = [
    "Her Günün Duası",
    "Her Gecenin Namazı",
    "Kadir Gecesi Amelleri",
    "Özel Gün ve Gecelerin Amelleri",
    "Namazlardan Sonra Okunan Dua",
    "Resullah\'ın (s.a.a) Duası"
  ];

  static var aylar = [
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık'
  ];

  static var hicriAylar = [
    'Muharrem',
    'Safer',
    'Rebiülevvel',
    'Rebiülahir',
    'Cemaziyelevvel',
    'Cemaziyelahir',
    'Recep',
    'Şaban',
    'Ramazan',
    'Şevval',
    'Zilkade',
    'Zilhicce'
  ];

  static var gunler = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar',
  ];

  static var herGununDuasiArapca = [
    'یا قاضِیَ الْحاجات',
    'یا اَرْحَمَ الرّاحِمین',
    'یا حَیُّ یا قَیّوم',
    'لا اِلهَ اِلّا اللهُ الْمَلِکُ الْحَقُّ الْمُبین',
    'اَللّهُمَّ صَلِّ عَلی مُحَمَّدٍ وَ آلِ مُحَمَّدٍ',
    'یا رَبَّ الْعالَمین',
    'یا ذَالْجَلالِ وَالْاِکْرام'
  ];

  static var herGununDuasiTurkceOkunusu = [
    "Ya Kaziye’l Hacat ",
    "Ya Erhemer Rahimin",
    "Ya Hayyu Ya Kayyum",
    "La ilahe illallah el Meliku’l Hakku’l Mubin",
    "Allahumme Salli ale Muhammedin ve Al-i Muhammed",
    "Ya Rabbe’l Alemin",
    "Ya Zel Celali vel İkram"
  ];

  static var herGununDuasiTurkceMeali = [
    "Ey Bütün Hacetleri / İhtiyaçları Yerine Getiren",
    "Ey Rahman ve Rahim",
    "Daimi hayat sahibi olup, varlığı kendinden olan ve mahlukātı varlıkta tutan (Allah)",
    "Allah'tan başka ilah yoktur ve O Haktır, Her şeyin Malikidir ve Aşikardır.",
    "Allah'ım, Muhammed(sav) ve Ehlibeyt(as) salat eyle",
    "Ey Alemlerin Rabbi",
    "Ey Celal ve İkram Sahibi",
  ];
}
