import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Column(
        children: [
          const SafeArea(bottom: false, child: SizedBox(height: AppSpacing.md)),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                child: Column(
                  children: [
                    const _ProfileAvatar(),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      // TODO: ganti dengan nama user dari state/API.
                      'Miraz Dwi Noviansyah',
                      style: AppTextStyles.heading.copyWith(fontSize: 22),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const _ProfileCompletionCard(percentage: 0.23),
                    const SizedBox(height: AppSpacing.lg),
                    const _InviteFriendCard(
                      referralCode: 'trs-180568464ee54d1',
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _ProfileMenuItem(
                      icon: Icons.person_outline,
                      title: 'Informasi Pribadi',
                      onTap: () {},
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _ProfileMenuItem(
                      icon: Icons.crop_free,
                      title: 'Verifikasi Identitas',
                      trailingText: 'Unverified',
                      trailingTextColor: AppColors.error,
                      onTap: () {},
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _ProfileMenuItem(
                      icon: Icons.volunteer_activism_outlined,
                      title: 'Gold For Good',
                      onTap: () {},
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'General',
                        style: AppTextStyles.subheading.copyWith(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _ProfileMenuItem(
                      icon: Icons.help_outline,
                      title: 'Bantuan',
                      onTap: () {},
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _ProfileMenuItem(
                      icon: Icons.settings,
                      title: 'Pengaturan',
                      onTap: () {},
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _ProfileMenuItem(
                      icon: Icons.newspaper,
                      title: 'Legal',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              size: 56,
              color: AppColors.textPrimary,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: AppColors.dark,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, size: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCompletionCard extends StatelessWidget {
  const _ProfileCompletionCard({required this.percentage});

  /// 0.0 - 1.0
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: percentage,
                  strokeWidth: 5,
                  backgroundColor: AppColors.divider,
                  valueColor: const AlwaysStoppedAnimation(AppColors.success),
                ),
                Text(
                  '${(percentage * 100).round()}%',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text('Kelengkapan profil',
              style: AppTextStyles.subheading.copyWith(fontSize: 16)),
        ],
      ),
    );
  }
}

class _InviteFriendCard extends StatelessWidget {
  const _InviteFriendCard({required this.referralCode});

  final String referralCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Stack(
        children: [
          // Dekorasi lingkaran pojok kanan, senada dengan splash screen.
          Positioned(
            right: -40,
            top: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Undang teman, dapat hadiah',
                            style: AppTextStyles.subheading.copyWith(
                              fontSize: 17,
                              color: AppColors.textOnDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Dapatkan koin & hadiah spesial',
                            style: AppTextStyles.body.copyWith(
                              fontSize: 14,
                              color: AppColors.textOnDark.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_forward,
                          size: 20, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF6D2),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        referralCode,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: referralCode));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Kode disalin')),
                          );
                        },
                        child: const Icon(Icons.copy_outlined,
                            size: 16, color: AppColors.textPrimary),
                      ),
                    ],
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

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    this.trailingText,
    this.trailingTextColor,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? trailingText;
  final Color? trailingTextColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Icon(icon, size: 22, color: AppColors.textPrimary),
              const SizedBox(width: AppSpacing.sm + 2),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.subheading.copyWith(fontSize: 16),
                ),
              ),
              if (trailingText != null) ...[
                Text(
                  trailingText!,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 14,
                    color: trailingTextColor ?? AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              const Icon(Icons.arrow_forward,
                  size: 18, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}