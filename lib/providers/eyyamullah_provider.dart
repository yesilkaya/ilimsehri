import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../view/models/eyyamullah.dart';

final eyyamullahProvider =
    StateNotifierProvider.autoDispose<EyyamullahNotifier, Eyyamullah>((ref) => EyyamullahNotifier());

class EyyamullahNotifier extends StateNotifier<Eyyamullah> {
  EyyamullahNotifier() : super(Eyyamullah.defaultEyyamullah);

  set _setIsPageReady(bool value) => state = state.copyWith(isPageReady: value);
  set _setEvents(List<Eyyamullah> value) => state = state.copyWith(events: value);

  void init(
    WidgetRef ref,
  ) async {
    if (!state.isPageReady) {
      await fetchEyyamullahs();
      _setIsPageReady = true;
    }
  }

  Future<void> fetchEyyamullahs() async {
    try {
      final response = await http.get(Uri.parse('https://hekimane.com/eyyamullah.json'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

        List<Eyyamullah> events = [];
        List<dynamic> eyyamullahList = data['eyyamullah'];
        for (var eyyamullah in eyyamullahList) {
          events.add(Eyyamullah(
            id: eyyamullah['id'],
            description: eyyamullah['ack'],
            hijriDate: eyyamullah['hicri'],
            gregorianDate: eyyamullah['miladi'],
            category: eyyamullah['kategori'],
            isPageReady: false,
          ));
        }
        _setEvents = events;
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
