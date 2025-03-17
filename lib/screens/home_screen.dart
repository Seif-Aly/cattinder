import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/api_service.dart';
import '../models/cat.dart';
import '../widgets/like_button.dart';
import '../widgets/dislike_button.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Cat? currentCat;
  int likesCount = 0;

  @override
  void initState() {
    super.initState();
    fetchNewCat();
  }

  Future<void> fetchNewCat() async {
    final newCat = await ApiService.fetchRandomCat();
    setState(() {
      currentCat = newCat;
    });
  }

  void onLike() {
    setState(() {
      likesCount++;
    });
    fetchNewCat();
  }

  void onDislike() {
    fetchNewCat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.greenAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child:
              currentCat == null
                  ? const Center(child: CircularProgressIndicator())
                  : GestureDetector(
                    onPanStart: (details) {},
                    onPanEnd: (details) {
                      final dx = details.velocity.pixelsPerSecond.dx;
                      if (dx > 0) {
                        onLike();
                      } else if (dx < 0) {
                        onDislike();
                      }
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Cat Tinder',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Likes: $likesCount',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Main content area
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Hero(
                                  tag: 'catImage${currentCat!.id}',
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => DetailScreen(
                                                cat: currentCat!,
                                              ),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: CachedNetworkImage(
                                        imageUrl: currentCat!.imageUrl,
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.8,
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.4,
                                        fit: BoxFit.cover,
                                        placeholder:
                                            (context, url) => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        errorWidget:
                                            (context, url, error) =>
                                                const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  currentCat!.breedName,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Like / Dislike row
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DislikeButton(onDislike: onDislike),
                              LikeButton(onLike: onLike),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}
