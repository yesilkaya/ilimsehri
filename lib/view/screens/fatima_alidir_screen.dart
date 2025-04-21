import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../widgets/fatima_alidir_detail_widget.dart';
import '../models/fatima_alidir.dart';

class FatimaAlidirScreen extends StatefulWidget {
  const FatimaAlidirScreen({super.key});

  @override
  FatimaAlidirScreenState createState() => FatimaAlidirScreenState();
}

class FatimaAlidirScreenState extends State<FatimaAlidirScreen> {
  late Future<List<FatimaAlidir>> _events;

  int index = 0;

  Future<List<FatimaAlidir>> loadLocalJson() async {
    final String jsonString = await rootBundle.loadString('assets/fatima-alidir.json');
    List<dynamic> jsonData = jsonDecode(jsonString);
    var temp = jsonData.map((item) => FatimaAlidir.fromJson(item)).toList();
    return temp;
  }

  Future<List<FatimaAlidir>> fetchEvents() async {
    final response = await http.get(Uri.parse('https://hekimane.com/jsons/fatima-alidir.json'));

    if (response.statusCode == 200) {
      response.bodyBytes; // Encoding check, helps with Turkish characters

      List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes)); // Ensure UTF-8 decoding
      var temp = jsonData.map((event) => FatimaAlidir.fromJson(event)).toList();

      return temp;
    } else {
      throw Exception('Veriler Yüklenemedi');
    }
  }

  @override
  void initState() {
    super.initState();
    _events = loadLocalJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<FatimaAlidir>>(
        future: _events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No events found.'));
          } else {
            return FatimaAlidirDetailWidget(events: snapshot.data!);
          }
        },
      ),
    );
  }
}
