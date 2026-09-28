import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CommunityActionNetwork extends StatelessWidget {
  final VoidCallback onNeedHelp;
  final VoidCallback onCanHelp;
  final VoidCallback onEmergency;

  const CommunityActionNetwork({
    super.key,
    required this.onNeedHelp,
    required this.onCanHelp,
    required this.onEmergency,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ----------------------------------------------------------
          // COMMUNITY - CENTRAL VISUAL NODE
          // ----------------------------------------------------------
          Positioned(top: 0, child: _CommunityNode()),

          // ----------------------------------------------------------
          // NEED HELP
          // ----------------------------------------------------------
          Positioned(
            left: 15,
            top: 85,
            child: _ActionNode(
              icon: Icons.volunteer_activism_rounded,
              label: 'Need Help',
              color: AppColors.primary,
              onTap: onNeedHelp,
            ),
          ),

          // ----------------------------------------------------------
          // I CAN HELP
          // ----------------------------------------------------------
          Positioned(
            right: 15,
            top: 85,
            child: _ActionNode(
              icon: Icons.handshake_rounded,
              label: 'I Can Help',
              color: AppColors.teal,
              onTap: onCanHelp,
            ),
          ),

          // ----------------------------------------------------------
          // EMERGENCY
          // ----------------------------------------------------------
          Positioned(
            bottom: 0,
            child: _ActionNode(
              icon: Icons.emergency_rounded,
              label: 'Emergency',
              color: AppColors.emergency,
              onTap: onEmergency,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// COMMUNITY NODE
// =====================================================================

class _CommunityNode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.92),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.8),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 20,
                spreadRadius: 3,
              ),
            ],
          ),
          child: const Icon(
            Icons.people_alt_rounded,
            color: AppColors.primary,
            size: 34,
          ),
        ),

        const SizedBox(height: 7),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Community',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// ACTION NODE
// =====================================================================

class _ActionNode extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionNode({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_ActionNode> createState() => _ActionNodeState();
}

class _ActionNodeState extends State<_ActionNode> {
  bool _pressed = false;

  // ------------------------------------------------------------
  // TAP START
  // ------------------------------------------------------------

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _pressed = true;
    });
  }

  // ------------------------------------------------------------
  // TAP RELEASE
  // ------------------------------------------------------------

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _pressed = false;
    });

    widget.onTap();
  }

  // ------------------------------------------------------------
  // TAP CANCEL
  // ------------------------------------------------------------

  void _handleTapCancel() {
    setState(() {
      _pressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,

      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 120),

        child: SizedBox(
          width: 105,

          child: Column(
            children: [
              // ------------------------------------------------------
              // ACTION ICON
              // ------------------------------------------------------
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: Colors.white.withValues(alpha: 0.88),

                  border: Border.all(
                    color: widget.color.withValues(alpha: 0.75),
                    width: 2,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.25),
                      blurRadius: 18,
                      spreadRadius: 2,
                    ),
                  ],
                ),

                child: Icon(widget.icon, color: widget.color, size: 29),
              ),

              const SizedBox(height: 7),

              // ------------------------------------------------------
              // ACTION LABEL
              // ------------------------------------------------------
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),

                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.28),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  widget.label,
                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
