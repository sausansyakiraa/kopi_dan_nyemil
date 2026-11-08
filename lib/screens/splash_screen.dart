import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';
import 'signup_screen.dart';

/// 1. Splash / Welcome
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: AppColors.peach,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.coffee_rounded,
                  size: 60,
                  color: AppColors.brown,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Kopi dan Nyemil',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Get a taste of your wish',
                style: TextStyle(fontSize: 15, color: AppColors.muted),
              ),
              const Spacer(flex: 3),
              PrimaryButton(
                label: 'Start now',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}