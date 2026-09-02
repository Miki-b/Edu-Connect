import 'package:flutter/material.dart';

import '../app_routes.dart';
import '../widgets/app_colors.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  void _logout(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.roleSelector, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final stats = <_StatCardData>[
      _StatCardData(label: 'Total Students', value: '1,247', icon: Icons.people, color: const Color(0xFF3B82F6), change: '+12 this month'),
      _StatCardData(label: 'Present Today', value: '1,189', icon: Icons.calendar_month, color: const Color(0xFF22C55E), change: '95.3% attendance'),
      _StatCardData(label: 'Pending Fees', value: r'$12,450', icon: Icons.payments, color: const Color(0xFFF97316), change: '18 students'),
      _StatCardData(label: 'Staff Members', value: '87', icon: Icons.groups, color: const Color(0xFFA855F7), change: '45 teachers'),
    ];

    final quickActions = <_QuickAction>[
      _QuickAction(label: 'Student Records', icon: Icons.people, color: const Color(0xFF3B82F6), route: AppRoutes.adminStudents),
      _QuickAction(label: 'Bulk Messaging', icon: Icons.message_outlined, color: const Color(0xFF22C55E), route: AppRoutes.adminMessaging),
      _QuickAction(label: 'Reports', icon: Icons.description, color: const Color(0xFFA855F7), route: AppRoutes.adminReports),
    ];

    final recent = const <_Activity>[
      _Activity(action: 'New student enrolled', details: 'John Doe - Grade 3', time: '10 min ago'),
      _Activity(action: 'Fee payment received', details: 'Sarah Johnson - \$1,200', time: '25 min ago'),
      _Activity(action: 'Attendance marked', details: 'Grade 5 - Section A', time: '1 hour ago'),
      _Activity(action: 'Report generated', details: 'Monthly academic report', time: '2 hours ago'),
    ];

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Stack(
        children: [
          Container(
            height: 260,
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.blue600, AppColors.blue700]),
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
                            Text('Admin Dashboard', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                            SizedBox(height: 6),
                            Text('Manage your school efficiently', style: TextStyle(color: Color(0xFFBFDBFE))),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none, color: Colors.white),
                        style: IconButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.12)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Today's Date", style: TextStyle(color: Color(0xFFBFDBFE), fontSize: 12)),
                        SizedBox(height: 6),
                        Text('Friday, January 23, 2026', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 110),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: stats.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 1.05,
                          ),
                          itemBuilder: (context, idx) => _StatCard(data: stats[idx]),
                        ),
                        const SizedBox(height: 18),
                        const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                        const SizedBox(height: 12),
                        for (final a in quickActions) ...[
                          _QuickActionRow(
                            action: a,
                            onTap: () => Navigator.of(context).pushNamed(a.route),
                          ),
                          const SizedBox(height: 10),
                        ],
                        const SizedBox(height: 10),
                        const Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                        const SizedBox(height: 12),
                        for (final a in recent) ...[
                          _ActivityTile(activity: a),
                          const SizedBox(height: 10),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.gray200))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _BottomNavItem(icon: Icons.home, label: 'Home', isActive: true, onTap: () {}),
                    _BottomNavItem(icon: Icons.notifications_none, label: 'Notices', onTap: () {}),
                    _BottomNavItem(icon: Icons.settings_outlined, label: 'Settings', onTap: () {}),
                    _BottomNavItem(icon: Icons.logout, label: 'Logout', onTap: () => _logout(context)),
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
  const _BottomNavItem({required this.icon, required this.label, required this.onTap, this.isActive = false});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final c = isActive ? AppColors.blue600 : AppColors.gray400;
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

class _StatCardData {
  _StatCardData({required this.label, required this.value, required this.icon, required this.color, required this.change});
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String change;
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.data});
  final _StatCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 16, offset: Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: data.color, borderRadius: BorderRadius.circular(14)),
            child: Icon(data.icon, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(data.value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.gray900)),
          const SizedBox(height: 4),
          Text(data.label, style: const TextStyle(fontSize: 12, color: AppColors.gray600)),
          const SizedBox(height: 4),
          Text(data.change, style: const TextStyle(fontSize: 11, color: AppColors.gray400)),
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

class _QuickActionRow extends StatelessWidget {
  const _QuickActionRow({required this.action, required this.onTap});
  final _QuickAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 8))],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: action.color, borderRadius: BorderRadius.circular(14)),
              child: Icon(action.icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text(action.label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gray900)),
          ],
        ),
      ),
    );
  }
}

class _Activity {
  const _Activity({required this.action, required this.details, required this.time});
  final String action;
  final String details;
  final String time;
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.activity});
  final _Activity activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.action, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gray900)),
                const SizedBox(height: 6),
                Text(activity.details, style: const TextStyle(fontSize: 12, color: AppColors.gray500)),
              ],
            ),
          ),
          Text(activity.time, style: const TextStyle(fontSize: 12, color: AppColors.gray400)),
        ],
      ),
    );
  }
}

