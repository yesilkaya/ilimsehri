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
        return 'https://caferilik.com/video/dualar/ferec-azumel-bela/ferec-farahmand.mp3';
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
