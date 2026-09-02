import 'package:flutter/material.dart';

import 'app_routes.dart';
import 'screens/academic_record_screen.dart';
import 'screens/admin_dashboard_screen.dart';
import 'screens/admin_login_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/bulk_messaging_screen.dart';
import 'screens/fee_status_screen.dart';
import 'screens/homework_announcements_screen.dart';
import 'screens/parent_dashboard_screen.dart';
import 'screens/parent_login_screen.dart';
import 'screens/report_generator_screen.dart';
import 'screens/role_selector_screen.dart';
import 'screens/student_records_screen.dart';

void main() {
  runApp(const SmsApp());
}

class SmsApp extends StatelessWidget {
  const SmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.roleSelector,
      routes: {
        AppRoutes.roleSelector: (_) => const RoleSelectorScreen(),
        AppRoutes.parentLogin: (_) => const ParentLoginScreen(),
        AppRoutes.parentDashboard: (_) => const ParentDashboardScreen(),
        AppRoutes.parentAcademic: (_) => const AcademicRecordScreen(),
        AppRoutes.parentAttendance: (_) => const AttendanceScreen(),
        AppRoutes.parentHomework: (_) => const HomeworkAnnouncementsScreen(),
        AppRoutes.parentFees: (_) => const FeeStatusScreen(),
        AppRoutes.adminLogin: (_) => const AdminLoginScreen(),
        AppRoutes.adminDashboard: (_) => const AdminDashboardScreen(),
        AppRoutes.adminStudents: (_) => const StudentRecordsScreen(),
        AppRoutes.adminMessaging: (_) => const BulkMessagingScreen(),
        AppRoutes.adminReports: (_) => const ReportGeneratorScreen(),
      },
    );
  }
}
