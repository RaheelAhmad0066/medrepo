import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:medrep_pro/core/theme/app_theme.dart';

import '../widgets/doctor_visit_sheet.dart';
import '../widgets/chemist_visit_sheet.dart';

class DcrDailyScreen extends ConsumerStatefulWidget {
  const DcrDailyScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DcrDailyScreen> createState() => _DcrDailyScreenState();
}

class _DcrDailyScreenState extends ConsumerState<DcrDailyScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DateTime _today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showDoctorSheet(BuildContext context, String doctorName, String specialty) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DoctorVisitSheet(
        doctorName: doctorName,
        specialty: specialty,
      ),
    );
  }

  void _showChemistSheet(BuildContext context, String shopName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChemistVisitSheet(
        shopName: shopName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Daily Call Report'),
            Text(
              DateFormat('EEEE, MMM d, yyyy').format(_today),
              style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'MORNING SESSION'),
            Tab(text: 'EVENING SESSION'),
          ],
          indicatorColor: AppTheme.primaryColor,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.textSecondary,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_sync, color: AppTheme.primaryColor),
            onPressed: () {
              // Trigger explicit sync
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Submit end-of-day DCR
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.successColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: const Text('Submit Day'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSessionList(context, 'morning'),
          _buildSessionList(context, 'evening'),
        ],
      ),
    );
  }

  Widget _buildSessionList(BuildContext context, String sessionType) {
    // Mock Data for UI presentation
    final mockDoctors = sessionType == 'morning' 
      ? [('Dr. Asif Mahmood', 'Cardiologist'), ('Dr. Fatima Kidwai', 'Pediatrician')]
      : [('Dr. Khalid Raza', 'General Physician')];
      
    final mockChemists = sessionType == 'morning'
      ? [('Time Medicos')]
      : [('Kausar Medicos'), ('Green Pharmacy')];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Planned Doctors',
          style: AppTheme.titleSmall.copyWith(color: AppTheme.primaryColor),
        ),
        const SizedBox(height: 8),
        ...mockDoctors.map((doc) => _buildVisitCard(
          title: doc.$1,
          subtitle: doc.$2,
          icon: Icons.local_hospital,
          status: 'pending',
          onTap: () => _showDoctorSheet(context, doc.$1, doc.$2),
        )),
        const SizedBox(height: 24),
        Text(
          'Planned Chemists',
          style: AppTheme.titleSmall.copyWith(color: AppTheme.secondaryColor),
        ),
        const SizedBox(height: 8),
        ...mockChemists.map((chem) => _buildVisitCard(
          title: chem,
          subtitle: 'Pharmacy',
          icon: Icons.local_pharmacy,
          status: 'pending',
          onTap: () => _showChemistSheet(context, chem),
        )),
      ],
    );
  }

  Widget _buildVisitCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String status,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.surfaceColor,
          child: Icon(icon, color: AppTheme.textSecondary),
        ),
        title: Text(title, style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: AppTheme.bodySmall),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text('Pending', style: TextStyle(color: Colors.orange, fontSize: 12)),
        ),
        onTap: onTap,
      ),
    );
  }
}
