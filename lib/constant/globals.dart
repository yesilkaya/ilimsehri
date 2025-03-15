class Globals {
  static Map<String, List<Map<String, dynamic>>> notificationsList = {};
}

class SalahTimes10Days {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  SalahTimes10Days({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory SalahTimes10Days.fromJson(Map<String, dynamic> json) {
    return SalahTimes10Days(
      fajr: json['Fajr'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
    );
  }

  @override
  String toString() {
    return 'Fajr: $fajr,  Dhuhr: $dhuhr, Asr: $asr, Maghrib: $maghrib, Isha: $isha';
  }
}

class PrayerMeta {
  final Method method;

  PrayerMeta({
    required this.method,
  });

  factory PrayerMeta.fromJson(Map<String, dynamic> json) {
    return PrayerMeta(
      method: Method.fromJson(json['method']),
    );
  }
}

class Method {
  final int id;
  final String name;

  Method({required this.id, required this.name});

  factory Method.fromJson(Map<String, dynamic> json) {
    return Method(
      id: json['id'],
      name: json['name'],
    );
  }
}
