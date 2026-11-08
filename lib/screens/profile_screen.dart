import 'package:flutter/material.dart';

import '../app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'splash_screen.dart';

/// 6. Profile
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: appState.currentUser?.fullName ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    appState.updateName(_name.text);
    FocusScope.of(context).unfocus();
    showSnack(context, 'Profile berhasil disimpan');
  }

  void _logout() {
    appState.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SplashScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Heading('Halo ${appState.displayName},'),
                const SizedBox(height: 24),
                const Text(
                  'Profile Saya',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  '@${appState.currentUser?.username ?? '-'}',
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Profile Setting',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 10),
                AppTextField(
                  controller: _name,
                  hint: 'nama',
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
                ),
                const Spacer(),
                PrimaryButton(label: 'Save', onPressed: _save),
                const SizedBox(height: 12),
                OutlineButtonX(label: 'Logout', onPressed: _logout),
              ],
            ),
          ),
        );
      },
    );
  }
}