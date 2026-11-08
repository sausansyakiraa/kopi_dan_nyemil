import 'package:flutter/material.dart';

import '../app_state.dart';
import '../widgets/common.dart';
import 'main_shell.dart';

/// 4. Register
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final error = appState.register(_name.text, _username.text, _password.text);
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
                const Heading('Register'),
                const SizedBox(height: 28),
                AppTextField(
                  controller: _name,
                  hint: 'nama lengkap',
                  action: TextInputAction.next,
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
                ),
                AppTextField(
                  controller: _username,
                  hint: 'username',
                  action: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Username wajib diisi';
                    if (v.trim().length < 3) return 'Minimal 3 karakter';
                    return null;
                  },
                ),
                AppTextField(
                  controller: _password,
                  hint: 'password',
                  obscure: true,
                  action: TextInputAction.done,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password wajib diisi';
                    if (v.length < 6) return 'Minimal 6 karakter';
                    return null;
                  },
                ),
                const Spacer(),
                PrimaryButton(label: 'Register', onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}