import 'package:flutter/material.dart';
import 'package:my_flutter_clone_app/core/constants/app_assets.dart';

import 'package:my_flutter_clone_app/core/theme/app_colors.dart';
import 'package:my_flutter_clone_app/core/theme/app_spacing.dart';
import 'package:my_flutter_clone_app/core/theme/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _HomeHeader(),

            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      bottom: AppSpacing.xl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: AppSpacing.lg,
                        ),

                        _TotalAsset(
                          isVisible: _isBalanceVisible,
                          onToggle: () {
                            setState(() {
                              _isBalanceVisible =
                              !_isBalanceVisible;
                            });
                          },
                        ),

                        const SizedBox(
                          height: AppSpacing.lg,
                        ),

                        const _QuickActions(),

                        const SizedBox(
                          height: AppSpacing.lg,
                        ),

                        const _PromoBanners(),

                        const SizedBox(
                          height: AppSpacing.xl,
                        ),

                        const _GoldPrice(),

                        const SizedBox(
                          height: AppSpacing.xl,
                        ),

                        const _OtherFeatures(),

                        const SizedBox(
                          height: AppSpacing.xl,
                        ),

                        const _EventPromo(),

                        const SizedBox(
                          height: AppSpacing.xl,
                        ),

                        const _LatestNews(),
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
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
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
          const _CircleIconButton(icon: Icons.receipt_long_outlined),
          const SizedBox(width: AppSpacing.sm),
          const _CircleIconButton(icon: Icons.notifications_none),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Icon(icon, size: 22, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _TotalAsset extends StatelessWidget {
  const _TotalAsset({required this.isVisible, required this.onToggle});

  final bool isVisible;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Aset Kamu', style: AppTextStyles.body.copyWith(
            fontSize: 16,
            color: AppColors.textSecondary,
          )),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Text(
                isVisible ? 'Rp 0 - 0 Gram' : '**************',
                style: AppTextStyles.heading.copyWith(fontSize: 22),
              ),
              const SizedBox(width: AppSpacing.sm),
              GestureDetector(
                onTap: onToggle,
                child: Icon(
                  isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              if (isVisible) ...[
                const Icon(
                  Icons.arrow_circle_up_outlined,
                  size: 18,
                  color: AppColors.success,
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(
                isVisible ? 'Rp 0 (0,0%)' : '**************',
                style: AppTextStyles.body.copyWith(
                  fontSize: 15,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: const [
          _QuickActionChip(
            icon: Icons.account_balance_wallet,
            iconBackground: AppColors.dark,
            iconColor: AppColors.textOnDark,
            label: 'Celengan',
            value: 'Isi Ulang',
          ),
          SizedBox(width: AppSpacing.sm),
          _QuickActionChip(
            icon: Icons.card_giftcard,
            iconBackground: AppColors.primary,
            iconColor: AppColors.textPrimary,
            label: 'Rewards',
            value: '0 Koin',
          ),
        ],
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: AppTextStyles.caption.copyWith(fontSize: 13)),
              Text(value, style: AppTextStyles.subheading.copyWith(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}

class _PromoBanners extends StatelessWidget {
  const _PromoBanners();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        children: const [
          _PromoCard(
            title: 'Verifikasi identitas kamu',
            subtitle: 'Untuk membuka semua fitur',
            background: Color(0xFFFDF6D2),
          ),
          SizedBox(width: AppSpacing.sm),
          _PromoCard(
            title: 'Verifikasi rekening',
            subtitle: 'Demi keamanan transaksi',
            background: AppColors.background,
            bordered: true,
          ),
        ],
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard({
    required this.title,
    required this.subtitle,
    required this.background,
    this.bordered = false,
  });

  final String title;
  final String subtitle;
  final Color background;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: bordered
            ? Border.all(color: AppColors.divider)
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: AppTextStyles.subheading.copyWith(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    const Icon(Icons.arrow_forward,
                        size: 16, color: AppColors.textSecondary),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: AppColors.divider),
            ),
            child: const Icon(Icons.badge_outlined,
                color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _GoldPrice extends StatelessWidget {
  const _GoldPrice();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Harga Emas', style: AppTextStyles.subheading.copyWith(fontSize: 19)),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3F3F3F),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.layers,
                      size: 20, color: AppColors.primary),
                ),
                const SizedBox(width: AppSpacing.sm + 2),
                Text('Emas', style: AppTextStyles.subheading.copyWith(fontSize: 17)),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Rp 2.509.281',
                      style: AppTextStyles.subheading.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.arrow_circle_down_outlined,
                            size: 16, color: AppColors.error),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          '(-0,06%)',
                          style: AppTextStyles.body.copyWith(
                            fontSize: 14,
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Beli'),
          ),
        ],
      ),
    );
  }
}

class _OtherFeatures extends StatelessWidget {
  const _OtherFeatures();

  static const _items = <({IconData icon, String label})>[
    (icon: Icons.swap_horiz, label: 'Transfer'),
    (icon: Icons.layers_outlined, label: 'Cetak'),
    (icon: Icons.savings_outlined, label: 'Panen'),
    (icon: Icons.account_balance_wallet_outlined, label: 'Jamimas'),
    (icon: Icons.upload_outlined, label: 'Buyback'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Fitur Lainnya',
            style: AppTextStyles.subheading.copyWith(fontSize: 19),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final item in _items)
                _FeatureItem(icon: item.icon, label: item.label),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFFEF8DC),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 1.5),
          ),
          child: Icon(icon, size: 24, color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(label, style: AppTextStyles.body.copyWith(fontSize: 13)),
      ],
    );
  }
}

class _EventPromo extends StatelessWidget {
  const _EventPromo();

  static const _banners = <String>[
    'https://plus.unsplash.com/premium_photo-1726399099934-dc0df368562a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDZ8fHxlbnwwfHx8fHw%3D',
    'https://plus.unsplash.com/premium_photo-1750860247085-1bbb14690070?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE0fHx8ZW58MHx8fHx8',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Event & Promosi',
            style: AppTextStyles.subheading.copyWith(fontSize: 19),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: _banners.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) => _PromoBannerCard(
              imagePath: _banners[index],
            ),
          ),
        ),
      ],
    );
  }
}

class _PromoBannerCard extends StatelessWidget {
  const _PromoBannerCard({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        width: 320,
        color: AppColors.surface,

        // Image.asset(imagePath, fit: BoxFit.cover)

        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.surface,
                    AppColors.divider.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),
            Image.network(imagePath, fit: BoxFit.cover)
            // const Center(
            //   child: Icon(Icons.image_outlined,
            //       size: 32, color: AppColors.textSecondary),
            // ),
          ],
        ),
      ),
    );
  }
}

class _LatestNews extends StatelessWidget {
  const _LatestNews();

  static const _news = <_NewsItem>[
    _NewsItem(
      category: 'promo',
      title: 'Investasi Emas di Hari Olahraga Nasional Bisa ...',
      date: '09/09/26',
      imagePath: 'https://plus.unsplash.com/premium_photo-1764329343875-596eebf0414a?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    _NewsItem(
      category: 'promo',
      title: 'Dapatkan Tambahan Keuntungan 9,9%',
      date: '09/09/26',
      imagePath: 'https://plus.unsplash.com/premium_photo-1764329346307-ac9d039b3985?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1pbi1zYW1lLXNlcmllc3wyfHx8ZW58MHx8fHx8',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            children: [
              Text(
                'Berita Terbaru',
                style: AppTextStyles.subheading.copyWith(fontSize: 19),
              ),
              const SizedBox(width: AppSpacing.xs),
              const Icon(Icons.arrow_forward,
                  size: 18, color: AppColors.textPrimary),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 320,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: _news.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) => _NewsCard(item: _news[index]),
          ),
        ),
      ],
    );
  }
}

class _NewsItem {
  const _NewsItem({
    required this.category,
    required this.title,
    required this.date,
    required this.imagePath,
  });

  final String category;
  final String title;
  final String date;
  final String imagePath;
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.item});

  final _NewsItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 11,
            child: Image.network(item.imagePath, fit: BoxFit.cover),
            // Image.asset(item.imagePath, fit: BoxFit.cover)

            // child: Container(
            //   color: AppColors.divider,
            //   child: const Center(
            //     child: Icon(Icons.image_outlined,
            //         size: 28, color: AppColors.textSecondary),
            //   ),
            // ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.category,
                  style: AppTextStyles.caption.copyWith(fontSize: 13),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.subheading.copyWith(fontSize: 16),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  item.date,
                  style: AppTextStyles.caption.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
