import 'package:flutter/material.dart';

import '../app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'main_shell.dart';

/// 3. Login User
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final error = appState.login(_username.text, _password.text);
    if (error != null) {
      showSnack(context, error);
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainShell()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Heading('Login User'),
                const SizedBox(height: 28),
                AppTextField(
                  controller: _username,
                  hint: 'username',
                  action: TextInputAction.next,
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Username wajib diisi' : null,
                ),
                AppTextField(
                  controller: _password,
                  hint: 'password',
                  obscure: true,
                  action: TextInputAction.done,
                  validator: (v) =>
                  (v == null || v.isEmpty) ? 'Password wajib diisi' : null,
                ),
                const SizedBox(height: 4),
                const Text(
                  'Akun demo: username "demo", password "123456"',
                  style: TextStyle(color: AppColors.muted, fontSize: 12),
                ),
                const Spacer(),
                PrimaryButton(label: 'Login', onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}