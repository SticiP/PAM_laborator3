import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Importuri necesare
import '../logic/cubits/publisher_cubit.dart';
import '../logic/cubits/publisher_state.dart';
import '../../domain/entities/publisher_details_entity.dart';
import '../../domain/entities/news_entity.dart';

import '../widgets/icon_button_scale.dart';
import '../widgets/custom_network_image.dart';
import '../widgets/recommendation_card.dart'; // Reutilizam cardul pentru lista de stiri

class ProfilePage extends StatefulWidget {
  // Pastram constructorul, dar il vom folosi doar pentru titlu initial
  final String sourceName;
  final String? sourceImagePath;

  const ProfilePage({
    super.key,
    required this.sourceName,
    this.sourceImagePath,
  });

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  // Nu mai avem nevoie de variabile locale hardcodate
  // String searchQuery = '';
  // bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    // AICI declansam incarcarea datelor cand se deschide pagina
    // "123" este un ID fictiv, json-ul nostru returneaza aceleasi date oricum
    context.read<PublisherCubit>().loadPublisherDetails("123");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        // Ascultam Cubit-ul
        child: BlocBuilder<PublisherCubit, PublisherState>(
          builder: (context, state) {

            if (state is PublisherLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PublisherError) {
              return Center(child: Text(state.message));
            }

            if (state is PublisherLoaded) {
              final info = state.details.publisher;
              final newsList = state.details.news;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(info.username), // Folosim username din JSON
                    _buildProfileInfo(info),
                    _buildDescriptionSection(info.name, info.bio, info.isVerified),
                    _buildNewsSection(info.name, newsList),
                  ],
                ),
              );
            }

            // Starea initiala (sau loading rapid)
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButtonScale(
            assetPath: 'assets/icons/arrow-left.svg',
            onTap: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF191919),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButtonScale(
            assetPath: 'assets/icons/grid-large.svg',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(PublisherInfoEntity info) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LOGO
          Container(
            width: 108,
            height: 108,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomNetworkImage(
                imageUrl: info.logo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 28),

          // STATISTICI
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatItem(info.stats.newsCount, "News"),
                    _buildStatItem(info.stats.followers, "Followers"),
                    _buildStatItem(info.stats.following.toString(), "Following"),
                  ],
                ),
                const SizedBox(height: 20),
                _buildFollowButton(info.isFollowing),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            color: Color(0xFF191919),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF999999),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildFollowButton(bool isFollowing) {
    return InkWell(
      onTap: () {
        // Aici ar trebui sa apelam un event in Cubit pentru Follow/Unfollow
        // Momentan doar vizual
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isFollowing ? Colors.grey.shade300 : const Color(0xFF121214),
        ),
        padding: const EdgeInsets.symmetric(vertical: 11),
        width: double.infinity,
        child: Center(
          child: Text(
            isFollowing ? "Following" : "Follow",
            style: TextStyle(
              color: isFollowing ? Colors.black : const Color(0xFFFFFFFF),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(String name, String bio, bool isVerified) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Color(0xFF191919),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isVerified) ...[
                const SizedBox(width: 9),
                const Icon(Icons.verified, color: Colors.blueAccent, size: 20),
              ],
            ],
          ),
          const SizedBox(height: 9),
          Text(
            bio,
            style: const TextStyle(
              color: Color(0xFF666666),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsSection(String name, List<NewsEntity> news) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "News by $name",
            style: const TextStyle(
              color: Color(0xFF191919),
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 24),

          // Lista de știri reale din JSON
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: news.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RecommendationCard(item: news[index]),
              );
            },
          )
        ],
      ),
    );
  }
}