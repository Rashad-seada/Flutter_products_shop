

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart' ;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintService {
  final doc = pw.Document();

  createDocument(pw.Flex page) {
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return page;
        })); // Page
  }

  printPdf({required Printer printer}) async {
    await Printing.directPrintPdf(printer: printer, onLayout: (_) async => doc.save() );
  }

  Future<Printer?> pickPrinters ({required Printer printer,required BuildContext context}) async {
    return await Printing.pickPrinter(context: context);
  }

  PdfPreview previewPdf(){
    return PdfPreview(
      build: (format) => doc.save(),
    );
  }


}
