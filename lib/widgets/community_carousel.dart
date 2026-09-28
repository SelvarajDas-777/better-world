import 'dart:async';

import 'package:flutter/material.dart';

import '../models/community_story.dart';
import '../theme/app_theme.dart';

class CommunityCarousel extends StatefulWidget {
  const CommunityCarousel({super.key});

  @override
  State<CommunityCarousel> createState() => _CommunityCarouselState();
}

class _CommunityCarouselState extends State<CommunityCarousel> {
  final PageController _pageController = PageController();

  Timer? _autoSlideTimer;

  int _currentPage = 0;

  final List<CommunityStory> _stories = const [
    CommunityStory(
      title: 'We’re better together.',
      description:
          'A helping hand can turn an ordinary moment into something meaningful.',
      emoji: '🤝',
      category: 'COMMUNITY',
    ),
    CommunityStory(
      title: 'Everyone has something to give.',
      description:
          'Your time, skills or simply your presence can make a difference.',
      emoji: '🫶',
      category: 'KINDNESS',
    ),
    CommunityStory(
      title: 'Someone might need you today.',
      description:
          'Connect with people around you and be there when it matters.',
      emoji: '💙',
      category: 'SUPPORT',
    ),
    CommunityStory(
      title: 'Small acts create big change.',
      description:
          'Together, we can build communities where people look out for one another.',
      emoji: '🌍',
      category: 'TOGETHER',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) {
        return;
      }

      final nextPage = (_currentPage + 1) % _stories.length;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.38,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // ------------------------------------------------------------
            // BACKGROUND IMAGES / VISUALS
            // ------------------------------------------------------------
            PageView.builder(
              controller: _pageController,
              itemCount: _stories.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return _BackgroundVisual(story: _stories[index], index: index);
              },
            ),

            // ------------------------------------------------------------
            // GRADIENT OVERLAY
            // ------------------------------------------------------------
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.05),
                      Colors.black.withValues(alpha: 0.15),
                      Colors.black.withValues(alpha: 0.72),
                    ],
                  ),
                ),
              ),
            ),

            // ------------------------------------------------------------
            // TEXT CONTENT
            // ------------------------------------------------------------
            Positioned(
              left: 24,
              right: 24,
              bottom: 54,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                child: Column(
                  key: ValueKey(_currentPage),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Text(
                        _stories[_currentPage].category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Title
                    Text(
                      _stories[_currentPage].title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 29,
                        height: 1.1,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Description
                    Text(
                      _stories[_currentPage].description,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ------------------------------------------------------------
            // PAGE INDICATORS
            // ------------------------------------------------------------
            Positioned(
              left: 24,
              bottom: 20,
              child: Row(
                children: List.generate(_stories.length, (index) {
                  final isActive = index == _currentPage;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(right: 6),
                    height: 5,
                    width: isActive ? 24 : 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: isActive ? 0.95 : 0.4,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }),
              ),
            ),

            // ------------------------------------------------------------
            // SWIPE HINT
            // ------------------------------------------------------------
            Positioned(
              right: 20,
              top: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.swipe_rounded, color: Colors.white, size: 15),
                    SizedBox(width: 5),
                    Text(
                      'Swipe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// BACKGROUND VISUAL
// ============================================================================

class _BackgroundVisual extends StatelessWidget {
  final CommunityStory story;
  final int index;

  const _BackgroundVisual({required this.story, required this.index});

  @override
  Widget build(BuildContext context) {
    // Your three carousel images
    final images = [
      'assets/we are better together.jpg',
      'assets/everyone has everything to give.jpg',
      'assets/someone might need you today.webp',
    ];

    // ------------------------------------------------------------
    // FIRST 3 SLIDES → USE YOUR IMAGES
    // ------------------------------------------------------------
    if (index < images.length) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(images[index], fit: BoxFit.cover),

          // Very subtle overlay.
          // The main gradient overlay above will handle
          // readability of the text.
          Container(color: Colors.black.withValues(alpha: 0.08)),
        ],
      );
    }

    // ------------------------------------------------------------
    // FOURTH SLIDE → ORIGINAL GRADIENT
    // ------------------------------------------------------------
    final gradients = [
      [AppColors.primary, AppColors.secondary],
      [AppColors.secondary, AppColors.coral],
      [AppColors.teal, AppColors.primary],
      [AppColors.coral, AppColors.secondary],
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradients[index % gradients.length],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -80,
            right: -60,
            child: _DecorativeCircle(size: 220, opacity: 0.12),
          ),

          Positioned(
            bottom: -100,
            left: -70,
            child: _DecorativeCircle(size: 250, opacity: 0.1),
          ),

          // Original emoji visual
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(story.emoji, style: const TextStyle(fontSize: 105)),
                const SizedBox(height: 8),
                Text(
                  'COMMUNITY',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.55),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3,
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

// ============================================================================
// DECORATIVE CIRCLE
// ============================================================================

class _DecorativeCircle extends StatelessWidget {
  final double size;
  final double opacity;

  const _DecorativeCircle({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }
}
