import 'package:flutter/material.dart';

import '../widgets/app_colors.dart';

class FeeStatusScreen extends StatelessWidget {
  const FeeStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feeHistory = <_FeePayment>[
      _FeePayment(month: 'January 2026', amount: 1200, status: _PaymentStatus.paid, paidDate: 'Jan 5, 2026', receiptId: 'RCP-2026-001'),
      _FeePayment(month: 'December 2025', amount: 1200, status: _PaymentStatus.paid, paidDate: 'Dec 3, 2025', receiptId: 'RCP-2025-012'),
      _FeePayment(month: 'November 2025', amount: 1200, status: _PaymentStatus.paid, paidDate: 'Nov 2, 2025', receiptId: 'RCP-2025-011'),
      _FeePayment(month: 'October 2025', amount: 1200, status: _PaymentStatus.paid, paidDate: 'Oct 4, 2025', receiptId: 'RCP-2025-010'),
    ];

    const outstandingBalance = 0;
    final totalPaid = feeHistory.where((f) => f.status == _PaymentStatus.paid).fold<int>(0, (sum, f) => sum + f.amount);

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.orange600, AppColors.orange700]),
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
                    const Text('Fee Status', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                    const SizedBox(height: 6),
                    const Text('View payment history', style: TextStyle(color: Color(0xFFFED7AA))),
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
                  // Balance summary card
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 18, offset: Offset(0, 10))],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Outstanding Balance', style: TextStyle(fontSize: 12, color: AppColors.gray600)),
                                  const SizedBox(height: 6),
                                  Text('\$$outstandingBalance', style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: AppColors.gray900)),
                                ],
                              ),
                            ),
                            Container(
                              width: 76,
                              height: 76,
                              decoration: const BoxDecoration(color: AppColors.green100, shape: BoxShape.circle),
                              child: const Icon(Icons.check_circle, color: AppColors.green600, size: 40),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        if (outstandingBalance == 0)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.green50,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: AppColors.green100),
                            ),
                            child: const Text('✓ All fees are up to date!', textAlign: TextAlign.center, style: TextStyle(color: AppColors.green700, fontWeight: FontWeight.w700)),
                          )
                        else
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF7ED),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFFED7AA)),
                            ),
                            child: const Text('⚠ Payment pending', textAlign: TextAlign.center, style: TextStyle(color: AppColors.orange700, fontWeight: FontWeight.w700)),
                          ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _SummaryTile(
                                background: AppColors.blue50,
                                value: '\$$totalPaid',
                                label: 'Total Paid',
                                valueColor: AppColors.blue600,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _SummaryTile(
                                background: AppColors.gray50,
                                value: '${feeHistory.length}',
                                label: 'Transactions',
                                valueColor: AppColors.gray900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  const Text('Payment History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                  const SizedBox(height: 12),
                  for (final p in feeHistory) ...[
                    _PaymentCard(payment: p),
                    const SizedBox(height: 12),
                  ],

                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Monthly Fee Breakdown', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                        SizedBox(height: 14),
                        _BreakdownRow(label: 'Tuition Fee', value: r'$800', hasDivider: true),
                        _BreakdownRow(label: 'Transportation', value: r'$200', hasDivider: true),
                        _BreakdownRow(label: 'Activities & Sports', value: r'$150', hasDivider: true),
                        _BreakdownRow(label: 'Library & Lab', value: r'$50', hasDivider: false),
                        SizedBox(height: 12),
                        Divider(thickness: 2, height: 2, color: AppColors.gray200),
                        SizedBox(height: 12),
                        _BreakdownTotalRow(label: 'Monthly Total', value: r'$1,200'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({required this.background, required this.value, required this.label, required this.valueColor});
  final Color background;
  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: valueColor)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.gray600)),
        ],
      ),
    );
  }
}

enum _PaymentStatus { paid }

class _FeePayment {
  _FeePayment({required this.month, required this.amount, required this.status, required this.paidDate, required this.receiptId});
  final String month;
  final int amount;
  final _PaymentStatus status;
  final String paidDate;
  final String receiptId;
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({required this.payment});
  final _FeePayment payment;

  @override
  Widget build(BuildContext context) {
    final isPaid = payment.status == _PaymentStatus.paid;
    final iconBg = isPaid ? AppColors.green100 : const Color(0xFFFFEDD5);
    final iconColor = isPaid ? AppColors.green600 : AppColors.orange700;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
                child: Icon(isPaid ? Icons.check_circle : Icons.schedule, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(payment.month, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.gray900)),
                    const SizedBox(height: 6),
                    Text(isPaid ? 'Paid on ${payment.paidDate}' : 'Payment pending', style: const TextStyle(fontSize: 12, color: AppColors.gray500)),
                    const SizedBox(height: 6),
                    Text('Receipt: ${payment.receiptId}', style: const TextStyle(fontSize: 12, color: AppColors.gray400)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('\$${payment.amount}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.gray900)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPaid ? AppColors.green50 : const Color(0xFFFFF7ED),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(isPaid ? 'Paid' : 'Pending', style: TextStyle(fontSize: 12, color: isPaid ? AppColors.green700 : AppColors.orange700, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ],
          ),
          if (isPaid) ...[
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.gray100),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, size: 18),
                label: const Text('Download Receipt'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({required this.label, required this.value, required this.hasDivider});
  final String label;
  final String value;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: const TextStyle(color: AppColors.gray600))),
            Text(value, style: const TextStyle(color: AppColors.gray900, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 10),
        if (hasDivider) const Divider(height: 1, color: AppColors.gray100),
        if (hasDivider) const SizedBox(height: 10),
      ],
    );
  }
}

class _BreakdownTotalRow extends StatelessWidget {
  const _BreakdownTotalRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(color: AppColors.gray900, fontWeight: FontWeight.w700))),
        Text(value, style: const TextStyle(fontSize: 18, color: AppColors.gray900, fontWeight: FontWeight.w900)),
      ],
    );
  }
}

