import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:appepunemiscan/src/widget/extends_files.dart';

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
            const SizedBox(height: 16),

            // Nombre - SIN convertToUtf8, viene correcto del backend
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                data['nombre'] ?? 'Sin nombre',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 16),

            // Mostrar información de saldo
            if (data['tienesaldo'] == true) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Saldo: \$${data['saldo']}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  'Acceso restringido porque el estudiante refleja deuda pendiente',
                  style: TextStyle(fontSize: 15, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  '✓ Saldo al día',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],

            const SizedBox(height: 16),

            // Cédula
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'CI: ${data['cedula'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 8),

            // Mensaje - SIN convertToUtf8
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                data['message'] ?? '',
                style: const TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 16),

            // Icono de acceso permitido/denegado
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
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

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFC7E00),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text('Cerrar', style: TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}

class EscanerCongresosModel extends ChangeNotifier {
  final FocusNode unfocusNode = FocusNode();
  String? scan = '0';
  int? idpersona = 0;
  final MobileScannerController _scannerController = MobileScannerController();

  EscanerCongresosModel(this.idpersona);

  Future<void> scanQRCode(BuildContext context) async {
    // ✅ Guardar el context de la página principal
    final BuildContext parentContext = context;

    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Escanear QR'),
            backgroundColor: const Color(0xFFFC7E00),
            actions: [
              IconButton(
                icon: const Icon(Icons.flash_on),
                onPressed: () => _scannerController.toggleTorch(),
              ),
            ],
          ),
          body: MobileScanner(
            controller: _scannerController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && scan == '0') {
                scan = barcodes.first.rawValue ?? '0';
                Navigator.pop(context, scan);
              }
            },
          ),
        ),
      ),
    );

    // ✅ Procesar DESPUÉS con el context correcto
    if (result != null && result != '0') {
      await _processQRCode(parentContext);
    } else {
      scan = '0';
      notifyListeners();
    }
  }

  Future<void> _processQRCode(BuildContext context) async {
    // ✅ Verificar si está montado
    if (!context.mounted) {
      scan = '0';
      notifyListeners();
      return;
    }

    print('🔍 Procesando QR: $scan');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      final response = await BackendService.get(
        '${urlConsumo}/apimobile/v1/ingresocongresos/',
        params: {
          'qr': "$scan",
          'id': "$idpersona",
          'action': 'validateCode'
        },
      );

      print('✅ RESPUESTA BACKEND: $response');

      // ✅ Verificar después de operación asíncrona
      if (!context.mounted) {
        scan = '0';
        notifyListeners();
        return;
      }

      Navigator.pop(context);

      if (response['success'] == true) {
        final persona_ = response['aData'];

        if (context.mounted) {
          openModal(context, {
            'tipo': persona_['tipo'] ?? '',
            'nombre': persona_['fullName'] ?? 'Sin nombre',
            'cedula': persona_['documento'] ?? 'N/A',
            'tienesaldo': persona_['tienesaldo'] ?? false,
            'saldo': persona_['saldo']?.toString() ?? '0',
            'message': response['msg'] ?? '',
            'activo': response['acceso'] ?? false,
          });
        }
      } else {
        if (context.mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnText: 'Listo',
            title: 'Oops...',
            text: response['msg'] ?? 'Error al validar el código',
          );
        }
      }
    } catch (e, stackTrace) {
      print('💥 ERROR: $e');
      print('📍 Stack: $stackTrace');

      if (context.mounted) {
        try {
          Navigator.pop(context);
        } catch (_) {
          // Ignorar si ya está cerrado
        }

        if (context.mounted) {
          String errorMessage = 'Error al conectar con el servidor';

          if (e.toString().contains('SocketException')) {
            errorMessage = 'Sin conexión a Internet. Verifica tu conexión.';
          } else if (e.toString().contains('TimeoutException')) {
            errorMessage = 'El servidor tardó demasiado en responder.';
          } else if (e.toString().contains('FormatException')) {
            errorMessage = 'Error al procesar la respuesta del servidor.';
          }

          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnText: 'Listo',
            title: 'Error de Conexión',
            text: errorMessage,
          );
        }
      }
    } finally {
      scan = '0';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _scannerController.dispose();
    unfocusNode.dispose();
    super.dispose();
  }
}