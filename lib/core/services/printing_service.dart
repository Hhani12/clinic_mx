import 'package:flutter/material.dart' show DateTimeRange;
import 'package:intl/intl.dart' as intl;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../utils/currency_format.dart';
import '../utils/date_formats.dart';
import '../../features/settings/domain/entities/clinic.dart';
import '../../features/payments/domain/entities/payment_transaction.dart';

class PrintingService {
  static Future<void> printAuditReport({
    required Clinic? clinic,
    required DateTimeRange range,
    required String? doctorName,
    required Map<String, double> stats,
    required List<PaymentTransaction> transactions,
  }) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.amiriRegular();
    final boldFont = await PdfGoogleFonts.amiriBold();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: font,
          bold: boldFont,
        ),
        build: (context) => [
          // Header
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    clinic?.name ?? 'العيادة',
                    style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                  ),
                  if (clinic?.phone != null) pw.Text('هاتف: ${clinic!.phone}'),
                  if (clinic?.address != null) pw.Text('العنوان: ${clinic!.address}'),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text('تقرير الجرد المالي', style: pw.TextStyle(fontSize: 20)),
                  pw.Text('تاريخ الطباعة: ${DateFormats.dayMonthYear.format(DateTime.now())}'),
                ],
              ),
            ],
          ),
          pw.Divider(thickness: 2),
          pw.SizedBox(height: 10),

          // Search/Filter Context
          pw.Text('الفترة: ${DateFormats.dayMonthYear.format(range.start)} - ${DateFormats.dayMonthYear.format(range.end)}'),
          pw.Text('الطبيب: ${doctorName ?? 'الكل (العيادة بالكامل)'}'),
          pw.SizedBox(height: 20),

          // Summary Cards
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              _summaryItem('الواصل (مرضى)', stats['collected'] ?? 0),
              _summaryItem('المتبقي (مرضى)', stats['pending'] ?? 0),
              _summaryItem('حصة الأطباء', stats['doctorsShare'] ?? 0),
              _summaryItem('صافي العيادة', stats['clinicNet'] ?? 0),
            ],
          ),
          pw.SizedBox(height: 20),

          // Transactions Table
          pw.Text('تفاصيل العمليات:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.TableHelper.fromTextArray(
            headers: ['التاريخ', 'المريض', 'المبلغ الكلي', 'المدفوع', 'المتبقي', 'الطبيب', 'الحصة'],
            data: transactions.map((t) => [
              DateFormats.dayMonthYear.format(t.date),
              t.patientName,
              CurrencyFormat.iqd(t.amount),
              CurrencyFormat.iqd(t.paid),
              CurrencyFormat.iqd(t.remaining),
              t.doctorName ?? '-',
              CurrencyFormat.iqd(t.doctorShare),
            ]).toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            cellAlignment: pw.Alignment.centerRight,
            columnWidths: {
              0: const pw.FixedColumnWidth(80),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FixedColumnWidth(80),
              3: const pw.FixedColumnWidth(80),
              4: const pw.FixedColumnWidth(80),
              5: const pw.FlexColumnWidth(2),
              6: const pw.FixedColumnWidth(80),
            },
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) => pdf.save(),
      name: 'audit_report_${intl.DateFormat('yyyy_MM_dd').format(DateTime.now())}.pdf',
    );
  }

  static pw.Widget _summaryItem(String title, double value) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
      ),
      child: pw.Column(
        children: [
          pw.Text(title, style: const pw.TextStyle(fontSize: 10)),
          pw.SizedBox(height: 4),
          pw.Text(CurrencyFormat.iqd(value), style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }
}
