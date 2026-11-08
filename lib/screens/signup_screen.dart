import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';
import 'login_screen.dart';
import 'register_screen.dart';

/// 2. Sign up (pilihan Register / Login)
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Heading('Sign up'),
              const SizedBox(height: 12),
              const Text(
                'Join as a member & experience more fun from various meal at '
                    'mesen_gube marketing app',
                style: TextStyle(color: AppColors.muted, height: 1.5),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Register',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                ),
              ),
              const SizedBox(height: 12),
              OutlineButtonX(
                label: 'Login',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}