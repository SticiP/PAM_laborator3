import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv

import 'data/datasources/local_news_datasource.dart';
import 'data/datasources/remote_news_datasource.dart'; // Import
import 'data/repositories/news_repository_impl.dart';
import 'domain/repositories/news_repository.dart';
import 'presentation/logic/cubits/home_cubit.dart';
import 'presentation/pages/home.dart';

void main() async { // Main devine async
  // Asiguram legatura cu native code
  WidgetsFlutterBinding.ensureInitialized();

  // Incarcam fisierul .env
  await dotenv.load(fileName: "assets/.env");

  // Initializam ambele surse de date
  final localDataSource = LocalNewsDataSource();
  final remoteDataSource = RemoteNewsDataSource();

  // Cream repository-ul cu ambele surse
  final repository = NewsRepositoryImpl(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );

  runApp(
    RepositoryProvider<NewsRepository>(
      create: (context) => repository,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      home: BlocProvider(
        create: (context) => HomeCubit(
          repository: context.read<NewsRepository>(),
        )..loadHomeData(),
        child: const Home(),
      ),
    );
  }
}