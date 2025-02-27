import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
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
      _loadSelectedCity(ref);
      await fetchCities();
      if (state.selectedCity != null) {
        await fetchPrayerTimes(state.selectedCity!);
      }
      _setIsPageReady = true;
    }
  }

  Future<void> _loadSelectedCity(WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedCity = prefs.getString('selectedCity');
    setSelectedCity = cachedCity;
  }

  Future<void> fetchCities() async {
    final response = await http.get(Uri.parse('https://turkiyeapi.dev/api/v1/provinces'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      List<dynamic> citiesData = data['data']; // Şehir verilerini içeren liste

      List<String> names = citiesData.map((city) => city['name'].toString()).toList();
      _setCities = names;
    } else {
      throw Exception('Failed to load cities');
    }
  }

  Future<void> fetchPrayerTimes(String city) async {
    String url = 'https://api.aladhan.com/v1/timingsByCity?city=$city&country=Turkey&method=13';
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['data'];
      final Map<String, dynamic> timings = data['timings'];
      final Map<String, dynamic> meta = data['meta'];

      print('timings: ${timings['Fajr']}');

      List<String> timePartsFajr = timings['Fajr'].split(':');
      int hour = int.parse(timePartsFajr[0]);
      int minute = int.parse(timePartsFajr[1]);
      DateTime initialTimeFajr = DateTime(2025, 3, 1, hour, minute);
      DateTime newTimeFajr = initialTimeFajr.add(const Duration(minutes: 25));
      String newTimeString =
          '${newTimeFajr.hour.toString().padLeft(2, '0')}:${newTimeFajr.minute.toString().padLeft(2, '0')}';

      List<String> timePartsDhuhr = timings['Maghrib'].split(':');
      int hourDhuhr = int.parse(timePartsDhuhr[0]);
      int minuteDhuhr = int.parse(timePartsDhuhr[1]);
      DateTime initialTimeDhuhr = DateTime(2025, 3, 1, hourDhuhr, minuteDhuhr);
      DateTime newTimeDhuhr = initialTimeDhuhr.add(const Duration(minutes: 8));
      String newTimeStringDhuhr =
          '${newTimeDhuhr.hour.toString().padLeft(2, '0')}:${newTimeDhuhr.minute.toString().padLeft(2, '0')}';

      _setFajr = newTimeString;
      _setSunrise = timings['Sunrise'];
      _setDhuhr = timings['Dhuhr'];
      _setMaghrib = newTimeStringDhuhr;
      _setAsr = timings['Asr'];
      ;
      _setIsha = timings['Isha'];
      final prayerMeta = PrayerMeta.fromJson(meta);
      _setSchool = prayerMeta.method.name;
    } else {
      throw Exception('Failed to load prayer times');
    }
  }

  Future<void> fetchSalahTimes7Days(String city, String notificationName) async {
    DateTime now = DateTime.now();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool notificationValue = prefs.getBool(notificationName) ?? false;

    for (int i = 0; i < 7; i++) {
      String formattedDate =
          '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
      final response = await http.get(
        Uri.parse('https://api.aladhan.com/v1/timingsByCity/$formattedDate?city=$city&country=Turkey&method=13'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> timings = json.decode(response.body)['data']['timings'];

        SalahTimes10Days salahTimes = SalahTimes10Days(
          fajr: timings['Fajr'],
          sunrise: timings['Sunrise'],
          dhuhr: timings['Dhuhr'],
          asr: timings['Asr'],
          maghrib: timings['Maghrib'],
          isha: timings['Isha'],
        );

        if (notificationName == SalahTimesNotification.fajr) {
          int fajrHour = int.parse(salahTimes.fajr.substring(0, 2));
          int fajrMinute = int.parse(salahTimes.fajr.substring(3, 5));
/*
          DateTime startTime = DateTime(2024, 11, 3, fajrHour, fajrMinute);
          Duration durationToSubtract = const Duration(hours: 1, minutes: 15);
          DateTime resultTime = startTime.subtract(durationToSubtract);
          LocalNotificationService.scheduleNotification(dayOfWeek + i, resultTime.hour, resultTime.minute);
 */
          if (notificationValue == true) {
            setNotifications(now, fajrHour, fajrMinute, 0);
          }
        } else if (notificationName == SalahTimesNotification.dhuhr) {
          int dhuhrHour = int.parse(salahTimes.dhuhr.substring(0, 2));
          int dhuhrMinute = int.parse(salahTimes.dhuhr.substring(3, 5));
          if (notificationValue == true) {
            setNotifications(now, dhuhrHour, dhuhrMinute, 1);
          }
        } else if (notificationName == SalahTimesNotification.asr) {
          int asrHour = int.parse(salahTimes.asr.substring(0, 2));
          int asrMinute = int.parse(salahTimes.asr.substring(3, 5));
          if (notificationValue == true) {
            setNotifications(now, asrHour, asrMinute, 2);
          }
        } else if (notificationName == SalahTimesNotification.maghrib) {
          int maghribHour = int.parse(salahTimes.maghrib.substring(0, 2));
          int maghribMinute = int.parse(salahTimes.maghrib.substring(3, 5));
          if (notificationValue == true) {
            setNotifications(now, maghribHour, maghribMinute, 3);
          }
        } else if (notificationName == SalahTimesNotification.isha) {
          int ishaHour = int.parse(salahTimes.isha.substring(0, 2));
          int ishaMinute = int.parse(salahTimes.isha.substring(3, 5));
          if (notificationValue == true) {
            setNotifications(now, ishaHour, ishaMinute, 4);
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

  void setNotifications(DateTime now, int hour, int minute, int salahIndex) async {
    LocalNotificationService.scheduleNotification(
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
  }
}
