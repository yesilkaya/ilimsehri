class SalahTimes {
  List<String>? countries;
  List<String>? cities;
  String? selectedCountry;
  String? selectedCity;
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? maghrib;
  String? isha;
  String? school;
  final bool isPageReady;
  final bool isTimeOfEzan;

  SalahTimes({
    this.countries,
    this.cities,
    this.selectedCountry,
    this.selectedCity,
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.maghrib,
    this.isha,
    this.school,
    required this.isPageReady,
    required this.isTimeOfEzan,
  });

  SalahTimes copyWith({
    List<String>? countries,
    List<String>? cities,
    String? selectedCountry,
    String? selectedCity,
    String? fajr,
    String? sunrise,
    String? dhuhr,
    String? asr,
    String? maghrib,
    String? isha,
    String? school,
    bool? isPageReady,
    bool? isTimeOfEzan,
  }) {
    return SalahTimes(
      countries: countries ?? this.countries,
      cities: cities ?? this.cities,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCity: selectedCity ?? this.selectedCity,
      fajr: fajr ?? this.fajr,
      sunrise: sunrise ?? this.sunrise,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
      school: school ?? this.school,
      isPageReady: isPageReady ?? this.isPageReady,
      isTimeOfEzan: isTimeOfEzan ?? this.isTimeOfEzan,
    );
  }

  factory SalahTimes.fromJson(Map<String, dynamic> json) {
    return SalahTimes(
      countries: json['data'],
      cities: json['data'],
      selectedCountry: 'Turkey',
      selectedCity: 'İstanbul',
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      school: json['school'],
      isPageReady: false,
      isTimeOfEzan: false,
    );
  }

  static SalahTimes defaultTimes = SalahTimes(
    countries: [],
    cities: [],
    selectedCountry: 'Turkey',
    selectedCity: 'İstanbul',
    fajr: '0:0',
    sunrise: '0:0',
    dhuhr: '0:0',
    asr: '0:0',
    maghrib: '0:0',
    isha: '0:0',
    isPageReady: false,
    isTimeOfEzan: false,
  );
}
