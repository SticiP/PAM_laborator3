// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/local_news_datasource.dart';
import 'data/repositories/news_repository_impl.dart';
import 'domain/repositories/news_repository.dart'; // Importa interfata
import 'presentation/logic/cubits/home_cubit.dart';
import 'presentation/pages/home.dart';

void main() {
  final dataSource = LocalNewsDataSource();
  final repository = NewsRepositoryImpl(dataSource: dataSource);

  runApp(
    // 1. Injectam Repository-ul GLOBAL
    RepositoryProvider<NewsRepository>(
      create: (context) => repository,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // Nu mai avem nevoie sa trecem repository prin constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      // 2. HomeCubit isi ia acum repository-ul direct din contextul global
      home: BlocProvider(
        create: (context) => HomeCubit(
          repository: context.read<NewsRepository>(),
        )..loadHomeData(),
        child: const Home(),
      ),
    );
  }
}