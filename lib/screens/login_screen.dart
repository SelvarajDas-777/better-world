import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF06172E), Color(0xFF082C48), Color(0xFF063B55)],
          ),
        ),
        child: Stack(
          children: [
            // Subtle community network in the background
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _LoginNetworkPainter(
                      animationValue: _animationController.value,
                    ),
                  );
                },
              ),
            ),

            // Main content
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 30,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 430),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 25),

                        // Brand
                        _buildBrand(),

                        const SizedBox(height: 38),

                        // Login card
                        _buildLoginCard(),

                        const SizedBox(height: 24),

                        // Privacy message
                        _buildPrivacyMessage(),

                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrand() {
    return Column(
      children: [
        // Small glowing community symbol
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF35D9E8), Color(0xFF1596C4)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF35D9E8).withOpacity(0.28),
                blurRadius: 28,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.diversity_3_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'BETTER WORLD',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.2,
          ),
        ),

        const SizedBox(height: 9),

        Text(
          'Welcome to the community',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.78),
            fontSize: 15.5,
            letterSpacing: 0.3,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          'Connect. Help. Make a difference.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF75DCE7).withOpacity(0.9),
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.075),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 35,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            'Enter your details to continue',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.58),
              fontSize: 13.5,
            ),
          ),

          const SizedBox(height: 25),

          // Email / phone
          _buildInputField(
            controller: _emailController,
            hintText: 'Email or phone number',
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 14),

          // Password
          _buildInputField(
            controller: _passwordController,
            hintText: 'Password',
            icon: Icons.lock_outline_rounded,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.white.withOpacity(0.55),
                size: 20,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Forgot password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Firebase functionality will be added later.
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              ),
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  color: Color(0xFF72DCE7),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Login button
          SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                // Real login will be connected later.
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF20B8D2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              child: const Text(
                'CONTINUE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(child: Divider(color: Colors.white.withOpacity(0.12))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'or',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.45),
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.white.withOpacity(0.12))),
            ],
          ),

          const SizedBox(height: 20),

          // Google placeholder
          SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                // Google authentication will be added later.
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white.withOpacity(0.15)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 23,
                    height: 23,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'G',
                      style: TextStyle(
                        color: Color(0xFF4285F4),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Continue with Google',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          // Create account
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('New here? ', style: TextStyle(color: Colors.white70)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                child: const Text('Create an account'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      cursorColor: const Color(0xFF4DD8E6),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.42),
          fontSize: 14,
        ),
        prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.55), size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withOpacity(0.055),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.09)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.09)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF35D9E8), width: 1.2),
        ),
      ),
    );
  }

  Widget _buildPrivacyMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock_outline_rounded,
          size: 14,
          color: Colors.white.withOpacity(0.42),
        ),
        const SizedBox(width: 6),
        Text(
          'Your privacy matters',
          style: TextStyle(
            color: Colors.white.withOpacity(0.42),
            fontSize: 11.5,
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------
// Background community network
// ------------------------------------------------------------

class _LoginNetworkPainter extends CustomPainter {
  final double animationValue;

  _LoginNetworkPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.28);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final nodePaint = Paint()..style = PaintingStyle.fill;

    // Slowly moving glow
    final pulse = (math.sin(animationValue * math.pi * 2) + 1) / 2;

    // Keep the network very subtle.
    final networkColor = const Color(
      0xFF2BD3E2,
    ).withOpacity(0.10 + pulse * 0.04);

    paint.color = networkColor;

    // Main branches
    final nodes = <Offset>[
      center.translate(-90, 70),
      center.translate(90, 70),
      center.translate(-145, 145),
      center.translate(145, 145),
      center.translate(-55, 170),
      center.translate(55, 170),
      center.translate(0, 115),
    ];

    for (final node in nodes) {
      canvas.drawLine(center, node, paint);
    }

    // Secondary connections
    canvas.drawLine(nodes[0], nodes[2], paint);
    canvas.drawLine(nodes[0], nodes[4], paint);
    canvas.drawLine(nodes[1], nodes[3], paint);
    canvas.drawLine(nodes[1], nodes[5], paint);
    canvas.drawLine(nodes[4], nodes[6], paint);
    canvas.drawLine(nodes[5], nodes[6], paint);

    // Nodes
    nodePaint.color = const Color(0xFF35D9E8).withOpacity(0.22 + pulse * 0.08);

    canvas.drawCircle(center, 5.5, nodePaint);

    for (final node in nodes) {
      canvas.drawCircle(node, 3.5, nodePaint);
    }

    // Small floating particles
    final particles = [
      Offset(size.width * 0.16, size.height * 0.18),
      Offset(size.width * 0.82, size.height * 0.16),
      Offset(size.width * 0.10, size.height * 0.42),
      Offset(size.width * 0.90, size.height * 0.40),
      Offset(size.width * 0.25, size.height * 0.55),
      Offset(size.width * 0.76, size.height * 0.52),
    ];

    for (int i = 0; i < particles.length; i++) {
      final particlePulse =
          (math.sin(animationValue * math.pi * 2 + i * 0.9) + 1) / 2;

      nodePaint.color = const Color(
        0xFF65E5EF,
      ).withOpacity(0.10 + particlePulse * 0.12);

      canvas.drawCircle(particles[i], 1.5 + particlePulse, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _LoginNetworkPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
