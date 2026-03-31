import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../core/constants/assets.dart';
import '../../core/providers/settings_provider.dart';
import '../../shared/widgets/geometric_background.dart';
import '../../shared/widgets/primary_button.dart';
import 'permissions_page.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;
  String _selectedAudio = NafsAssets.adhanSnippet;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    final notifier = ref.read(settingsProvider.notifier);
    await notifier.completeOnboarding();
    await notifier.updateAudioPath(_selectedAudio);
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeometricBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (page) =>
                      setState(() => _currentPage = page),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _PhilosophyPage(),
                    PermissionsPage(onAllGranted: _nextPage),
                    _AudioPreferencePage(
                      selectedAudio: _selectedAudio,
                      onChanged: (audio) =>
                          setState(() => _selectedAudio = audio),
                    ),
                  ],
                ),
              ),
              _buildBottomSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? NafsColors.accentGold
                      : NafsColors.ashMuted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          if (_currentPage != 1)
            PrimaryButton(
              label: _currentPage == 2 ? 'Begin Your Journey' : 'Continue',
              onPressed: _nextPage,
              width: double.infinity,
            ),
        ],
      ),
    );
  }
}

class _PhilosophyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: CustomPaint(painter: _UnfoldingStarPainter()),
          )
              .animate()
              .scale(
                begin: const Offset(0.3, 0.3),
                end: const Offset(1, 1),
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
              )
              .fadeIn(duration: const Duration(milliseconds: 600)),
          const SizedBox(height: 40),
          Text(
            'Guard Your Nafs',
            style: NafsTextStyles.displayLarge,
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: const Duration(milliseconds: 300))
              .slideY(begin: 0.2, end: 0),
          const SizedBox(height: 16),
          Text(
            'Time is Amanah — a sacred trust.\nNafsGuard turns your screen habit\ninto a doorway for Barakah.',
            style: NafsTextStyles.bodyLarge.copyWith(
              color: NafsColors.ashMuted,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: const Duration(milliseconds: 600))
              .slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }
}

class _UnfoldingStarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = NafsColors.accentGold;

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = NafsColors.accentGold.withValues(alpha: 0.1);

    final path = Path();
    for (int i = 0; i < 8; i++) {
      final outerAngle = (i * pi / 4) - pi / 2;
      final innerAngle = outerAngle + pi / 8;
      final ox = center.dx + radius * cos(outerAngle);
      final oy = center.dy + radius * sin(outerAngle);
      final ix = center.dx + (radius * 0.4) * cos(innerAngle);
      final iy = center.dy + (radius * 0.4) * sin(innerAngle);
      if (i == 0) {
        path.moveTo(ox, oy);
      } else {
        path.lineTo(ox, oy);
      }
      path.lineTo(ix, iy);
    }
    path.close();
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AudioPreferencePage extends StatelessWidget {
  final String selectedAudio;
  final ValueChanged<String> onChanged;

  const _AudioPreferencePage({
    required this.selectedAudio,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final options = [
      (NafsAssets.adhanSnippet, 'Adhan Snippet', 'A gentle call to prayer'),
      (
        NafsAssets.dhikrSubhanallah,
        'Dhikr Audio',
        'SubhanAllah remembrance'
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choose Your Reminder',
            style: NafsTextStyles.displayMedium,
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn()
              .slideY(begin: 0.2, end: 0),
          const SizedBox(height: 8),
          Text(
            'What sound will call you back?',
            style: NafsTextStyles.bodyLarge.copyWith(
              color: NafsColors.ashMuted,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ...options.map((option) {
            final isSelected = selectedAudio == option.$1;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => onChanged(option.$1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? NafsColors.accentGold.withValues(alpha: 0.15)
                        : NafsColors.cardSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? NafsColors.accentGold
                          : NafsColors.accentGold.withValues(alpha: 0.1),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? NafsColors.accentGold
                                : NafsColors.ashMuted,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Center(
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: NafsColors.accentGold,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(option.$2,
                                style: NafsTextStyles.labelLarge),
                            const SizedBox(height: 2),
                            Text(option.$3,
                                style: NafsTextStyles.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
