import 'package:flutter/material.dart';

import '../widgets/app_colors.dart';

class BulkMessagingScreen extends StatefulWidget {
  const BulkMessagingScreen({super.key});

  @override
  State<BulkMessagingScreen> createState() => _BulkMessagingScreenState();
}

class _BulkMessagingScreenState extends State<BulkMessagingScreen> {
  String _recipient = 'all';
  final TextEditingController _messageController = TextEditingController();
  bool _showSuccess = false;

  final List<_RecipientOption> _recipientOptions = const [
    _RecipientOption(value: 'all', label: 'All Parents', count: 1247),
    _RecipientOption(value: 'grade-1', label: 'Grade 1 Parents', count: 180),
    _RecipientOption(value: 'grade-2', label: 'Grade 2 Parents', count: 195),
    _RecipientOption(value: 'grade-3', label: 'Grade 3 Parents', count: 210),
    _RecipientOption(value: 'grade-4', label: 'Grade 4 Parents', count: 205),
    _RecipientOption(value: 'grade-5', label: 'Grade 5 Parents', count: 215),
    _RecipientOption(value: 'grade-6', label: 'Grade 6 Parents', count: 242),
    _RecipientOption(value: 'section-a', label: 'Section A (All Grades)', count: 623),
    _RecipientOption(value: 'section-b', label: 'Section B (All Grades)', count: 624),
  ];

  final List<_Template> _templates = const [
    _Template(
      id: 1,
      title: 'Parent-Teacher Meeting',
      text: 'Dear Parents, We are organizing a parent-teacher meeting on [DATE]. Please confirm your attendance.',
    ),
    _Template(
      id: 2,
      title: 'Fee Reminder',
      text: 'Dear Parents, This is a friendly reminder that the monthly fee payment is due by [DATE].',
    ),
    _Template(
      id: 3,
      title: 'Holiday Notice',
      text: 'Dear Parents, The school will remain closed from [START DATE] to [END DATE] for [OCCASION].',
    ),
    _Template(
      id: 4,
      title: 'Event Invitation',
      text: 'Dear Parents, You are cordially invited to attend [EVENT NAME] on [DATE] at [TIME].',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() => _showSuccess = true);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showSuccess = false;
          _messageController.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selected = _recipientOptions.firstWhere((r) => r.value == _recipient);
    final message = _messageController.text;

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Stack(
        children: [
          Column(
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
                        const Text('Bulk Messaging', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                        const SizedBox(height: 6),
                        const Text('Send announcements to parents', style: TextStyle(color: Color(0xFFD1FAE5))),
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
                            const Text('Select Recipients', style: TextStyle(fontSize: 13, color: AppColors.gray700)),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                itemCount: _recipientOptions.length,
                                itemBuilder: (context, index) {
                                  final option = _recipientOptions[index];
                                  final isSelected = option.value == _recipient;
                                  return InkWell(
                                    onTap: () => setState(() => _recipient = option.value),
                                    borderRadius: BorderRadius.circular(14),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 4),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(color: isSelected ? AppColors.green600 : AppColors.gray200, width: 2),
                                        color: isSelected ? AppColors.green50 : Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Radio<String>(
                                            value: option.value,
                                            groupValue: _recipient,
                                            onChanged: (v) => setState(() => _recipient = v ?? _recipient),
                                            activeColor: AppColors.green600,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(option.label, style: const TextStyle(fontSize: 13, color: AppColors.gray900)),
                                                const SizedBox(height: 2),
                                                Text('${option.count} recipients', style: const TextStyle(fontSize: 11, color: AppColors.gray500)),
                                              ],
                                            ),
                                          ),
                                          const Icon(Icons.group, size: 18, color: AppColors.gray400),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.green50,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: AppColors.green100),
                              ),
                              child: Text(
                                '✓ Message will be sent to ${selected.count} parents',
                                style: const TextStyle(fontSize: 12, color: AppColors.green700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text('Quick Templates', style: TextStyle(fontSize: 13, color: AppColors.gray700)),
                      const SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _templates.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.8,
                        ),
                        itemBuilder: (context, index) {
                          final t = _templates[index];
                          return InkWell(
                            onTap: () => setState(() => _messageController.text = t.text),
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: AppColors.gray100),
                                boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 10, offset: Offset(0, 6))],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(t.title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.gray900)),
                                  const SizedBox(height: 4),
                                  Text(
                                    t.text.length > 50 ? '${t.text.substring(0, 50)}...' : t.text,
                                    style: const TextStyle(fontSize: 11, color: AppColors.gray500),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: const [
                          BoxShadow(color: Color(0x12000000), blurRadius: 18, offset: Offset(0, 10)),
                        ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Compose Message', style: TextStyle(fontSize: 13, color: AppColors.gray700)),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _messageController,
                              maxLines: 8,
                              onChanged: (_) => setState(() {}),
                              decoration: InputDecoration(
                                hintText: 'Type your announcement here...',
                                filled: true,
                                fillColor: AppColors.gray50,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.gray200)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.green600, width: 1.5)),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${message.length} characters', style: const TextStyle(fontSize: 11, color: AppColors.gray500)),
                                TextButton(onPressed: () {}, child: const Text('Add Emoji')),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: message.trim().isEmpty ? null : _handleSend,
                          icon: const Icon(Icons.send),
                          label: const Text('Send Message'),
                          style: FilledButton.styleFrom(
                            backgroundColor: message.trim().isNotEmpty ? AppColors.green600 : AppColors.gray200,
                            foregroundColor: message.trim().isNotEmpty ? Colors.white : AppColors.gray400,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            disabledBackgroundColor: AppColors.gray200,
                            disabledForegroundColor: AppColors.gray400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text('Recent Messages', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                      const SizedBox(height: 12),
                      const _RecentMessageCard(
                        title: 'Parent-Teacher Meeting Notice',
                        subtitle: 'Sent to: All Parents (1,247)',
                        time: '2h ago',
                        snippet: 'Dear Parents, We are organizing a parent-teacher meeting on January 28, 2026...',
                      ),
                      const SizedBox(height: 10),
                      const _RecentMessageCard(
                        title: 'School Annual Day Invitation',
                        subtitle: 'Sent to: All Parents (1,247)',
                        time: '1d ago',
                        snippet: 'You are cordially invited to attend our Annual Day celebration on February 5...',
                      ),
                      const SizedBox(height: 10),
                      const _RecentMessageCard(
                        title: 'Fee Payment Reminder',
                        subtitle: 'Sent to: Grade 5 Parents (215)',
                        time: '3d ago',
                        snippet: 'This is a friendly reminder that the monthly fee payment is due by January 25...',
                      ),
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
                        decoration: const BoxDecoration(color: AppColors.green100, shape: BoxShape.circle),
                        child: const Icon(Icons.check_circle, size: 40, color: AppColors.green600),
                      ),
                      const SizedBox(height: 14),
                      const Text('Message Sent!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                      const SizedBox(height: 8),
                      Text(
                        'Your announcement has been sent to ${selected.count} parents successfully.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13, color: AppColors.gray600),
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

class _RecipientOption {
  const _RecipientOption({required this.value, required this.label, required this.count});
  final String value;
  final String label;
  final int count;
}

class _Template {
  const _Template({required this.id, required this.title, required this.text});
  final int id;
  final String title;
  final String text;
}

class _RecentMessageCard extends StatelessWidget {
  const _RecentMessageCard({required this.title, required this.subtitle, required this.time, required this.snippet});
  final String title;
  final String subtitle;
  final String time;
  final String snippet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: const [
        BoxShadow(color: Color(0x0F000000), blurRadius: 10, offset: Offset(0, 6)),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.gray500)),
                  ],
                ),
              ),
              Text(time, style: const TextStyle(fontSize: 11, color: AppColors.gray400)),
            ],
          ),
          const SizedBox(height: 8),
          Text(snippet, style: const TextStyle(fontSize: 11, color: AppColors.gray600)),
        ],
      ),
    );
  }
}

