// lib/presentation/pages/profile_page.dart
import 'package:flutter/material.dart';
import '../widgets/custom_network_image.dart';
import '../widgets/icon_button_scale.dart'; // Importul corect relativ la noul folder

class ProfilePage extends StatefulWidget {
  final String sourceName;
  final String? sourceImagePath;
  // Imaginea din interiorul cardului ramane asset momentan (static)
  final String cardImage = 'assets/images/cardImage_1.png';

  const ProfilePage({
    super.key,
    required this.sourceName,
    this.sourceImagePath,
  });

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String searchQuery = '';
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildProfileInfo(),
              _buildDescriptionSection(),
              _buildNewsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
              widget.sourceName,
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
            assetPath: 'assets/icons/bell.svg',
            onTap: () {
              print("Right icon tapped");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 108,
            height: 108,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: widget.sourceImagePath != null
            // MODIFICARE: Folosim NetworkImage pentru ca primim URL
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomNetworkImage(
                imageUrl: widget.sourceImagePath!,
                fit: BoxFit.cover,
              ),
            )
                : Icon(Icons.image, size: 50, color: Colors.grey.shade600),
          ),
          const SizedBox(width: 28),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatsRow(),
                const SizedBox(height: 20),
                _buildFollowButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem("6.8k", "News"),
        _buildStatItem("2.5k", "Followers"),
        _buildStatItem("100", "Following"),
      ],
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

  Widget _buildFollowButton() {
    return InkWell(
      onTap: () {
        setState(() {
          isFollowing = !isFollowing;
        });
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

  Widget _buildDescriptionSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.sourceName,
                style: const TextStyle(
                  color: Color(0xFF191919),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 9),
              const Icon(
                Icons.verified,
                color: Colors.blueAccent,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 9),
          const Text(
            "Empowering your business journey with expert insights and influential perspectives.",
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNewsSectionHeader(),
          const SizedBox(height: 24),
          _buildSearchBar(),
          const SizedBox(height: 24),
          _buildNewsCard(),
        ],
      ),
    );
  }

  Widget _buildNewsSectionHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "News by ${widget.sourceName}",
          style: const TextStyle(
            color: Color(0xFF191919),
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 9),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  "Sort by: Newest",
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.grid_view, size: 24),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.list, size: 24),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0x4DD9EEF9),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey, size: 20),
          const SizedBox(width: 20),
          Expanded(
            child: TextField(
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 18,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: "Search \"News\"",
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF9FCFE),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNewsCardHeader(),
          const SizedBox(height: 16),
          const Text(
            "Tech Startup Secures \$50 Million Funding for Expansion",
            style: TextStyle(
              color: Color(0xFF191919),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildCategoryTag(),
          const SizedBox(height: 16),
          _buildNewsImage(),
        ],
      ),
    );
  }

  Widget _buildNewsCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.account_circle, size: 30),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.sourceName,
                      style: const TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.verified,
                      color: Colors.blueAccent,
                      size: 16,
                    ),
                  ],
                ),
                const Text(
                  "Jun 11, 2023",
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert, size: 24),
        ),
      ],
    );
  }

  Widget _buildCategoryTag() {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF2ABAFF),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: const Text(
          "Business",
          style: TextStyle(
            color: Color(0xFF2ABAFF),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildNewsImage() {
    // Aici ramane asset local momentan (pentru stirea statica)
    // Daca nu ai imaginea asta in assets, schimba cu un Container colorat
    return Container(
      height: 198,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade300,
      ),
      child: Image.asset(
        widget.cardImage,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
      ),
    );
  }
}