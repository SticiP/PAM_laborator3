import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Importurile noastre din Clean Architecture
import 'data/datasources/local_news_datasource.dart';
import 'data/repositories/news_repository_impl.dart';
import 'presentation/logic/cubits/home_cubit.dart';
import 'presentation/pages/home.dart'; // Asigură-te că calea e corectă

void main() {
  // 1. Initializam "dependenta" de baza (Sursa de date)
  final dataSource = LocalNewsDataSource();

  // 2. Initializam Repository-ul cu sursa de date
  final repository = NewsRepositoryImpl(dataSource: dataSource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final NewsRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App Lab 3',
      // 3. Injectam Cubit-ul folosind BlocProvider
      // "..loadHomeData()" porneste incarcarea imediat ce se creaza Cubit-ul
      home: BlocProvider(
        create: (context) => HomeCubit(repository: repository)..loadHomeData(),
        child: const Home(),
      ),
    );
  }
}