import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class PdfExportService {
  Future<File> generateWssrPdf({
    required String repName,
    required String territory,
    required DateTime startDate,
    required DateTime endDate,
    required List<Map<String, dynamic>> visitData,
    required double totalSales,
  }) async {
    final pdf = pw.Document();
    
    final dateFormat = DateFormat('MMM d, yyyy');
    final dateRangeStr = '${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            _buildHeader(repName, territory, dateRangeStr),
            pw.SizedBox(height: 20),
            _buildSummaryBox(visitData.length, totalSales),
            pw.SizedBox(height: 20),
            pw.Text('Visit Details', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            _buildVisitTable(visitData),
          ];
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/WSSR_${repName.replaceAll(' ', '_')}_$dateRangeStr.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  pw.Widget _buildHeader(String repName, String territory, String dateRangeStr) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Weekly Sales Summary Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Representative: $repName'),
            pw.Text('Territory: $territory'),
          ],
        ),
        pw.SizedBox(height: 5),
        pw.Text('Period: $dateRangeStr', style: const pw.TextStyle(color: PdfColors.grey700)),
        pw.Divider(),
      ],
    );
  }

  pw.Widget _buildSummaryBox(int totalVisits, double totalSales) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('Total Visits', totalVisits.toString()),
          _buildSummaryItem('Total Sales', '\$${totalSales.toStringAsFixed(2)}'),
          _buildSummaryItem('Target Achieved', '85%'),
        ],
      ),
    );
  }

  pw.Widget _buildSummaryItem(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(label, style: const pw.TextStyle(color: PdfColors.grey600)),
        pw.Text(value, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
      ],
    );
  }

  pw.Widget _buildVisitTable(List<Map<String, dynamic>> visitData) {
    return pw.TableHelper.fromTextArray(
      context: null,
      headers: ['Date', 'Entity Name', 'Type', 'Outcome'],
      data: visitData.map((v) => [
        v['date'] ?? '',
        v['name'] ?? '',
        v['type'] ?? '',
        v['outcome'] ?? '',
      ]).toList(),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.blue800),
      rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5))),
      cellAlignment: pw.Alignment.centerLeft,
      cellPadding: const pw.EdgeInsets.all(8),
    );
  }
}
