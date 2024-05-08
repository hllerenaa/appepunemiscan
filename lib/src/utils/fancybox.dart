import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<String?> downloadPdf(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    final documentDirectory = await getApplicationDocumentsDirectory();
    // Puedes personalizar el nombre del archivo aquí, por ejemplo, usando un timestamp
    final fileName = 'downloaded_pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${documentDirectory.path}/$fileName');

    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  } catch (e) {
    print("Error downloading PDF: $e");
    return null;
  }
}

void showFileModal(BuildContext context, String url) async {
  // Verifica si el recurso es un PDF
  if (url.endsWith('.pdf')) {
    final filePath = await downloadPdf(url);
    if (filePath != null) {
      launch(url);
      // Informa al usuario que la descarga ha finalizado exitosamente
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF descargado en su dispositivo')),
      );
    } else {
      // Informa al usuario que hubo un error al descargar el PDF
      showErrorDialog(context, 'Error al descargar el PDF.');
    }
  } else {
    // Para otros tipos de archivos (SVG, JPG, PNG), muestra directamente en un modal como antes
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (url.endsWith('.svg')) {
          return Dialog(child: SvgPicture.network(url));
        } else {
          return Dialog(child: Image.network(url));
        }
      },
    );
  }
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
