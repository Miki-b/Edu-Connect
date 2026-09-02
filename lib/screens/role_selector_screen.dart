import 'package:flutter/material.dart';

import '../app_routes.dart';
import '../widgets/app_colors.dart';
import '../widgets/gradient_scaffold.dart';

class RoleSelectorScreen extends StatelessWidget {
  const RoleSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      colors: const [AppColors.blue50, Colors.white],
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(color: AppColors.blue600, shape: BoxShape.circle),
                  child: const Icon(Icons.school, color: Colors.white, size: 44),
                ),
                const SizedBox(height: 16),
                const Text(
                  'EduConnect',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.gray900),
                ),
                const SizedBox(height: 8),
                const Text('School Management System', style: TextStyle(color: AppColors.gray600)),
                const SizedBox(height: 48),
                _RoleCard(
                  title: 'Parent Portal',
                  subtitle: "Track your child's progress",
                  icon: Icons.people,
                  onTap: () => Navigator.of(context).pushNamed(AppRoutes.parentLogin),
                ),
                const SizedBox(height: 16),
                _RoleCard(
                  title: 'Admin / Teacher',
                  subtitle: 'Manage students and records',
                  icon: Icons.school_outlined,
                  onTap: () => Navigator.of(context).pushNamed(AppRoutes.adminLogin),
                ),
                const SizedBox(height: 32),
                const Text(
                  '© 2026 EduConnect. All rights reserved.',
                  style: TextStyle(fontSize: 12, color: AppColors.gray400),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.blue100, width: 2),
          boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 14, offset: Offset(0, 8))],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: AppColors.blue50, borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: AppColors.blue600, size: 30),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.gray900)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 13, color: AppColors.gray500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

