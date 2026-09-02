import 'package:flutter/material.dart';

import '../widgets/app_colors.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final String _currentMonth = 'January 2026';

  // 1: present, 0: absent, null: holiday/weekend
  final List<int?> _attendanceData = const [
    null, null, null, null, 1, 1, // week 1
    1, 1, 1, 1, 1, null, null, // week 2
    1, 1, 0, 1, 1, null, null, // week 3
    1, 1, 1, 1, 1, null, null, // week 4
    1, 1, 1 // week 5
  ];

  @override
  Widget build(BuildContext context) {
    final presentDays = _attendanceData.where((d) => d == 1).length;
    final absentDays = _attendanceData.where((d) => d == 0).length;
    final totalDays = presentDays + absentDays;
    final attendancePercentage = totalDays > 0 ? (presentDays / totalDays) * 100 : 0.0;
    const monthDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.green600, AppColors.green700]),
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
                    const Text('Attendance', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                    const SizedBox(height: 6),
                    const Text('Track daily attendance', style: TextStyle(color: Color(0xFFBBF7D0))),
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
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: const [
                      BoxShadow(color: Color(0x12000000), blurRadius: 18, offset: Offset(0, 10)),
                    ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Attendance Rate', style: TextStyle(fontSize: 12, color: AppColors.gray600)),
                                  const SizedBox(height: 6),
                                  Text('${attendancePercentage.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: AppColors.gray900)),
                                ],
                              ),
                            ),
                            Container(
                              width: 76,
                              height: 76,
                              decoration: const BoxDecoration(color: AppColors.green100, shape: BoxShape.circle),
                              child: const Icon(Icons.calendar_month, color: AppColors.green600, size: 40),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(child: _MiniStat(bg: AppColors.green50, value: '$presentDays', label: 'Present', color: AppColors.green600)),
                            const SizedBox(width: 10),
                            Expanded(child: _MiniStat(bg: AppColors.red50, value: '$absentDays', label: 'Absent', color: AppColors.red600)),
                            const SizedBox(width: 10),
                            Expanded(child: _MiniStat(bg: AppColors.blue50, value: '$totalDays', label: 'Total', color: AppColors.blue600)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left)),
                            Expanded(
                              child: Center(
                                child: Text(_currentMonth, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.gray900)),
                              ),
                            ),
                            IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            for (final d in monthDays)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(d, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: AppColors.gray500)),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _attendanceData.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 8, crossAxisSpacing: 8),
                          itemBuilder: (context, i) {
                            final status = _attendanceData[i];
                            Color bg;
                            Color fg;
                            if (status == 1) {
                              bg = AppColors.green100;
                              fg = AppColors.green700;
                            } else if (status == 0) {
                              bg = AppColors.red100;
                              fg = AppColors.red600;
                            } else {
                              bg = AppColors.gray50;
                              fg = AppColors.gray400;
                            }
                            return AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text('${i + 1}', style: TextStyle(color: fg, fontWeight: FontWeight.w700)),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 14),
                        const Divider(height: 1, color: AppColors.gray100),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            _Legend(color: AppColors.green100, label: 'Present'),
                            SizedBox(width: 18),
                            _Legend(color: AppColors.red100, label: 'Absent'),
                            SizedBox(width: 18),
                            _Legend(color: AppColors.gray50, label: 'Holiday'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text('Recent Records', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                  const SizedBox(height: 12),
                  const _RecentRow(date: 'Friday, Jan 23, 2026', subtitle: 'Check-in: 8:15 AM', status: 'Present', statusBg: AppColors.green50, statusFg: AppColors.green700),
                  const SizedBox(height: 10),
                  const _RecentRow(date: 'Thursday, Jan 22, 2026', subtitle: 'Check-in: 8:10 AM', status: 'Present', statusBg: AppColors.green50, statusFg: AppColors.green700),
                  const SizedBox(height: 10),
                  const _RecentRow(date: 'Wednesday, Jan 21, 2026', subtitle: 'No check-in', status: 'Absent', statusBg: AppColors.red50, statusFg: AppColors.red600),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.bg, required this.value, required this.label, required this.color});
  final Color bg;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: color)),
          const SizedBox(height: 4),
          const Text(''),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.gray600)),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 14, height: 14, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.gray600)),
      ],
    );
  }
}

class _RecentRow extends StatelessWidget {
  const _RecentRow({required this.date, required this.subtitle, required this.status, required this.statusBg, required this.statusFg});
  final String date;
  final String subtitle;
  final String status;
  final Color statusBg;
  final Color statusFg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.gray500)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(10)),
            child: Text(status, style: TextStyle(color: statusFg, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}

