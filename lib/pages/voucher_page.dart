import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  final _codeController = TextEditingController();
  int _activeTab = 0; // 0 = Input Manual, 1 = Scan QR

  bool get _canSubmit => _codeController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _codeController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _handleRedeem() {
    if (!_canSubmit) return;
    // TODO: panggil API tukar voucher di sini.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.lg,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/homepage'),
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.textOnDark),
                  ),
                  Text(
                    'Tukarkan Voucher',
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 22,
                      color: AppColors.textOnDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        AppSpacing.lg,
                        AppSpacing.lg,
                        AppSpacing.lg,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TabSwitch(
                            activeIndex: _activeTab,
                            onChanged: (i) => setState(() => _activeTab = i),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          if (_activeTab == 0)
                            _ManualInputForm(controller: _codeController)
                          else
                            const _ScanQrPlaceholder(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.sm,
                      AppSpacing.lg,
                      AppSpacing.lg,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _canSubmit ? _handleRedeem : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.divider,
                          disabledBackgroundColor: AppColors.divider,
                          foregroundColor: AppColors.textSecondary,
                          disabledForegroundColor: AppColors.textSecondary,
                        ),
                        child: const Text('Tukarkan Kode'),
                      ),
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

class _TabSwitch extends StatelessWidget {
  const _TabSwitch({required this.activeIndex, required this.onChanged});

  final int activeIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabSwitchItem(
              label: 'Input Manual',
              isActive: activeIndex == 0,
              onTap: () => onChanged(0),
            ),
          ),
          Expanded(
            child: _TabSwitchItem(
              label: 'Scan QR',
              isActive: activeIndex == 1,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabSwitchItem extends StatelessWidget {
  const _TabSwitchItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: isActive
              ? Border.all(color: AppColors.textPrimary, width: 1.5)
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.subheading.copyWith(
            fontSize: 15,
            color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _ManualInputForm extends StatelessWidget {
  const _ManualInputForm({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Masukan kode voucher',
          style: AppTextStyles.heading.copyWith(fontSize: 20),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Kamu dapat menemukan kode pada bagian belakang voucher',
          style: AppTextStyles.body.copyWith(
            fontSize: 15,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.divider),
            borderRadius: BorderRadius.circular(AppRadius.input),
          ),
          child: TextField(
            controller: controller,
            cursorColor: AppColors.textPrimary,
            style: AppTextStyles.subheading.copyWith(fontSize: 16),
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Kode voucher',
              hintStyle: TextStyle(color: AppColors.textSecondary),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md + 4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ScanQrPlaceholder extends StatelessWidget {
  const _ScanQrPlaceholder();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: const Center(
          child: Icon(
            Icons.qr_code_scanner,
            size: 64,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}