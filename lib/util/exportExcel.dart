import 'dart:io';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:excel/excel.dart';

class getExcel {
  static Future<void> export() async {
    final Workbook workbook = Workbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/test.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFilex.open(fileName);

    // final excel = Excel.createExcel();
    // final sheet = excel.sheets[excel.getDefaultSheet() as String];
    // sheet!.setColWidth(2, 50);
    // sheet.setColAutoFit(3);

    // sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 3)).value =
    //     'Text string';
    // sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 4)).value =
    //     'Text string Text string Text string Text string Text string Text string Text string Text string';
    // excel.save();
  }
}
