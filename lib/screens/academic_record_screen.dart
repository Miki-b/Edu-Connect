import 'package:flutter/material.dart';

import '../widgets/app_colors.dart';

class AcademicRecordScreen extends StatefulWidget {
  const AcademicRecordScreen({super.key});

  @override
  State<AcademicRecordScreen> createState() => _AcademicRecordScreenState();
}

class _AcademicRecordScreenState extends State<AcademicRecordScreen> {
  String _selectedSemester = 'Semester 1';

  @override
  Widget build(BuildContext context) {
    final subjects = <_Subject>[
      _Subject(name: 'Mathematics', grade: 'A+', score: 95, totalMarks: 100, color: const Color(0xFF3B82F6)),
      _Subject(name: 'Science', grade: 'A', score: 88, totalMarks: 100, color: const Color(0xFF22C55E)),
      _Subject(name: 'English', grade: 'A+', score: 92, totalMarks: 100, color: const Color(0xFFA855F7)),
      _Subject(name: 'Social Studies', grade: 'A', score: 85, totalMarks: 100, color: const Color(0xFFF97316)),
      _Subject(name: 'Computer Science', grade: 'A+', score: 96, totalMarks: 100, color: const Color(0xFF06B6D4)),
      _Subject(name: 'Physical Education', grade: 'A', score: 90, totalMarks: 100, color: const Color(0xFFEC4899)),
    ];

    final overallPercentage = subjects.fold<double>(0, (acc, s) => acc + s.score) / subjects.length;
    final overallGrade = overallPercentage >= 90
        ? 'A+'
        : overallPercentage >= 80
            ? 'A'
            : 'B+';

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.blue600, AppColors.blue700]),
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
                    const Text('Academic Record', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                    const SizedBox(height: 6),
                    const Text('View grades and performance', style: TextStyle(color: Color(0xFFBFDBFE))),
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
                        const Text('Select Semester', style: TextStyle(fontSize: 12, color: AppColors.gray600)),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(color: AppColors.gray50, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray200)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedSemester,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(value: 'Semester 1', child: Text('Semester 1')),
                                DropdownMenuItem(value: 'Semester 2', child: Text('Semester 2')),
                              ],
                              onChanged: (v) => setState(() => _selectedSemester = v ?? 'Semester 1'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF3B82F6), AppColors.blue600]),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [BoxShadow(color: Color(0x16000000), blurRadius: 18, offset: Offset(0, 10))],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Overall Performance', style: TextStyle(color: Color(0xFFBFDBFE), fontSize: 12)),
                                  const SizedBox(height: 6),
                                  Text(overallGrade, style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900)),
                                ],
                              ),
                            ),
                            Container(
                              width: 76,
                              height: 76,
                              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), shape: BoxShape.circle),
                              child: const Icon(Icons.trending_up, color: Colors.white, size: 40),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Expanded(child: Text('Average Score', style: TextStyle(color: Color(0xE6FFFFFF)))),
                            Text('${overallPercentage.toStringAsFixed(1)}%', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: overallPercentage / 100,
                            minHeight: 8,
                            backgroundColor: Colors.white.withValues(alpha: 0.20),
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text('Subjects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                  const SizedBox(height: 12),
                  for (final s in subjects) ...[
                    _SubjectCard(subject: s),
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

class _Subject {
  _Subject({required this.name, required this.grade, required this.score, required this.totalMarks, required this.color});
  final String name;
  final String grade;
  final double score;
  final double totalMarks;
  final Color color;
}

class _SubjectCard extends StatelessWidget {
  const _SubjectCard({required this.subject});
  final _Subject subject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: subject.color, borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(subject.name.characters.first, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(subject.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                    const SizedBox(height: 6),
                    Text('${subject.score.toInt()}/${subject.totalMarks.toInt()} marks', style: const TextStyle(fontSize: 12, color: AppColors.gray500)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: AppColors.blue50, borderRadius: BorderRadius.circular(10)),
                child: Text(subject.grade, style: const TextStyle(color: AppColors.blue700, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: subject.score / 100,
              minHeight: 8,
              backgroundColor: AppColors.gray100,
              valueColor: AlwaysStoppedAnimation<Color>(subject.color),
            ),
          ),
        ],
      ),
    );
  }
}

