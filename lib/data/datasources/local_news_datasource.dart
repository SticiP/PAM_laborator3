// lib/data/datasources/local_news_datasource.dart
import 'dart:convert';
import 'package:flutter/services.dart'; // Pentru rootBundle

class LocalNewsDataSource {
  // Metoda asincrona care returneaza un Map (JSON decodat)
  Future<Map<String, dynamic>> loadNewsData() async {
    // 1. Simulam o intarziere de retea (Programare Asincrona - cerinta Lab)
    await Future.delayed(const Duration(seconds: 1));

    // 2. Citim fisierul din assets
    final String response = await rootBundle.loadString('assets/data/mock_news.json');

    // 3. Decodam String-ul in JSON (Map)
    return json.decode(response);
  }
}