// lib/widgets/trending_news_section.dart
import 'package:flutter/material.dart';
import '../models/news_item.dart';
import '../pages/profile_page.dart';

class TrendingNewsSection extends StatelessWidget {
  final List<NewsItem> items;
  final VoidCallback? onSeeAll;

  const TrendingNewsSection({
    Key? key,
    required this.items,
    this.onSeeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // card width — poți schimba sau calcula din MediaQuery pentru responsivitate
    final double cardWidth = MediaQuery.of(context).size.width * 0.78;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
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

        // Horizontal list (carousel)
        SizedBox(
          height: 260, // înălțime suficientă pentru card (image + text)
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 0, right: 8),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            physics: const PageScrollPhysics(),
            itemBuilder: (context, index) {
              final item = items[index];
              return SizedBox(
                width: cardWidth,
                child: NewsCard(
                  item: item,
                  onTap: () => debugPrint('Tapped: ${item.title}'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsItem item;
  final VoidCallback? onTap;

  const NewsCard({Key? key, required this.item, this.onTap}) : super(key: key);

  void _openProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ProfilePage(
              sourceName: item.source,
              sourceImagePath: item.sourceImageProfilePath
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => debugPrint("News tapped: ${item.title}"),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF9FCFE),
        ),
        // IMPORTANT: lăsăm cardul să ocupe toată înălțimea disponibilă în SizedBox părinte
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imaginea ocupă o porțiune flexibilă
            Expanded(
              flex: 6,
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(item.imagePath),
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
            ),

            // Partea de text ocupă restul spațiului
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Cheia!
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
                    _buildNewsSourceRow(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsSourceRow(BuildContext context) {
    final String? img = item.sourceImageProfilePath;
    final bool hasImage = img != null && img.isNotEmpty;

    Widget profileImageWidget() {
      // fallback widget (inițiala)
      Widget fallback = Container(
        color: Colors.grey.shade300,
        alignment: Alignment.center,
        child: Text(
          item.source.isNotEmpty ? item.source[0].toUpperCase() : '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      );

      if (!hasImage) return fallback;

      // dacă string-ul pare a fi un URL, folosește network, altfel asset
      final bool isNetwork = img.toLowerCase().startsWith('http');

      return ClipOval(
        child: SizedBox(
          width: 24,
          height: 24,
          child: isNetwork
              ? Image.network(
            img,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => fallback,
          )
              : Image.asset(
            img,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => fallback,
          ),
        ),
      );
    }

    return InkWell(
      onTap: () => _openProfile(context),
      borderRadius: BorderRadius.circular(16),
      child: Row(
        children: [
          // folosim ClipOval + SizedBox pentru a tăia corect imaginea
          profileImageWidget(),
          const SizedBox(width: 8),
          // source + date (spațiu între ele)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      item.source,
                      style: const TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified,
                      color: Colors.blueAccent,
                      size: 16,
                    ),
                  ],
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
