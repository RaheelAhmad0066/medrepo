import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:medrep_pro/core/theme/app_theme.dart';
import 'package:medrep_pro/features/reports/domain/services/pdf_export_service.dart';
import 'package:medrep_pro/features/reports/domain/services/excel_export_service.dart';

class ReportsDashboardView extends StatefulWidget {
  const ReportsDashboardView({Key? key}) : super(key: key);

  @override
  State<ReportsDashboardView> createState() => _ReportsDashboardViewState();
}

class _ReportsDashboardViewState extends State<ReportsDashboardView> {
  bool _isExporting = false;
  final _pdfService = PdfExportService();
  final _excelService = ExcelExportService();

  final List<Map<String, dynamic>> _mockVisitData = [
    {'date': '2026-05-18', 'name': 'Dr. Asif Mahmood', 'type': 'Doctor', 'outcome': 'Positive'},
    {'date': '2026-05-18', 'name': 'Time Medicos', 'type': 'Chemist', 'outcome': 'Order Taken'},
    {'date': '2026-05-19', 'name': 'Dr. Fatima Kidwai', 'type': 'Doctor', 'outcome': 'Neutral'},
    {'date': '2026-05-19', 'name': 'Green Pharmacy', 'type': 'Chemist', 'outcome': 'Stock Checked'},
  ];

  Future<void> _exportPdf() async {
    setState(() => _isExporting = true);
    try {
      final file = await _pdfService.generateWssrPdf(
        repName: 'Raheel Ahmad',
        territory: 'Lahore Central',
        startDate: DateTime.now().subtract(const Duration(days: 7)),
        endDate: DateTime.now(),
        visitData: _mockVisitData,
        totalSales: 4500.00,
      );
      
      final result = await Share.shareXFiles([XFile(file.path)], text: 'Weekly Sales Summary Report');
      if (result.status == ShareResultStatus.success) {
        print('Shared successfully');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export Failed: $e')));
    } finally {
      setState(() => _isExporting = false);
    }
  }

  Future<void> _exportExcel() async {
    setState(() => _isExporting = true);
    try {
      final file = await _excelService.generateWssrExcel(
        repName: 'Raheel Ahmad',
        territory: 'Lahore Central',
        startDate: DateTime.now().subtract(const Duration(days: 7)),
        endDate: DateTime.now(),
        visitData: _mockVisitData,
        totalSales: 4500.00,
      );
      
      final result = await Share.shareXFiles([XFile(file.path)], text: 'Weekly Sales Summary Report');
      if (result.status == ShareResultStatus.success) {
        print('Shared successfully');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export Failed: $e')));
    } finally {
      setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Exports'),
      ),
      body: _isExporting 
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Weekly Sales Summary (WSSR)', style: AppTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text('Generate your performance report for the current week. Includes visit history, call outcomes, and total sales volume.', style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary)),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _exportPdf,
                              icon: const Icon(Icons.picture_as_pdf),
                              label: const Text('PDF'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _exportExcel,
                              icon: const Icon(Icons.table_chart),
                              label: const Text('Excel'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expense Reports', style: AppTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text('Generate monthly expense and sample distribution reports (Coming Soon).', style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: null,
                        child: const Text('Generate (Locked)'),
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
