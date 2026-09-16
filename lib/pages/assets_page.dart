import 'package:flutter/material.dart';
import 'package:my_flutter_clone_app/core/theme/app_text_styles.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _AssetsHeader(
              isVisible: _isBalanceVisible,
              onToggle: () => setState(
                    () => _isBalanceVisible = !_isBalanceVisible,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: const SingleChildScrollView(
                  child: _EmptyAssetsState(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------- header

class _AssetsHeader extends StatelessWidget {
  const _AssetsHeader({required this.isVisible, required this.onToggle});

  final bool isVisible;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl + AppSpacing.md,
      ),
      child: Column(
        children: [
          Text(
            'Total Aset Kamu',
            style: AppTextStyles.body.copyWith(
              fontSize: 17,
              color: AppColors.textOnDark.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isVisible ? 'Rp 0 - 0 Gram' : '**********',
                style: AppTextStyles.heading.copyWith(
                  fontSize: 28,
                  color: AppColors.textOnDark,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              GestureDetector(
                onTap: onToggle,
                child: Icon(
                  isVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 22,
                  color: AppColors.textOnDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyAssetsState extends StatelessWidget {
  const _EmptyAssetsState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl * 2),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xl),
          const _PieChartIllustration(),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Kamu tidak memiliki aset',
            style: AppTextStyles.body.copyWith(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _PieChartIllustration extends StatelessWidget {
  const _PieChartIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Sisi tebal (silinder) di bawah lingkaran.
          Positioned(
            top: 34,
            child: Container(
              width: 170,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF5C6270),
                borderRadius: BorderRadius.circular(85),
                border: Border.all(color: AppColors.textPrimary, width: 2.5),
              ),
            ),
          ),
          // Permukaan atas pie chart (putih + irisan kuning).
          Positioned(
            top: 0,
            child: Container(
              width: 170,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(85),
                border: Border.all(color: AppColors.textPrimary, width: 2.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(85),
                child: CustomPaint(
                  painter: _PieSlicePainter(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PieSlicePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final fillPaint = Paint()..color = AppColors.primary;
    final strokePaint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final path = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(center.dx - 6, center.dy - radius)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        -1.68, // sudut mulai (radian), disesuaikan manual ke posisi jam 11
        0.9, // sudut sapuan irisan
        false,
      )
      ..close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DotShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.divider;
    const spacing = 8.0;
    const dotRadius = 1.6;

    for (var y = 0.0; y < size.height; y += spacing) {
      for (var x = 0.0; x < size.width; x += spacing) {
        final offsetX = (y ~/ spacing).isEven ? 0.0 : spacing / 2;
        canvas.drawCircle(Offset(x + offsetX, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
