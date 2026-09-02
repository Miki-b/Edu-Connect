import 'package:flutter/material.dart';

import '../widgets/app_colors.dart';

class ReportGeneratorScreen extends StatefulWidget {
  const ReportGeneratorScreen({super.key});

  @override
  State<ReportGeneratorScreen> createState() => _ReportGeneratorScreenState();
}

class _ReportGeneratorScreenState extends State<ReportGeneratorScreen> {
  String _reportType = 'academic';
  String _selectedGrade = 'all';
  String _selectedPeriod = 'january-2026';
  bool _showSuccess = false;

  final List<_ReportType> _reportTypes = const [
    _ReportType(value: 'academic', label: 'Academic Performance Report', icon: '📊', description: 'Student grades and performance'),
    _ReportType(value: 'attendance', label: 'Attendance Report', icon: '📅', description: 'Daily attendance records'),
    _ReportType(value: 'fee', label: 'Fee Collection Report', icon: '💰', description: 'Payment status and dues'),
    _ReportType(value: 'teacher', label: 'Teacher Performance Report', icon: '👨‍🏫', description: 'Staff evaluation data'),
  ];

  final List<_Option> _gradeOptions = const [
    _Option(value: 'all', label: 'All Grades'),
    _Option(value: 'grade-1', label: 'Grade 1'),
    _Option(value: 'grade-2', label: 'Grade 2'),
    _Option(value: 'grade-3', label: 'Grade 3'),
    _Option(value: 'grade-4', label: 'Grade 4'),
    _Option(value: 'grade-5', label: 'Grade 5'),
    _Option(value: 'grade-6', label: 'Grade 6'),
  ];

  final List<_Option> _periodOptions = const [
    _Option(value: 'january-2026', label: 'January 2026'),
    _Option(value: 'december-2025', label: 'December 2025'),
    _Option(value: 'november-2025', label: 'November 2025'),
    _Option(value: 'october-2025', label: 'October 2025'),
    _Option(value: 'semester-1', label: 'Semester 1 (2025-26)'),
    _Option(value: 'semester-2', label: 'Semester 2 (2025-26)'),
    _Option(value: 'full-year', label: 'Full Year (2025-26)'),
  ];

  final List<_RecentReport> _recentReports = const [
    _RecentReport(id: 1, name: 'Academic Report - Grade 5', date: 'Jan 20, 2026', type: 'PDF', size: '2.4 MB'),
    _RecentReport(id: 2, name: 'Attendance Report - December', date: 'Jan 15, 2026', type: 'PDF', size: '1.8 MB'),
    _RecentReport(id: 3, name: 'Fee Collection Report - Q4', date: 'Jan 10, 2026', type: 'Excel', size: '856 KB'),
    _RecentReport(id: 4, name: 'Teacher Performance - Semester 1', date: 'Jan 5, 2026', type: 'PDF', size: '3.2 MB'),
  ];

  void _handleGenerate() {
    setState(() => _showSuccess = true);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _showSuccess = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedType = _reportTypes.firstWhere((r) => r.value == _reportType);
    final gradeLabel = _gradeOptions.firstWhere((g) => g.value == _selectedGrade).label;
    final periodLabel = _periodOptions.firstWhere((p) => p.value == _selectedPeriod).label;

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Stack(
        children: [
          Column(
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
                        const Text('Report Generator', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                        const SizedBox(height: 6),
                        const Text('Generate and export reports', style: TextStyle(color: Color(0xFFE9D5FF))),
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
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: const [
                          BoxShadow(color: Color(0x12000000), blurRadius: 18, offset: Offset(0, 10)),
                        ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Select Report Type', style: TextStyle(fontSize: 13, color: AppColors.gray700)),
                            const SizedBox(height: 10),
                            for (final type in _reportTypes) ...[
                              InkWell(
                                onTap: () => setState(() => _reportType = type.value),
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: _reportType == type.value ? AppColors.purple600 : AppColors.gray200,
                                      width: 2,
                                    ),
                                    color: _reportType == type.value ? const Color(0xFFF3E8FF) : Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: type.value,
                                        groupValue: _reportType,
                                        onChanged: (v) => setState(() => _reportType = v ?? _reportType),
                                        activeColor: AppColors.purple600,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(type.icon, style: const TextStyle(fontSize: 16)),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(type.label, style: const TextStyle(fontSize: 13, color: AppColors.gray900)),
                                            const SizedBox(height: 2),
                                            Text(type.description, style: const TextStyle(fontSize: 11, color: AppColors.gray500)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: const [
                          BoxShadow(color: Color(0x10000000), blurRadius: 12, offset: Offset(0, 8)),
                        ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Select Grade/Class', style: TextStyle(fontSize: 13, color: AppColors.gray700)),
                            const SizedBox(height: 8),
                            _DropdownField(
                              value: _selectedGrade,
                              options: _gradeOptions,
                              onChanged: (v) => setState(() => _selectedGrade = v),
                            ),
                            const SizedBox(height: 16),
                            const Text('Select Period', style: TextStyle(fontSize: 13, color: AppColors.gray700)),
                            const SizedBox(height: 8),
                            _DropdownField(
                              value: _selectedPeriod,
                              options: _periodOptions,
                              leadingIcon: Icons.calendar_today,
                              onChanged: (v) => setState(() => _selectedPeriod = v),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFF3E8FF), Colors.white]),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFE9D5FF)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Report Preview', style: TextStyle(fontSize: 13, color: AppColors.gray700)),
                            const SizedBox(height: 10),
                            _PreviewRow(label: 'Report Type', value: selectedType.label),
                            _PreviewRow(label: 'Grade/Class', value: gradeLabel),
                            _PreviewRow(label: 'Period', value: periodLabel),
                            const _PreviewRow(label: 'Format', value: 'PDF'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _handleGenerate,
                          icon: const Icon(Icons.description),
                          label: const Text('Generate Report'),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.purple600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text('Recent Reports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                      const SizedBox(height: 12),
                      for (final r in _recentReports) ...[
                        _RecentReportCard(report: r),
                        const SizedBox(height: 10),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_showSuccess)
            Material(
              color: Colors.black.withValues(alpha: 0.5),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(color: Color(0xFFF3E8FF), shape: BoxShape.circle),
                        child: const Icon(Icons.check_circle, size: 40, color: AppColors.purple600),
                      ),
                      const SizedBox(height: 14),
                      const Text('Report Generated!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                      const SizedBox(height: 8),
                      Text(
                        'Your ${selectedType.label.toLowerCase()} has been generated successfully.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13, color: AppColors.gray600),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download),
                          label: const Text('Download Report'),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.purple600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
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

class _ReportType {
  const _ReportType({required this.value, required this.label, required this.icon, required this.description});
  final String value;
  final String label;
  final String icon;
  final String description;
}

class _Option {
  const _Option({required this.value, required this.label});
  final String value;
  final String label;
}

class _RecentReport {
  const _RecentReport({required this.id, required this.name, required this.date, required this.type, required this.size});
  final int id;
  final String name;
  final String date;
  final String type;
  final String size;
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({required this.value, required this.options, required this.onChanged, this.leadingIcon});
  final String value;
  final List<_Option> options;
  final void Function(String) onChanged;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(14),
        border: const Border.fromBorderSide(BorderSide(color: AppColors.gray200)),
      ),
      child: Row(
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, size: 18, color: AppColors.gray400),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                items: options.map((o) => DropdownMenuItem(value: o.value, child: Text(o.label))).toList(),
                onChanged: (v) {
                  if (v != null) onChanged(v);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  const _PreviewRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.gray600))),
          Text(value, style: const TextStyle(fontSize: 12, color: AppColors.gray900, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _RecentReportCard extends StatelessWidget {
  const _RecentReportCard({required this.report});
  final _RecentReport report;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: const [
        BoxShadow(color: Color(0x0F000000), blurRadius: 10, offset: Offset(0, 6)),
      ]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(color: Color(0xFFF3E8FF), borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Icon(Icons.description, size: 22, color: AppColors.purple600),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(report.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(report.date, style: const TextStyle(fontSize: 11, color: AppColors.gray500)),
                        const SizedBox(width: 6),
                        const Text('•', style: TextStyle(fontSize: 11, color: AppColors.gray400)),
                        const SizedBox(width: 6),
                        Text(report.type, style: const TextStyle(fontSize: 11, color: AppColors.gray500)),
                        const SizedBox(width: 6),
                        const Text('•', style: TextStyle(fontSize: 11, color: AppColors.gray400)),
                        const SizedBox(width: 6),
                        Text(report.size, style: const TextStyle(fontSize: 11, color: AppColors.gray500)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download, size: 18, color: AppColors.purple600),
              label: const Text('Download', style: TextStyle(fontSize: 13, color: AppColors.purple600)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE9D5FF)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

