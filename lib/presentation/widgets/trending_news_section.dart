import 'package:flutter/material.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../logic/cubits/home_cubit.dart';
import '../logic/cubits/publisher_cubit.dart';
import '../pages/profile_page.dart';
import 'custom_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingNewsSection extends StatelessWidget {

  final List<NewsEntity> items;
  final VoidCallback? onSeeAll;

  const TrendingNewsSection({
    Key? key,
    required this.items,
    this.onSeeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.78;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Trending news",
              style: TextStyle(
                color: Color(0xFF191919),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: onSeeAll ?? () => debugPrint("See all pressed"),
              child: const Text(
                "See all",
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 17),
        SizedBox(
          height: 260, // Putin mai inalt pentru a incapea totul
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 0, right: 8),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return SizedBox(
                width: cardWidth,
                child: NewsCard(item: items[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsEntity item;

  const NewsCard({Key? key, required this.item}) : super(key: key);

  void _openProfile(BuildContext context) {
    // MODIFICARE: Cerem direct Repository-ul Global
    // (Merge oriunde: si in Home, si in Profile, si in alte pagini)
    final repo = context.read<NewsRepository>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => PublisherCubit(
            repository: repo,
          ),
          child: ProfilePage(
            sourceName: item.publisher,
            sourceImagePath: item.publisherIcon,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => debugPrint("News tapped: ${item.title}"),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF9FCFE),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imaginea Principala (URL)
            Container(
              height: 160,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(item.image), // Folosim NetworkImage
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: CategoryTag(text: item.category),
                  ),
                ],
              ),
            ),

            // Continut Text
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Color(0xFF191919),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  _buildNewsSourceRow(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsSourceRow(BuildContext context) {
    return InkWell(
      onTap: () => _openProfile(context),
      child: Row(
        children: [
          ClipOval( // Folosim ClipOval in loc de CircleAvatar pentru a suporta SVG
            child: SizedBox(
              width: 24, // 2 * radius (12)
              height: 24,
              child: CustomNetworkImage(imageUrl: item.publisherIcon),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.publisher,
                  style: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 13,
                  ),
                ),
                Text(
                  item.date,
                  style: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryTag extends StatelessWidget {
  final String text;
  const CategoryTag({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF4C88DF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}