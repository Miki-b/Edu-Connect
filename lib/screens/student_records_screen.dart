import 'package:flutter/material.dart';

import '../widgets/app_colors.dart';

class StudentRecordsScreen extends StatefulWidget {
  const StudentRecordsScreen({super.key});

  @override
  State<StudentRecordsScreen> createState() => _StudentRecordsScreenState();
}

class _StudentRecordsScreenState extends State<StudentRecordsScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool _showAddModal = false;
  bool _showEditModal = false;
  bool _showDeleteConfirm = false;
  _Student? _selectedStudent;

  final List<_Student> _students = [
    _Student(
      id: 1,
      name: 'Martha Getahun',
      grade: '5',
      section: 'A',
      rollNo: '25',
      parent: 'Getahun Abebe',
      phone: '+2519-567-89013',
    ),
    _Student(
      id: 2,
      name: 'Sisay Mola',
      grade: '5',
      section: 'A',
      rollNo: '12',
      parent: 'Mola Tekalign',
      phone: '+2519-567-89024',
    ),
    _Student(
      id: 3,
      name: 'Sohpia Ahmed',
      grade: '4',
      section: 'B',
      rollNo: '18',
      parent: 'Ahmed Jafar',
      phone: '+2519-567-89036',
    ),
    _Student(
      id: 4,
      name: 'Michael Behailu',
      grade: '6',
      section: 'A',
      rollNo: '7',
      parent: 'Behailu Ayele',
      phone: '+2519-567-89047',
    ),
    _Student(
      id: 5,
      name: 'Abiy Asfaw',
      grade: '5',
      section: 'B',
      rollNo: '22',
      parent: 'Asfaw Seyoum',
      phone: '+2519-567-89052',
    ),
    _Student(
      id: 6,
      name: 'Yordanos Tamrat',
      grade: '4',
      section: 'A',
      rollNo: '14',
      parent: 'Tamrat Bekure',
      phone: '+2519-567-89067',
    ),
  ];


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filtered = _students.where((s) => s.name.toLowerCase().contains(query) || s.rollNo.contains(query)).toList();

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Stack(
        children: [
          Column(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Student Records', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                                SizedBox(height: 4),
                                Text('Manage student information', style: TextStyle(color: Color(0xFFBFDBFE))),
                              ],
                            ),
                            FilledButton.icon(
                              onPressed: () => setState(() => _showAddModal = true),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.blue600,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Add', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: const [BoxShadow(color: Color(0x16000000), blurRadius: 14, offset: Offset(0, 10))],
                              ),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: Icon(Icons.search, size: 20, color: AppColors.gray400),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      onChanged: (_) => setState(() {}),
                                      decoration: const InputDecoration(
                                        hintText: 'Search by name or roll no...',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: const [BoxShadow(color: Color(0x16000000), blurRadius: 14, offset: Offset(0, 10))],
                            ),
                            child: const Icon(Icons.filter_list, size: 20, color: AppColors.gray600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('${filtered.length} students found', style: const TextStyle(fontSize: 12, color: AppColors.gray600)),
                      ),
                      const SizedBox(height: 12),
                      for (final s in filtered) ...[
                        _StudentCard(
                          student: s,
                          onEdit: () => setState(() {
                            _selectedStudent = s;
                            _showEditModal = true;
                          }),
                          onDelete: () => setState(() {
                            _selectedStudent = s;
                            _showDeleteConfirm = true;
                          }),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_showAddModal)
            _BottomSheetDialog(
              title: 'Add New Student',
              onClose: () => setState(() => _showAddModal = false),
              child: const _StudentForm(),
              primaryLabel: 'Add Student',
              onPrimaryTap: () => setState(() => _showAddModal = false),
            ),
          if (_showEditModal && _selectedStudent != null)
            _BottomSheetDialog(
              title: 'Edit Student',
              onClose: () => setState(() => _showEditModal = false),
              child: _StudentForm(student: _selectedStudent),
              primaryLabel: 'Save Changes',
              onPrimaryTap: () => setState(() => _showEditModal = false),
            ),
          if (_showDeleteConfirm && _selectedStudent != null)
            _CenterDialog(
              title: 'Delete Student?',
              message: 'Are you sure you want to delete ${_selectedStudent!.name}? This action cannot be undone.',
              onCancel: () => setState(() => _showDeleteConfirm = false),
              onConfirm: () => setState(() {
                _showDeleteConfirm = false;
              }),
            ),
        ],
      ),
    );
  }
}

class _Student {
  _Student({required this.id, required this.name, required this.grade, required this.section, required this.rollNo, required this.parent, required this.phone});
  final int id;
  final String name;
  final String grade;
  final String section;
  final String rollNo;
  final String parent;
  final String phone;
}

class _StudentCard extends StatelessWidget {
  const _StudentCard({required this.student, required this.onEdit, required this.onDelete});
  final _Student student;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final initials = student.name.split(' ').map((p) => p.isNotEmpty ? p[0] : '').join();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: const [
        BoxShadow(color: Color(0x0F000000), blurRadius: 10, offset: Offset(0, 6)),
      ]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF60A5FA), AppColors.blue600]),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(initials, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(student.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('Grade ${student.grade} - ${student.section}', style: const TextStyle(fontSize: 11, color: AppColors.gray500)),
                        const SizedBox(width: 6),
                        const Text('•', style: TextStyle(color: AppColors.gray400)),
                        const SizedBox(width: 6),
                        Text('Roll: ${student.rollNo}', style: const TextStyle(fontSize: 11, color: AppColors.gray500)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Parent: ${student.parent}', style: const TextStyle(fontSize: 11, color: AppColors.gray500)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: Text(student.phone, style: const TextStyle(fontSize: 11, color: AppColors.gray500))),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, size: 18, color: AppColors.blue600),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.red600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StudentForm extends StatelessWidget {
  const _StudentForm({this.student});
  final _Student? student;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LabeledField(hint: 'Enter student name', label: 'Student Name', initial: student?.name),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _LabeledField(hint: '5', label: 'Grade', initial: student?.grade)),
            const SizedBox(width: 12),
            Expanded(child: _LabeledField(hint: 'A', label: 'Section', initial: student?.section)),
          ],
        ),
        const SizedBox(height: 12),
        _LabeledField(hint: 'Enter roll number', label: 'Roll Number', initial: student?.rollNo),
        const SizedBox(height: 12),
        _LabeledField(hint: 'Enter parent name', label: 'Parent Name', initial: student?.parent),
        const SizedBox(height: 12),
        _LabeledField(hint: '+1 234-567-8900', label: 'Phone Number', initial: student?.phone),
      ],
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.hint, required this.label, this.initial});
  final String hint;
  final String label;
  final String? initial;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.gray700)),
        const SizedBox(height: 6),
        TextField(
          controller: TextEditingController(text: initial),
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppColors.gray50,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.gray200)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.blue600, width: 1.5)),
          ),
        ),
      ],
    );
  }
}

class _BottomSheetDialog extends StatelessWidget {
  const _BottomSheetDialog({required this.title, required this.onClose, required this.child, required this.primaryLabel, required this.onPrimaryTap});
  final String title;
  final VoidCallback onClose;
  final Widget child;
  final String primaryLabel;
  final VoidCallback onPrimaryTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          top: false,
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 520, maxHeight: 520),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                      IconButton(onPressed: onClose, icon: const Icon(Icons.close, color: AppColors.gray600)),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.gray200),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                    child: child,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: onPrimaryTap,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.blue600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(primaryLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CenterDialog extends StatelessWidget {
  const _CenterDialog({required this.title, required this.message, required this.onCancel, required this.onConfirm});
  final String title;
  final String message;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.gray900)),
              const SizedBox(height: 8),
              Text(message, style: const TextStyle(fontSize: 13, color: AppColors.gray600)),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.gray700,
                        side: const BorderSide(color: AppColors.gray200),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: onConfirm,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.red600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

