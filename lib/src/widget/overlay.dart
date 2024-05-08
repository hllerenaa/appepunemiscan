import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.black.withOpacity(0.3), // Color con transparencia
        child: Center(
          child: CircularProgressIndicator(), // Indicador de carga
        ),
      ),
    );
  }
}
