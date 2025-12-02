import 'package:flutter/material.dart';
import 'package:news_app/widgets/icon_button_scale.dart';
import 'package:news_app/widgets/recomandation_section.dart';
import 'models/news_item.dart';
import 'models/recomandation_item.dart';
import 'widgets/trending_news_section.dart';
import 'widgets/recommendation_card.dart';
import 'pages/profile_page.dart';

class Home extends StatefulWidget {
	const Home({super.key});

	@override
	HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: const Color(0xFFFFFFFF),
			body: SafeArea(
				child: SingleChildScrollView(
					padding: const EdgeInsets.symmetric(horizontal: 18),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							const SizedBox(height: 24),
							_buildHeader(),
							const SizedBox(height: 24),
							_buildWelcomeSection(),
							const SizedBox(height: 24),
							_buildTrendingNewsSection(),
							const SizedBox(height: 32),
							_buildRecommendationSection(),
							const SizedBox(height: 24),
						],
					),
				),
			),
		);
	}

	Widget _buildHeader() {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: [
				// Butonul stânga — imagine locală (ex: back)
				IconButtonScale(
					assetPath: 'assets/icons/menu.svg',
					onTap: () {
						print("Left icon tapped");
					},
				),

				// Textul din mijloc
				const Text(
					"Profil",
					style: TextStyle(
						color: Color(0xFF191919),
						fontSize: 22,
						fontWeight: FontWeight.bold,
					),
				),

				// Butonul dreapta — imagine locală (ex: notificare)
				IconButtonScale(
					assetPath: 'assets/icons/bell.svg',
					onTap: () {
						print("Right icon tapped");
					},
				),
			],
		);
	}

	Widget _buildHeaderIcon(String url) {
		return Container(
			width: 52,
			height: 52,
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(8),
			),
			child: Image.network(
				url,
				fit: BoxFit.cover,
				errorBuilder: (context, error, stackTrace) {
					return Container(
						width: 52,
						height: 52,
						decoration: BoxDecoration(
							color: Colors.grey[300],
							borderRadius: BorderRadius.circular(8),
						),
					);
				},
			),
		);
	}

	Widget _buildWelcomeSection() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Welcome back, Stici Pavel!",
					style: TextStyle(
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

	Widget _buildTrendingNewsSection() {
		final items = [
			NewsItem(
				imagePath: 'assets/images/TrendingNewsImage_1.jpg',
				category: 'Environment',
				title: 'Global Summit on Climate Change: Historic Agreement Reached',
				sourceImageProfilePath: 'assets/images/ProfilePic_1.png',
				source: 'BBC News',
				date: 'Jun 9, 2023',
			),
			NewsItem(
				imagePath: 'assets/images/TrendingNewsImage_2.jpg',
				category: 'Technology',
				title: 'Tech Giant Unveils Revolutionary AI-powered Device',
				sourceImageProfilePath: 'assets/images/ProfilePic_2.png',
				source: 'The NYT',
				date: 'Jun 10, 2023',
			),
			NewsItem(
				imagePath: 'assets/images/TrendingNewsImage_1.jpg',
				category: 'Environment',
				title: 'Global Summit on Climate Change: Historic Agreement Reached',
				sourceImageProfilePath: 'assets/images/ProfilePic_1.png',
				source: 'BBC News',
				date: 'Jun 9, 2023',
			),
			NewsItem(
				imagePath: 'assets/images/TrendingNewsImage_2.jpg',
				category: 'Technology',
				title: 'Tech Giant Unveils Revolutionary AI-powered Device',
				sourceImageProfilePath: 'assets/images/ProfilePic_2.png',
				source: 'The NYT',
				date: 'Jun 10, 2023',
			),
		];

		return TrendingNewsSection(
			items: items,
			onSeeAll: () => print('See all pressed'),
		);
	}

	//deprecated
	Widget _buildTrendingNewsSection_old() {
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
							onTap: () => print('See all pressed'),
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
				_buildTrendingNewsCard(),
			],
		);
	}

	Widget _buildTrendingNewsCard() {
		return Container(
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(10),
				color: const Color(0xFFF9FCFE),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// Image with category tag
					Container(
						height: 160,
						margin: const EdgeInsets.all(8),
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(8),
							image: const DecorationImage(
								image: NetworkImage(
										"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/fLkPA1dKLS/qx1klroc_expires_30_days.png"
								),
								fit: BoxFit.cover,
							),
						),
						child: Stack(
							children: [
								Positioned(
									top: 10,
									left: 10,
									child: _buildCategoryTag("Environment"),
								),
							],
						),
					),
					// News content
					Padding(
						padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								const Text(
									"Global Summit on Climate Change: Historic Agreement Reached",
									style: TextStyle(
										color: Color(0xFF191919),
										fontSize: 18,
										fontWeight: FontWeight.bold,
										height: 1.3,
									),
									maxLines: 3,
									overflow: TextOverflow.ellipsis,
								),
								const SizedBox(height: 12),
								_buildNewsSource(),
							],
						),
					),
				],
			),
		);
	}

	Widget _buildCategoryTag(String category) {
		return InkWell(
			onTap: () => print('$category pressed'),
			child: Container(
				decoration: BoxDecoration(
					borderRadius: BorderRadius.circular(5),
					color: const Color(0xFF2ABAFF),
				),
				padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
				child: Text(
					category,
					style: const TextStyle(
						color: Color(0xFFFFFFFF),
						fontSize: 12,
						fontWeight: FontWeight.bold,
					),
				),
			),
		);
	}

	Widget _buildNewsSource() {
		return Row(
			children: [
				Container(
					width: 24,
					height: 24,
					margin: const EdgeInsets.only(right: 8),
					child: Image.network(
						"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/fLkPA1dKLS/79qrd1di_expires_30_days.png",
						fit: BoxFit.cover,
						errorBuilder: (context, error, stackTrace) {
							return Container(
								width: 24,
								height: 24,
								decoration: const BoxDecoration(
									color: Colors.grey,
									shape: BoxShape.circle,
								),
							);
						},
					),
				),
				const Text(
					"BBC News",
					style: TextStyle(
						color: Color(0xFF999999),
						fontSize: 16,
					),
				),
				const SizedBox(width: 8),
				Container(
					width: 16,
					height: 16,
					margin: const EdgeInsets.symmetric(horizontal: 8),
					child: Image.network(
						"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/fLkPA1dKLS/z6ktqiut_expires_30_days.png",
						fit: BoxFit.cover,
					),
				),
				const Expanded(
					child: Text(
						"Jun 9, 2023",
						style: TextStyle(
							color: Color(0xFF999999),
							fontSize: 16,
						),
					),
				),
			],
		);
	}
	//deprecated

	Widget _buildRecommendationSection() {
		final items = [
			RecommendationItem(
				profileImagePath: 'assets/images/ProfilePic_3.png',
				sourceName: 'Forbes',
				date: 'Jun 11, 2023',
				title: 'Tech Startup Secures \$50 Million Funding for Expansion',
				cardImagePath: 'assets/images/cardImage_1.png',
				onFollow: () => print('Follow Forbes'),
			),
			RecommendationItem(
				profileImagePath: 'assets/images/ProfilePic_4.png',
				sourceName: 'ESPN',
				date: 'Jun 10, 2023',
				title: 'Star Athlete Breaks World Record in Olympic Event',
				cardImagePath: 'assets/images/cardImage_2.png',
				onFollow: () => print('Follow ESPN'),
			),
		];

		return RecommendationSection(
			items: items,
			onSeeAll: () => print('See all recommendations'),
		);
	}

	Widget _buildRecommendationCard_old() {
		return Container(
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(10),
				color: const Color(0xFFF9FCFE),
			),
			padding: const EdgeInsets.all(16),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// Header with source info and follow button
					Row(
						children: [
							Container(
								width: 36,
								height: 36,
								margin: const EdgeInsets.only(right: 12),
								child: ClipRRect(
									borderRadius: BorderRadius.circular(18),
									child: Image.network(
										"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/fLkPA1dKLS/p20k1gvn_expires_30_days.png",
										fit: BoxFit.cover,
										errorBuilder: (context, error, stackTrace) {
											return Container(
												color: Colors.grey[300],
											);
										},
									),
								),
							),
							Expanded(
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Row(
											children: [
												const Text(
													"Forbes",
													style: TextStyle(
														color: Color(0xFF999999),
														fontSize: 18,
													),
												),
												const SizedBox(width: 8),
												Container(
													width: 18,
													height: 18,
													child: Image.network(
														"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/fLkPA1dKLS/trms4kt7_expires_30_days.png",
														fit: BoxFit.cover,
													),
												),
											],
										),
										const Text(
											"Jun 11, 2023",
											style: TextStyle(
												color: Color(0xFF999999),
												fontSize: 16,
											),
										),
									],
								),
							),
							InkWell(
								onTap: () => print('Follow pressed'),
								child: Container(
									decoration: BoxDecoration(
										borderRadius: BorderRadius.circular(7),
										color: const Color(0x12121214),
									),
									padding: const EdgeInsets.symmetric(
										horizontal: 23,
										vertical: 9,
									),
									margin: const EdgeInsets.only(right: 14),
									child: const Text(
										"Follow",
										style: TextStyle(
											color: Color(0xFF121214),
											fontSize: 16,
										),
									),
								),
							),
							Container(
								width: 24,
								height: 24,
								child: Image.network(
									"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/fLkPA1dKLS/779a7rkm_expires_30_days.png",
									fit: BoxFit.cover,
								),
							),
						],
					),
					const SizedBox(height: 16),
					// Article title
					const Text(
						"Tech Startup Secures \$50 Million Funding for Expansion",
						style: TextStyle(
							color: Color(0xFF191919),
							fontSize: 20,
							fontWeight: FontWeight.bold,
							height: 1.3,
						),
					),
					const SizedBox(height: 16),
					// Category tag
					InkWell(
						onTap: () => print('Business category pressed'),
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
					),
					const SizedBox(height: 16),
					// Article image
					Container(
						height: 198,
						width: double.infinity,
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(8),
							image: const DecorationImage(
								image: NetworkImage(
										"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/fLkPA1dKLS/tqlzpg39_expires_30_days.png"
								),
								fit: BoxFit.cover,
							),
						),
					),
				],
			),
		);
	}
}