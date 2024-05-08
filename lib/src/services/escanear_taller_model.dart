import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:appepunemiscan/src/widget/extends_files.dart';

import '../utils/funciones.dart';

void openModal(BuildContext context, Map<String, dynamic> data) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 600,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                convertToUtf8(data['taller']), // Display 'taller' as title
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                convertToUtf8(data['nombre']),
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            if (data['tienesaldo']) ...[ // If 'tienesaldo' is true
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Saldo: ${data['saldo']}',
                  style: TextStyle(fontSize: 16, color: Colors.red), // Display 'saldo' in red
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Acceso restringido porque estudiante refleja deuda pendiente',
                  style: TextStyle(fontSize: 16, color: Colors.red), // Display message in red
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                data['cedula'],
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                data['message'],
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            // Widget animado según el valor de data['activo']
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data['activo'] ? Colors.green : Colors.red,
              ),
              child: Icon(
                data['activo'] ? Icons.check : Icons.close,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cerrar'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFC7E00), // Color del botón
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}


class EscanearGraduadosModel extends ChangeNotifier {
  final FocusNode unfocusNode = FocusNode();
  String? scan = '0';
  int? idpersona = 0;

  EscanearGraduadosModel(this.idpersona);

  Future<void> scanQRCode(BuildContext context) async {
    scan = await FlutterBarcodeScanner.scanBarcode(
      '#fc7e00', // scanning line color
      'Cancelar', // cancel button text
      true, // whether to show the flash icon
      ScanMode.QR,
    );

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Make HTTP request and show Sweet Alert
    try {
      final response = await BackendService.get(
          '${urlConsumo}/apimobile/v1/ingresojornadas/',
          params: {
            'qr': "${scan}",
            'id': "${idpersona}",
            'action': 'validateCode'
          });

      if (response['success']) {
        Navigator.pop(context); // Close the loading indicator dialog
        final persona_ = response['aData'];
        print(persona_);
        // ignore: use_build_context_synchronously
        openModal(context, {
          'tipo': persona_['tipo'],
          'nombre': persona_['fullName'],
          'cedula': persona_['documento'],
          'taller': persona_['taller'],
          'tienesaldo': persona_['tienesaldo'],
          'saldo': persona_['saldo'],
          'message': response['msg'],
          'activo': response['acceso'],
        });
      } else {
        Navigator.pop(context); // Close the loading indicator dialog

        // ignore: use_build_context_synchronously
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          confirmBtnText: 'Listo',
          title: 'Oops...',
          text: convertToUtf8(response['msg']),
        );
      }
    } catch (e) {
      Navigator.pop(context); // Close the loading indicator dialog

      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        confirmBtnText: 'Listo',
        title: 'Oops...',
        text: 'Error al obtener datos: $e',
      );
    }

    notifyListeners();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    super.dispose();
  }
}
