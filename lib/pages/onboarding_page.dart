import 'package:flutter/material.dart';
import 'package:my_flutter_clone_app/core/constants/app_assets.dart';

import 'package:my_flutter_clone_app/core/theme/app_colors.dart';
import 'package:my_flutter_clone_app/core/theme/app_spacing.dart';
import 'package:my_flutter_clone_app/core/theme/app_text_styles.dart';
import 'package:my_flutter_clone_app/pages/login_page.dart';

/// Halaman onboarding sesudah splash. Kalau nanti mau lebih dari satu
/// slide (Treasury aslinya punya 3 dot indicator), ganti body jadi
/// PageView dan `_OnboardingContent` jadi salah satu page-nya.

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingSlideData {
  const _OnboardingSlideData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  int _activeIndex = 0;

  static const _slides = <_OnboardingSlideData>[
    _OnboardingSlideData(
      icon: Icons.savings_outlined,
      title: 'Emas untuk masa depan',
      subtitle: 'Cara mudah investasi emas. Kapanpun, dimanapun kamu mau.',
    ),
    _OnboardingSlideData(
      icon: Icons.security_outlined,
      title: 'Aman dan terpercaya',
      subtitle: 'Berizin resmi dan diawasi otoritas terkait.',
    ),
    _OnboardingSlideData(
      icon: Icons.trending_up_outlined,
      title: 'Mulai dari nominal kecil',
      subtitle: 'Investasi emas mulai dari Rp10 ribu saja.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Column(
        children: [
          const _OnboardingHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _slides.length,
                      onPageChanged: (index) =>
                          setState(() => _activeIndex = index),
                      itemBuilder: (context, index) =>
                          _OnboardingSlide(data: _slides[index]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSpacing.xl),
                        _DotIndicator(
                          count: _slides.length,
                          activeIndex: _activeIndex,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _goToLogin,
                            child: Text('Masuk atau Daftar'),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        // Tombol skip langsung ke login tanpa habiskan slide.
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingHeader extends StatelessWidget {
  const _OnboardingHeader();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.lg,
        ),
        child: Row(
          children: [
            Image.asset(
              AppAssets.logoAppWhite,
              height: 24,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            OutlinedButton.icon(
              onPressed: () {
                // TODO: buka pemilihan bahasa
              },
              icon: const Icon(Icons.language, size: 18),
              label: const Text('ID'),
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textPrimary,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({required this.data});

  final _OnboardingSlideData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xl),
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 260, maxHeight: 340),
                alignment: Alignment.center,
                child: Icon(data.icon, size: 160, color: AppColors.primary),
              ),
            ),
          ),
          Text(data.title, style: AppTextStyles.heading.copyWith(fontSize: 24)),
          const SizedBox(height: AppSpacing.sm),
          Text(
            data.subtitle,
            style: AppTextStyles.body.copyWith(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.count, required this.activeIndex});

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < count; i++) ...[
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              decoration: BoxDecoration(
                color: i == activeIndex
                    ? AppColors.textPrimary
                    : AppColors.divider,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
          ),
          if (i != count - 1) const SizedBox(width: AppSpacing.xs),
        ],
      ],
    );
  }
}