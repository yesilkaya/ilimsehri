import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:country_state_city/country_state_city.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:ilimsehri/helper/countries.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/globals.dart';
import '../constant/salah_times.dart';
import '../helper/notify_helper.dart';
import '../view/models/salah_time_model.dart';

final cityProvider = StateNotifierProvider.autoDispose<SalahTimeNotifier, SalahTimes>((ref) => SalahTimeNotifier());

class SalahTimeNotifier extends StateNotifier<SalahTimes> {
  SalahTimeNotifier() : super(SalahTimes.defaultTimes);

  set _setIsPageReady(bool value) => state = state.copyWith(isPageReady: value);
  set setIsTimeOfEzan(bool value) => state = state.copyWith(isTimeOfEzan: value);
  set _setCities(List<String> value) => state = state.copyWith(cities: value);
  set _setCountries(List<String> value) => state = state.copyWith(countries: value);
  set setSelectedCountry(String? value) => state = state.copyWith(selectedCountry: value);
  set setSelectedCity(String? value) => state = state.copyWith(selectedCity: value);
  set _setFajr(String value) => state = state.copyWith(fajr: value);
  set _setSunrise(String value) => state = state.copyWith(sunrise: value);
  set _setMaghrib(String value) => state = state.copyWith(maghrib: value);
  set _setAsr(String value) => state = state.copyWith(asr: value);
  set _setDhuhr(String value) => state = state.copyWith(dhuhr: value);
  set _setIsha(String value) => state = state.copyWith(isha: value);
  set _setSchool(String value) => state = state.copyWith(school: value);

  void init(
    WidgetRef ref,
  ) async {
    if (!state.isPageReady) {
      await _loadSelectedCountry(ref);
      await _loadSelectedCity(ref);
      await fetchCountries();
      await fetchCities();
      if (state.selectedCountry != null && state.selectedCity != null) {
        print('state.selectedCountry ${state.selectedCountry}');
        print('state.selectedCity ${state.selectedCity}');
        await fetchPrayerTimes(state.selectedCountry!, state.selectedCity!);
      }
      _setIsPageReady = true;
    }
  }

  Future<void> _loadSelectedCountry(WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedCountry = prefs.getString('selectedCountry');
    setSelectedCountry = cachedCountry;
  }

  Future<void> _loadSelectedCity(WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedCity = prefs.getString('selectedCity');
    setSelectedCity = cachedCity;
  }

  Future<void> fetchCountries() async {
    //List<Country> countries = await getAllCountries();
    //List<String> countryNames = countries.map((country) => country.name).toList();

    _setCountries = Countries.countryMap.keys.toList(); // Sadece Türkçe isimleri al
  }

  Future<void> fetchCities() async {
    List<Country> countries = await getAllCountries();
    String? code = countries.firstWhereOrNull((country) => country.name == state.selectedCountry)?.isoCode;
    List<State> cities = await getStatesOfCountry(code ?? 'TR');

    List<String> cityNames = cities.map((country) => country.name.split(' ').first).toList();
    _setCities = cityNames;
  }

  Future<void> fetchPrayerTimes(String country, String city) async {
    String url = 'https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=13';
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['data'];
      final Map<String, dynamic> timings = data['timings'];
      final Map<String, dynamic> meta = data['meta'];

      String zeynebiyeFajrTime = _getZeynebiyeFajrSalahTime(timings);
      String zeynebiyeMaghribTime = _getZeynebiyeMaghribSalahTime(timings);

      _setFajr = zeynebiyeFajrTime;
      _setSunrise = timings['Sunrise'];
      _setDhuhr = timings['Dhuhr'];
      _setMaghrib = zeynebiyeMaghribTime;
      _setAsr = timings['Asr'];
      _setIsha = timings['Isha'];
      final prayerMeta = PrayerMeta.fromJson(meta);
      _setSchool = prayerMeta.method.name;
    } else {
      throw Exception('Failed to load prayer times');
    }
  }

  Future<void> fetchSalahTimes7Days(String country, String city, String notificationName) async {
    DateTime now = DateTime.now();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool notificationValue = prefs.getBool(notificationName) ?? false;

    for (int index = 0; index < 7; index++) {
      String formattedDate =
          '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';

      String url = 'https://api.aladhan.com/v1/timingsByCity/$formattedDate?city=$city&country=$country&method=13';
      print('url: $url');
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> timings = json.decode(response.body)['data']['timings'];

        String zeynebiyeFajrTime = _getZeynebiyeFajrSalahTime(timings);
        String zeynebiyeMaghribTime = _getZeynebiyeMaghribSalahTime(timings);

        SalahTimes10Days salahTimes = SalahTimes10Days(
          fajr: zeynebiyeFajrTime,
          dhuhr: zeynebiyeMaghribTime,
          asr: timings['Asr'],
          maghrib: timings['Maghrib'],
          isha: timings['Isha'],
        );

        if (notificationName == SalahTimesNotification.fajr) {
          int fajrHour = int.parse(salahTimes.fajr.substring(0, 2));
          int fajrMinute = int.parse(salahTimes.fajr.substring(3, 5));

          if (notificationValue == true) {
            print('fajrHour: $fajrHour');
            await setNotifications(now, fajrHour, fajrMinute, 0);
          }
        } else if (notificationName == SalahTimesNotification.dhuhr) {
          int dhuhrHour = int.parse(salahTimes.dhuhr.substring(0, 2));
          int dhuhrMinute = int.parse(salahTimes.dhuhr.substring(3, 5));
          if (notificationValue == true) {
            await setNotifications(now, dhuhrHour, dhuhrMinute, 1);
          }
        } else if (notificationName == SalahTimesNotification.asr) {
          int asrHour = int.parse(salahTimes.asr.substring(0, 2));
          int asrMinute = int.parse(salahTimes.asr.substring(3, 5));
          if (notificationValue == true) {
            await setNotifications(now, asrHour, asrMinute, 2);
          }
        } else if (notificationName == SalahTimesNotification.maghrib) {
          int maghribHour = int.parse(salahTimes.maghrib.substring(0, 2));
          int maghribMinute = int.parse(salahTimes.maghrib.substring(3, 5));
          if (notificationValue == true) {
            await setNotifications(now, maghribHour, maghribMinute, 3);
          }
        } else if (notificationName == SalahTimesNotification.isha) {
          int ishaHour = int.parse(salahTimes.isha.substring(0, 2));
          int ishaMinute = int.parse(salahTimes.isha.substring(3, 5));
          if (notificationValue == true) {
            await setNotifications(now, ishaHour, ishaMinute, 4);
          }
        }
      } else {
        throw Exception('Failed to load prayer times');
      }

      now = now.add(const Duration(days: 1));
    }
    if (notificationValue == false) {
      await cancelNotification(now, notificationName);
    }
    await LocalNotificationService.getScheduledNotifications();
  }

  String _getZeynebiyeFajrSalahTime(Map<String, dynamic> timings) {
    List<String> timePartsFajr = timings['Fajr'].split(':');
    int hour = int.parse(timePartsFajr[0]);
    int minute = int.parse(timePartsFajr[1]);
    DateTime initialTimeFajr = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute);
    DateTime newTimeFajr = initialTimeFajr.add(const Duration(minutes: 25));
    String newTimeString =
        '${newTimeFajr.hour.toString().padLeft(2, '0')}:${newTimeFajr.minute.toString().padLeft(2, '0')}';
    //    String newTimeString = '${'00'.toString().padLeft(2, '0')}:${'13'.toString().padLeft(2, '0')}';
    return newTimeString;
  }

  String _getZeynebiyeMaghribSalahTime(Map<String, dynamic> timings) {
    List<String> timePartsDhuhr = timings['Maghrib'].split(':');
    int hourDhuhr = int.parse(timePartsDhuhr[0]);
    int minuteDhuhr = int.parse(timePartsDhuhr[1]);
    DateTime initialTimeDhuhr =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hourDhuhr, minuteDhuhr);
    DateTime newTimeDhuhr = initialTimeDhuhr.add(const Duration(minutes: 8));
    String newTimeStringDhuhr =
        '${newTimeDhuhr.hour.toString().padLeft(2, '0')}:${newTimeDhuhr.minute.toString().padLeft(2, '0')}';
    return newTimeStringDhuhr;
  }

  Future<void> setNotifications(DateTime now, int hour, int minute, int salahIndex) async {
    await LocalNotificationService.scheduleNotification(
        year: now.year,
        month: now.month,
        day: now.day,
        hour: hour,
        minute: minute,
        title: NotificationTitles.all[salahIndex],
        body: NotificationBodies.all[salahIndex]);
  }

  Future<void> cancelNotification(DateTime now, String notificationName) async {
    await LocalNotificationService.separateNotificationsByDate(Globals.notificationsList, notificationName);
    print('Bildirim iptal edildi: ${Globals.notificationsList}');
  }
}
