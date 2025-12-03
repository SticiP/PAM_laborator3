// lib/data/datasources/local_news_datasource.dart
import 'dart:convert';
import 'package:flutter/services.dart';

class LocalNewsDataSource {

  // 1. Pentru Home Page (deja exista)
  Future<Map<String, dynamic>> loadNewsData() async {
    await Future.delayed(const Duration(seconds: 1));
    final String response = await rootBundle.loadString('assets/data/mock_news.json');
    return json.decode(response);
  }

  // 2. Pentru Details/Publisher Page (NOU)
  Future<Map<String, dynamic>> loadPublisherDetails() async {
    // Simulam loading
    await Future.delayed(const Duration(seconds: 1));

    // Citim fisierul de detalii
    final String response = await rootBundle.loadString('assets/data/mock_news_details.json');

    return json.decode(response);
  }
}