import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:appepunemiscan/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appepunemiscan/src/utils/colors.dart';
import 'package:appepunemiscan/src/utils/images.dart';
import 'package:appepunemiscan/src/utils/font_family.dart';
import 'package:appepunemiscan/src/utils/common_widget.dart';
import 'package:appepunemiscan/src/services/login_service.dart';
import 'package:appepunemiscan/src/widget/overlay.dart';
import 'package:appepunemiscan/src/helpers/globals.dart';
import 'package:appepunemiscan/src/utils/funciones.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginService _loginModel = LoginService();
  bool _isPasswordHidden = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Esto bloquea el botón de retroceso
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: ColorResources.greyF6F,
            body: GestureDetector(
              onTap: () {
                final FocusScopeNode focus = FocusScope.of(context);
                if (!focus.hasPrimaryFocus && focus.hasFocus) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
              },
              child: Padding(
                padding: EdgeInsets.only(top: 50, left: 24, right: 24),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Center(
                          child: lightText("Versión: 0.0.1",
                              ColorResources.blue1D3, 16, TextAlign.center),
                        ),
                        const SizedBox(height: 15),
                        Center(
                            child: Image.asset(
                          Images.welcomeImage,
                          height: 300,
                          width: 300,
                        )),
                        const SizedBox(height: 20),
                        boldText(
                            "Bienvenido a EPUNEMI", ColorResources.blue1D3, 24),
                        const SizedBox(height: 7),
                        lightText(
                            "Validador de Accesos Jornadas Academicas",
                            ColorResources.blue1D3,
                            16),
                        const SizedBox(height: 40),
                        Container(
                          height: 100,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _loginModel.usernameController,
                                cursorColor: ColorResources.blue1D3,
                                style: TextStyle(
                                  color: ColorResources.black,
                                  fontSize: 18,
                                  fontFamily: TextFontFamily.ROBOTO_REGULAR,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  // Solo permite dígitos
                                ],
                                // keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  prefixText: "   ",
                                  hintText: "Ingresa tu número de cédula",
                                  hintStyle: TextStyle(
                                    color: ColorResources.grey9CA,
                                    fontSize: 18,
                                    fontFamily: TextFontFamily.ROBOTO_REGULAR,
                                  ),
                                  filled: true,
                                  fillColor: ColorResources.greyE5E,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: ColorResources.greyE5E,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: ColorResources.greyE5E,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: ColorResources.greyE5E, // Cambiar el color cuando el campo esté enfocado
                                      width: 2, // También puedes cambiar el ancho si lo deseas
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        containerButton(() async {
                          if (_loginModel.usernameController.text.isEmpty) {
                            const SnackBar(
                              content: Text(
                                'Por favor, completa todos los campos',
                                style: TextStyle(
                                    color: Colors.white), // Texto blanco
                              ),
                              backgroundColor: Colors.orange, // Fondo naranja
                            );
                            // return;
                          }
                          setState(() {
                            _isLoading = true;
                          });
                          bool success =
                              await _loginModel.authenticateUser(context);
                          if (!success) {
                            FocusScope.of(context).unfocus();

                            setState(() {
                              _isLoading = false;
                            });
                            // En este punto, el modelo ya ha mostrado el snackbar de error.
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            // Navegar a la pantalla principal o cualquier otra acción que desees hacer
                          }
                        }, "Consultar"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading) LoadingOverlay(),
        ],
      ),
    );
  }
}
