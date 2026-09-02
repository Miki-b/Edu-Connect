import 'package:flutter/material.dart';

import '../app_routes.dart';
import '../widgets/app_colors.dart';

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  void _logout(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.roleSelector, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final quickActions = <_QuickAction>[
      _QuickAction(label: 'Academic Record', icon: Icons.menu_book, color: const Color(0xFF3B82F6), route: AppRoutes.parentAcademic),
      _QuickAction(label: 'Attendance', icon: Icons.calendar_month, color: const Color(0xFF22C55E), route: AppRoutes.parentAttendance),
      _QuickAction(label: 'Homework', icon: Icons.description, color: const Color(0xFFA855F7), route: AppRoutes.parentHomework),
      _QuickAction(label: 'Fee Status', icon: Icons.payments, color: const Color(0xFFF97316), route: AppRoutes.parentFees),
    ];

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Stack(
        children: [
          // Header gradient
          Container(
            height: 320,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.blue600, AppColors.blue700],
              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome Back!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                            SizedBox(height: 6),
                            Text("Track your child's progress", style: TextStyle(color: Color(0xFFBFDBFE))),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _ChildProfileCard(
                    initials: 'MG',
                    name: 'Martha Gethaun',
                    subtitle: 'Grade 5 - Section A',
                    rollNo: '25',
                    status: 'Active',
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 110),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: quickActions.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 1.15,
                          ),
                          itemBuilder: (context, idx) {
                            final a = quickActions[idx];
                            return _QuickActionCard(
                              action: a,
                              onTap: () => Navigator.of(context).pushNamed(a.route),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text('Recent Updates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                        const SizedBox(height: 12),
                        const _UpdateTile(
                          borderColor: Color(0xFF3B82F6),
                          title: 'Math Quiz Results Posted',
                          subtitle: 'Grade: A+ (95/100)',
                          time: '2h ago',
                        ),
                        const SizedBox(height: 10),
                        const _UpdateTile(
                          borderColor: Color(0xFF22C55E),
                          title: 'Attendance Updated',
                          subtitle: 'Present - Jan 23, 2026',
                          time: '5h ago',
                        ),
                        const SizedBox(height: 10),
                        const _UpdateTile(
                          borderColor: Color(0xFFA855F7),
                          title: 'New Homework Assigned',
                          subtitle: 'Science Chapter 5 - Due: Jan 25',
                          time: '1d ago',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom nav (simple)
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: AppColors.gray200)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _BottomNavItem(icon: Icons.home, label: 'Home', isActive: true, onTap: () {}),
                    _BottomNavItem(icon: Icons.notifications_none, label: 'Notices', onTap: () {}),
                    _BottomNavItem(icon: Icons.person_outline, label: 'Profile', onTap: () {}),
                    _BottomNavItem(
                      icon: Icons.logout,
                      label: 'Logout',
                      color: AppColors.gray400,
                      onTap: () => _logout(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? (isActive ? AppColors.blue600 : AppColors.gray400);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: c),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 12, color: c)),
          ],
        ),
      ),
    );
  }
}

class _ChildProfileCard extends StatelessWidget {
  const _ChildProfileCard({
    required this.initials,
    required this.name,
    required this.subtitle,
    required this.rollNo,
    required this.status,
  });

  final String initials;
  final String name;
  final String subtitle;
  final String rollNo;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 20, offset: Offset(0, 12))],
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF60A5FA), AppColors.blue600]),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(initials, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.gray500)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text('Roll No: $rollNo', style: const TextStyle(fontSize: 11, color: AppColors.gray400)),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.green50, borderRadius: BorderRadius.circular(999)),
                      child: Text(status, style: const TextStyle(fontSize: 11, color: AppColors.green600, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UpdateTile extends StatelessWidget {
  const _UpdateTile({
    required this.borderColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  final Color borderColor;
  final String title;
  final String subtitle;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: borderColor, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gray900)),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.gray500)),
              ],
            ),
          ),
          Text(time, style: const TextStyle(fontSize: 12, color: AppColors.gray400)),
        ],
      ),
    );
  }
}

class _QuickAction {
  _QuickAction({required this.label, required this.icon, required this.color, required this.route});
  final String label;
  final IconData icon;
  final Color color;
  final String route;
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.action, required this.onTap});
  final _QuickAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 14, offset: Offset(0, 8))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: action.color, borderRadius: BorderRadius.circular(14)),
              child: Icon(action.icon, color: Colors.white),
            ),
            const Spacer(),
            Text(action.label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gray900)),
          ],
        ),
      ),
    );
  }
}

