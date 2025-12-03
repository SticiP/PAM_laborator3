import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubits/home_cubit.dart';
import '../logic/cubits/home_state.dart';
import '../../domain/entities/news_entity.dart';

import '../widgets/icon_button_scale.dart';
import '../widgets/trending_news_section.dart';
import '../widgets/recomandation_section.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        // Ascultam starea Cubit-ului
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {

            // 1. Incarcarea
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. Eroare
            if (state is HomeError) {
              return Center(child: Text("Error: ${state.message}"));
            }

            // 3. Datele incarcate
            if (state is HomeLoaded) {
              final user = state.data.user;
              final trending = state.data.trendingNews;
              final recommendations = state.data.recommendations;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildHeader(user.profileImage),
                    const SizedBox(height: 24),
                    _buildWelcomeSection(user.name),
                    const SizedBox(height: 24),

                    TrendingNewsSection(items: trending),

                    const SizedBox(height: 32),

                    RecommendationSection(items: recommendations),

                    const SizedBox(height: 24),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }


  Widget _buildHeader(String profileUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButtonScale(
          assetPath: 'assets/icons/menu.svg',
          onTap: () => print("Menu tapped"),
        ),
        IconButtonScale(
            assetPath: 'assets/icons/bell.svg',
            onTap: () => print("Bell tapped"),
        ),
      ],
    );
  }

  Widget _buildWelcomeSection(String userName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome back, $userName!",
          style: const TextStyle(
            color: Color(0xFF191919),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          "Discover a world of news that matters to you",
          style: TextStyle(
            color: Color(0xFF999999),
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}