import 'dart:convert';

import 'package:http/http.dart' as http;

import '../view/models/salah_time_model.dart';

class PrayerTimesService {
  Future<SalahTimes> fetchPrayerTimes(String city) async {
    final response = await http.get(Uri.parse('https://api.example.com/prayertimes?city=$city'));
    if (response.statusCode == 200) {
      return SalahTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}
