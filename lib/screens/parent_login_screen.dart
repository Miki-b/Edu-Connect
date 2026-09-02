import 'package:flutter/material.dart';

import '../app_routes.dart';
import '../widgets/app_colors.dart';
import '../widgets/gradient_scaffold.dart';
import '../widgets/primary_button.dart';

class ParentLoginScreen extends StatefulWidget {
  const ParentLoginScreen({super.key});

  @override
  State<ParentLoginScreen> createState() => _ParentLoginScreenState();
}

class _ParentLoginScreenState extends State<ParentLoginScreen> {
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
    Navigator.of(context).pushReplacementNamed(AppRoutes.parentDashboard);
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
                      const Text('Parent Login', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                      const SizedBox(height: 8),
                      const Text('Welcome back! Please login to continue', style: TextStyle(color: AppColors.gray600)),
                      const SizedBox(height: 24),
                      _LabeledField(
                        label: 'Email / Phone',
                        leading: Icons.mail_outline,
                        child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your email or phone',
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
                        label: 'Login',
                        onPressed: _submit,
                        backgroundColor: AppColors.blue600,
                        foregroundColor: Colors.white,
                      ),
                      const SizedBox(height: 18),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text("Don't have an account? ", style: TextStyle(color: AppColors.gray500)),
                            TextButton(onPressed: () {}, child: const Text('Contact School')),
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
            boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 18, offset: Offset(0, 10))],
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

