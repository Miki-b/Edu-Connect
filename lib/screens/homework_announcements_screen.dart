import 'package:flutter/material.dart';

import '../widgets/app_colors.dart';

class HomeworkAnnouncementsScreen extends StatelessWidget {
  const HomeworkAnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final announcements = <_Announcement>[
      _Announcement(
        id: 1,
        title: 'Parent-Teacher Meeting',
        message: 'Parent-teacher conference scheduled for January 28, 2026. Please confirm your attendance.',
        date: '2 hours ago',
        urgent: true,
        type: _AnnouncementType.announcement,
      ),
      _Announcement(
        id: 2,
        title: 'Math Assignment - Chapter 7',
        message: 'Complete exercises 7.1 to 7.5. Submit by January 25, 2026.',
        date: '5 hours ago',
        urgent: false,
        type: _AnnouncementType.homework,
        subject: 'Mathematics',
        dueDate: 'Jan 25, 2026',
      ),
      _Announcement(
        id: 3,
        title: 'Science Project Submission',
        message: 'Submit your science project on "Solar System Models" by January 27.',
        date: '1 day ago',
        urgent: true,
        type: _AnnouncementType.homework,
        subject: 'Science',
        dueDate: 'Jan 27, 2026',
      ),
      _Announcement(
        id: 4,
        title: 'School Annual Day',
        message: 'Annual day celebration on February 5, 2026. Students should arrive by 9:00 AM.',
        date: '2 days ago',
        urgent: false,
        type: _AnnouncementType.announcement,
      ),
      _Announcement(
        id: 5,
        title: 'English Essay Writing',
        message: 'Write an essay on "The Importance of Reading" (300 words). Due January 26.',
        date: '2 days ago',
        urgent: false,
        type: _AnnouncementType.homework,
        subject: 'English',
        dueDate: 'Jan 26, 2026',
      ),
      _Announcement(
        id: 6,
        title: 'Winter Break Notice',
        message: 'School will be closed for winter break from February 10-15, 2026.',
        date: '3 days ago',
        urgent: false,
        type: _AnnouncementType.announcement,
      ),
    ];

    final homeworkCount = announcements.where((a) => a.type == _AnnouncementType.homework).length;
    final urgentCount = announcements.where((a) => a.urgent).length;

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.purple600, AppColors.purple700]),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      style: IconButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.12)),
                    ),
                    const SizedBox(height: 10),
                    const Text('Homework & Notices', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                    const SizedBox(height: 6),
                    const Text('Stay updated with assignments', style: TextStyle(color: Color(0xFFE9D5FF))),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          icon: Icons.menu_book,
                          iconBg: const Color(0xFFF3E8FF),
                          iconColor: AppColors.purple600,
                          value: '$homeworkCount',
                          label: 'Homework',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SummaryCard(
                          icon: Icons.error_outline,
                          iconBg: AppColors.red100,
                          iconColor: AppColors.red600,
                          value: '$urgentCount',
                          label: 'Urgent',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Expanded(child: Text('All Notices', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.gray900))),
                      TextButton(onPressed: () {}, child: const Text('Filter')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  for (final a in announcements) ...[
                    _AnnouncementCard(item: a),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _AnnouncementType { homework, announcement }

class _Announcement {
  _Announcement({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.urgent,
    required this.type,
    this.subject,
    this.dueDate,
  });

  final int id;
  final String title;
  final String message;
  final String date;
  final bool urgent;
  final _AnnouncementType type;
  final String? subject;
  final String? dueDate;
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 18, offset: Offset(0, 10))],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.gray900)),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 12, color: AppColors.gray500)),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  const _AnnouncementCard({required this.item});
  final _Announcement item;

  @override
  Widget build(BuildContext context) {
    final isHomework = item.type == _AnnouncementType.homework;
    final leftBorder = item.urgent ? AppColors.red500 : null;
    final iconBg = isHomework ? const Color(0xFFF3E8FF) : AppColors.blue100;
    final icon = isHomework ? Icons.menu_book : Icons.notifications_none;
    final iconColor = isHomework ? AppColors.purple600 : AppColors.blue600;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: leftBorder != null ? Border(left: BorderSide(color: leftBorder, width: 4)) : null,
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 8))],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(item.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                        ),
                        if (item.urgent)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: AppColors.red50, borderRadius: BorderRadius.circular(8)),
                            child: const Text('Urgent', style: TextStyle(fontSize: 11, color: AppColors.red600, fontWeight: FontWeight.w800)),
                          ),
                      ],
                    ),
                    if (isHomework && item.subject != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.gray100, borderRadius: BorderRadius.circular(8)),
                        child: Text(item.subject!, style: const TextStyle(fontSize: 11, color: AppColors.gray600)),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Text(item.message, style: const TextStyle(fontSize: 12, color: AppColors.gray600, height: 1.35)),
                    if (isHomework && item.dueDate != null) ...[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: AppColors.orange600),
                          const SizedBox(width: 6),
                          Text('Due: ${item.dueDate}', style: const TextStyle(fontSize: 12, color: AppColors.orange600, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.gray100),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: Text(item.date, style: const TextStyle(fontSize: 12, color: AppColors.gray400))),
              if (isHomework) TextButton(onPressed: () {}, child: const Text('Mark as Complete')),
            ],
          ),
        ],
      ),
    );
  }
}

