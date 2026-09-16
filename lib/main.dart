import 'package:flutter/material.dart';

import 'package:my_flutter_clone_app/pages/login_page.dart';
import 'package:my_flutter_clone_app/pages/main_page.dart';
import 'package:my_flutter_clone_app/pages/onboarding_page.dart';
import 'package:my_flutter_clone_app/core/theme/app_theme.dart';
import 'package:my_flutter_clone_app/core/theme/app_colors.dart';
import 'package:my_flutter_clone_app/core/theme/app_spacing.dart';
import 'package:my_flutter_clone_app/core/theme/app_text_styles.dart';
import 'package:my_flutter_clone_app/core/constants/app_assets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: SplashScreen(
        logo: Image.asset(AppAssets.logoAppYellow, height: 50, fit: BoxFit.cover),
        bottomLabel: 'Berizin Resmi & Terdaftar di',
        bottomBadges: [
          SizedBox(
            height: 28,
            child: Image.asset(AppAssets.logoBappebti,
              fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) =>
                const SizedBox.shrink()
            ),
          ),
          SizedBox(
            height: 28,
            child: Image.asset(AppAssets.logoKomdigi,
              fit: BoxFit.contain,
            ),
          ),
        ],
        nextRoute: () => const OnboardingPage(),
      ),
      routes: {
        '/loginpage': (context) => LoginPage(),
        '/onboardingpage': (context) => OnboardingPage(),
        '/homepage': (context) => MainPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    this.logo,
    this.backgroundColor = AppColors.background,
    this.decorativeColor = const Color(0xFFE9E9E9),
    this.showDecoration = true,
    this.bottomLabel,
    this.bottomBadges = const [],
    this.duration = const Duration(seconds: 2),
    this.nextRoute,
    this.onFinished,
  });

  /// Widget logo di tengah layar. Kalau null, pakai teks "treasury" placeholder.
  final Widget? logo;

  final Color backgroundColor;

  /// Warna lingkaran dekorasi di pojok.
  final Color decorativeColor;

  /// Matikan kalau nggak butuh dekorasi lingkaran.
  final bool showDecoration;

  /// Teks kecil di atas badge, misal "Berizin Resmi & Terdaftar di".
  final String? bottomLabel;

  /// Logo-logo badge (BAPPEBTI, KOMINFO, dll) ditampilkan berjajar.
  final List<Widget> bottomBadges;

  final Duration duration;

  /// Builder halaman tujuan setelah [duration].
  final Widget Function()? nextRoute;

  /// Alternatif [nextRoute] kalau navigasi mau di-handle manual
  /// (misal cek status login dulu).
  final VoidCallback? onFinished;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();

    Future.delayed(widget.duration, _handleFinish);
  }

  void _handleFinish() {
    if (!mounted) return;
    if (widget.onFinished != null) {
      widget.onFinished!();
      return;
    }
    if (widget.nextRoute != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => widget.nextRoute!()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          if (widget.showDecoration) ...[
            _CornerCircle(
              alignment: Alignment.topRight,
              size: 420,
              offset: const Offset(140, -180),
              color: widget.decorativeColor,
            ),
            _CornerCircle(
              alignment: Alignment.topRight,
              size: 300,
              offset: const Offset(80, -60),
              color: widget.decorativeColor.withValues(alpha: 0.6),
            ),
            _CornerCircle(
              alignment: Alignment.bottomLeft,
              size: 320,
              offset: const Offset(-140, 140),
              color: widget.decorativeColor,
            ),
          ],
          SafeArea(
            child: FadeTransition(
              opacity: _fade,
              child: Column(
                children: [
                  const Spacer(flex: 4),
                  widget.logo ??
                      Text(
                        'treasury',
                        style: AppTextStyles.heading.copyWith(
                          fontSize: 32,
                          fontFamily: 'serif',
                        ),
                      ),
                  const Spacer(flex: 6),
                  if (widget.bottomLabel != null) ...[
                    Text(
                      widget.bottomLabel!,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  if (widget.bottomBadges.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < widget.bottomBadges.length; i++) ...[
                          widget.bottomBadges[i],
                          if (i != widget.bottomBadges.length - 1)
                            const SizedBox(width: AppSpacing.md),
                        ],
                      ],
                    ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Lingkaran dekorasi di pojok layar. [offset] menggeser lingkaran
/// keluar dari sudut supaya cuma sebagian yang kelihatan (efek arc).
class _CornerCircle extends StatelessWidget {
  const _CornerCircle({
    required this.alignment,
    required this.size,
    required this.offset,
    required this.color,
  });

  final Alignment alignment;
  final double size;
  final Offset offset;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Transform.translate(
        offset: offset,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}