import 'package:flutter/material.dart';

import '../app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// 8. Konfirmasi pesanan
class ConfirmationScreen extends StatelessWidget {
  final String name;
  const ConfirmationScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Heading('Halo $name,'),
              const Spacer(),
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: AppColors.mint,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 64,
                    color: AppColors.mintDark,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Center(
                child: Text(
                  'Terima kasih sudah memesan\n'
                      'tunggu aja sebentar kurir kami\n'
                      'segera mengantarkan pesananmu!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.muted, height: 1.6),
                ),
              ),
              const Spacer(flex: 2),
              PrimaryButton(
                label: 'Oke',
                onPressed: () {
                  appState.setTab(0);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}