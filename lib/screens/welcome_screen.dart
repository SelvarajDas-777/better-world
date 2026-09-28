import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/community_action_network.dart';
import '../widgets/community_carousel.dart';
import '../screens/login_screen.dart';
import '../widgets/community_transition.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _showTransition = false;

  // ================================================================
  // TYPE OF COMMUNITY TRANSITION
  // ================================================================

  CommunityTransitionType? _transitionType;

  // ================================================================
  // START COMMUNITY TRANSITION
  // ================================================================

  void _startTransition(CommunityTransitionType type) {
    if (_showTransition) return;

    setState(() {
      _transitionType = type;
      _showTransition = true;
    });
  }

  // ================================================================
  // GO TO LOGIN AFTER ANIMATION
  // ================================================================

  void _openLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return const LoginScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ==========================================================
          // FIXED BACKGROUND
          // ==========================================================
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF315C4A), Color(0xFF17382D)],
              ),
            ),
          ),

          // ==========================================================
          // MAIN WELCOME CONTENT
          // ==========================================================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
              child: Column(
                children: [
                  // --------------------------------------------------
                  // HEADER
                  // --------------------------------------------------
                  _buildHeader(),

                  const SizedBox(height: 18),

                  // --------------------------------------------------
                  // CAROUSEL
                  // --------------------------------------------------
                  const CommunityCarousel(),

                  const SizedBox(height: 18),

                  // --------------------------------------------------
                  // WELCOME TEXT
                  // --------------------------------------------------
                  _buildWelcomeText(),

                  const SizedBox(height: 12),

                  // --------------------------------------------------
                  // ACTION AREA
                  // --------------------------------------------------
                  Flexible(
                    child: CommunityActionNetwork(
                      // ------------------------------------------------
                      // I NEED HELP
                      // ------------------------------------------------
                      onNeedHelp: () {
                        _startTransition(CommunityTransitionType.needHelp);
                      },

                      // ------------------------------------------------
                      // I CAN HELP
                      // ------------------------------------------------
                      onCanHelp: () {
                        _startTransition(CommunityTransitionType.canHelp);
                      },

                      // ------------------------------------------------
                      // EMERGENCY
                      // ------------------------------------------------
                      onEmergency: () {
                        _showComingSoon(context, 'Emergency');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==========================================================
          // COMMUNITY TRANSITION
          //
          // The animation is different depending on which
          // action the user selected.
          // ==========================================================
          if (_showTransition && _transitionType != null)
            CommunityTransition(type: _transitionType!, onComplete: _openLogin),
        ],
      ),
    );
  }

  // ================================================================
  // TEMPORARY MESSAGE
  // ================================================================

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature will be available soon.'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ================================================================
  // HEADER
  // ================================================================

  Widget _buildHeader() {
    return Row(
      children: [
        // ------------------------------------------------------------
        // APP ICON
        // ------------------------------------------------------------
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.people_alt_rounded,
            color: AppColors.primary,
            size: 25,
          ),
        ),

        const SizedBox(width: 12),

        // ------------------------------------------------------------
        // APP NAME
        // ------------------------------------------------------------
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Better World',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                shadows: [
                  Shadow(
                    color: Colors.black38,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2),

            Text(
              'People helping people',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        const Spacer(),

        // ------------------------------------------------------------
        // NOTIFICATION BUTTON
        // ------------------------------------------------------------
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.text,
            size: 23,
          ),
        ),
      ],
    );
  }

  // ================================================================
  // WELCOME TEXT
  // ================================================================

  Widget _buildWelcomeText() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'We’re better\nwhen we help each other.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              height: 1.08,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
              shadows: [
                Shadow(
                  color: Colors.black38,
                  blurRadius: 12,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          Text(
            'Connect. Help. Make a difference.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  color: Colors.black38,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
