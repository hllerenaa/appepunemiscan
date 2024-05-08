import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class User {
  final int id;
  final String fullName;
  final String first_name;
  final String last_name;
  final String? email;
  final String? celular;
  final String photo;

  User({
    required this.id,
    required this.fullName,
    required this.first_name,
    required this.last_name,
    this.email,
    this.celular,
    required this.photo,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'celular': celular,
        'photo': photo,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        fullName: json['fullName'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        email: json['email'],
        celular: json['celular'],
        photo: json['photo'],
      );
}

class UserSingleton {
  // Crear una instancia privada del singleton
  static final UserSingleton _instance = UserSingleton._privateConstructor();

  // Constructor privado
  UserSingleton._privateConstructor();

  // Proveer una instancia pública para acceder al singleton
  static UserSingleton get instance => _instance;

  User? currentUser;

  Future<void> saveUserToPrefs() async {
    if (currentUser != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(currentUser!.toJson()));
    }
  }

  Future<void> loadUserFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString('user');
    if (userString != null) {
      currentUser = User.fromJson(jsonDecode(userString));
    }
  }

  void clear() {
    currentUser = null;
  }
}

extension UserContextExtensions on BuildContext {
  UserSingleton get userSingleton => UserSingleton.instance;

  User? get currentUser => userSingleton.currentUser;

  int? get userId => currentUser?.id;

  String? get userFullName => currentUser?.fullName;

  String? get userFirstName => currentUser?.first_name;

  String? get userLastName => currentUser?.last_name;

  String? get userEmail => currentUser?.email;

  String? get userCelular => currentUser?.celular;

  String? get userPhoto => currentUser?.photo;
}
