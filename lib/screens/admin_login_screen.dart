import 'package:flutter/material.dart';

import '../app_routes.dart';
import '../widgets/app_colors.dart';
import '../widgets/gradient_scaffold.dart';
import '../widgets/primary_button.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.adminDashboard);
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      colors: const [AppColors.blue50, Colors.white],
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back, color: AppColors.gray700),
                style: IconButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.6)),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Admin Login', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                      const SizedBox(height: 8),
                      const Text('Access administrative dashboard', style: TextStyle(color: AppColors.gray600)),
                      const SizedBox(height: 24),
                      _LabeledField(
                        label: 'Email',
                        leading: Icons.mail_outline,
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'admin@school.edu',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _LabeledField(
                        label: 'Password',
                        leading: Icons.lock_outline,
                        trailing: IconButton(
                          onPressed: () => setState(() => _showPassword = !_showPassword),
                          icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility, color: AppColors.gray500),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: !_showPassword,
                          decoration: const InputDecoration(hintText: 'Enter your password', border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (_) {}),
                          const Text('Remember me', style: TextStyle(color: AppColors.gray600)),
                          const Spacer(),
                          TextButton(onPressed: () {}, child: const Text('Forgot password?')),
                        ],
                      ),
                      const SizedBox(height: 8),
                      PrimaryButton(
                        label: 'Login to Dashboard',
                        onPressed: _submit,
                        backgroundColor: AppColors.blue600,
                        foregroundColor: Colors.white,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.blue50,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.blue100),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('🔒 Secure Admin Access', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.gray900)),
                            SizedBox(height: 6),
                            Text(
                              'This portal is for authorized school staff only. All activities are logged.',
                              style: TextStyle(fontSize: 12, color: AppColors.blue700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.child,
    this.leading,
    this.trailing,
  });

  final String label;
  final Widget child;
  final IconData? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.gray700)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.gray200),
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                Icon(leading, color: AppColors.gray400),
                const SizedBox(width: 10),
              ],
              Expanded(child: child),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ],
    );
  }
}

