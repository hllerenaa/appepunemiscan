import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appepunemiscan/src/models/user_singleton.dart';
import 'package:appepunemiscan/src/helpers/globals.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class JWTService {
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }

  Future<Map<String, dynamic>> decodePayload(String token) async {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Token inválido');
    }
    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);
    return payloadMap;
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    return token != null &&
        token
            .isNotEmpty; // Aquí también puedes validar la expiración del token si lo necesitas.
  }

  Future<void> logout() async {
    // Aquí se elimina el token de SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');

    // Ahora, limpia el singleton del usuario
    UserSingleton.instance.clear();
  }

  Future<bool> isTokenExpired(String token) async {
    try {
      final payloadMap = await decodePayload(token);
      if (payloadMap.containsKey('exp')) {
        final int expirationTimestamp = payloadMap['exp'];
        final DateTime expirationDate =
            DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);
        print(expirationTimestamp);
        print(expirationDate);
        return DateTime.now().isAfter(expirationDate);
      }
      return true; // Si no hay información de expiración en el token, considera caducado.
    } catch (e) {
      return true; // Si ocurre un error al decodificar, considera caducado.
    }
  }
}

extension AuthExtension on BuildContext {
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> verifySessionAndRedirectIfNecessary() async {
    final jwtService = JWTService();

    try {
      // Verificar disponibilidad del internet
      if (!await checkInternetConnection()) {
        Navigator.of(this)
            .pushReplacementNamed('/nointernet'); // Página sin conexión
        return;
      }

      // Verificar disponibilidad de la URL
      try {
        await http.get(Uri.parse(urlConsumo));
      } catch (e) {
        Navigator.of(this).pushReplacementNamed('/mantenimiento');
        return;
      }

      final isAuthenticated = await jwtService.isAuthenticated();

      if (!isAuthenticated) {
        Navigator.of(this).pushReplacementNamed('/login');
        return;
      }

      final token = await jwtService.getToken();
      if (token == null) {
        Navigator.of(this).pushReplacementNamed('/login');
        return;
      }

      final isExpired = await jwtService.isTokenExpired(token);

      if (isExpired) {
        Navigator.of(this).pushReplacementNamed('/login');
        return;
      }
    } catch (e) {
      Navigator.of(this)
          .pushReplacementNamed('/mantenimiento'); // Página de error general
      return;
    }
  }
}
