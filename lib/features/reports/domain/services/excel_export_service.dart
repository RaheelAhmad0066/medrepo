import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class ExcelExportService {
  Future<File> generateWssrExcel({
    required String repName,
    required String territory,
    required DateTime startDate,
    required DateTime endDate,
    required List<Map<String, dynamic>> visitData,
    required double totalSales,
  }) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['WSSR_Report'];
    excel.delete('Sheet1'); // Remove default sheet

    final dateFormat = DateFormat('MMM d, yyyy');
    final dateRangeStr = '${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}';

    // Headers
    sheetObject.appendRow([TextCellValue('Weekly Sales Summary Report')]);
    sheetObject.appendRow([TextCellValue('Representative: $repName')]);
    sheetObject.appendRow([TextCellValue('Territory: $territory')]);
    sheetObject.appendRow([TextCellValue('Period: $dateRangeStr')]);
    sheetObject.appendRow([TextCellValue('')]); // Empty row

    // Summary
    sheetObject.appendRow([TextCellValue('Total Visits'), IntCellValue(visitData.length)]);
    sheetObject.appendRow([TextCellValue('Total Sales'), DoubleCellValue(totalSales)]);
    sheetObject.appendRow([TextCellValue('')]); // Empty row

    // Data Table Headers
    sheetObject.appendRow([
      TextCellValue('Date'),
      TextCellValue('Entity Name'),
      TextCellValue('Type'),
      TextCellValue('Outcome'),
    ]);

    // Data Rows
    for (var visit in visitData) {
      sheetObject.appendRow([
        TextCellValue(visit['date'] ?? ''),
        TextCellValue(visit['name'] ?? ''),
        TextCellValue(visit['type'] ?? ''),
        TextCellValue(visit['outcome'] ?? ''),
      ]);
    }

    // Save
    var fileBytes = excel.save();
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/WSSR_${repName.replaceAll(' ', '_')}_$dateRangeStr.xlsx');
    
    if (fileBytes != null) {
      await file.writeAsBytes(fileBytes);
    }
    
    return file;
  }
}
