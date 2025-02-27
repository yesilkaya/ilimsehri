class SoundNames {
  static const String ahd = "ahdduası";
  static const String aliYasin = "aliyasinziyareti";
  static const String azumelBela = "azumelbeladuası";
  static const String camiatulKebire = "camiatulkebireziyareti";
  static const String cevseniKebir = "cevşenikebir";
  static const String hzMehdi = "hz.mehdi(a.f)duası";
  static const String iftitah = "iftitahduası";
  static const String kisaHadisi = "kisahadisi";
  static const String kumeylDuasi = "kumeylduası";
  static const String mucirDuasi = "mucirduası";
  static const String nahiyeiMukaddese = "nahiyeimukaddeseziyareti";
  static const String nudbe = "nudbeduası";
  static const String tevessul = "tevessülduası";
  static const String ziyaretiAsura = "ziyaretiaşura";

  static String? getDuaSoundPath(String? duaAdi) {
    if (duaAdi == null) return null;
    duaAdi = duaAdi.replaceAll(RegExp('[ -]'), '').toLowerCase();

    switch (duaAdi) {
      case SoundNames.ahd:
        return 'ahd';
      case SoundNames.aliYasin:
        return 'https://caferilik.com/video/ziyaret/aliyasin/aliyasin-ziyareti-farahmand.mp3';
      case SoundNames.azumelBela:
        return 'https://caferilik.com/video/dualar/ferec-azumel-bela/ferec-farahmand.mp3';
      case SoundNames.camiatulKebire:
        return 'https://caferilik.com/video/ziyaret/camee-kebire/camia-kebire-farahmand.mp3';
      case SoundNames.cevseniKebir:
        return 'https://caferilik.com/video/dualar/cevsen-kebir/cevseni-kebir-huseyin-garip.mp3';
      case SoundNames.hzMehdi:
        return 'https://imammehdiyarenleri.com/wp-content/uploads/2022/03/Allahumme-Kun-li-veliyyikel-Ferec-Duasi-_-Turkce-Altyazili-_-%D8%AF%D9%8F%D8%B9%D9%8E%D8%A7%D8%A1%D9%8F-%D8%A7%D9%84%D9%92%D9%81%D9%8E%D8%B1%D9%8E%D8%AC%D9%92-%D8%B9%D9%84%DB%8C-%D9%81%D8%A7%D9%86%DB%8C-256-kbps.mp3';
      case SoundNames.iftitah:
        return 'https://caferilik.com/video/dualar/iftitah/ebuzer-helvaci-iftitah.mp3';
      case SoundNames.kisaHadisi:
        return 'kisaHadisi';
      case SoundNames.kumeylDuasi:
        return 'https://www.caferilik.com/video/dualar/kumeyl/ebuzer-helvaci-kumeyl.mp3';
      case SoundNames.mucirDuasi:
        return 'https://caferilik.com/video/dualar/mucir/basim-kerbelayi-mucir.mp3';
      case SoundNames.nahiyeiMukaddese:
        return 'nahiyeiMukaddese';
      case SoundNames.nudbe:
        return 'nudbe';
      case SoundNames.tevessul:
        return 'https://www.caferilik.com/video/dualar/tevessul/farahmand-tevessul.mp3';
      case SoundNames.ziyaretiAsura:
        return 'https://caferilik.com/video/ziyaret/asura/asura-helvaci.mp3';
      default:
        return null;
    }
  }
}
