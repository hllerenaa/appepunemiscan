import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appepunemiscan/src/utils/colors.dart';
import 'package:appepunemiscan/src/utils/common_widget.dart';
import 'package:appepunemiscan/src/utils/images.dart';

class NoInternetPage extends StatelessWidget {
  NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      appBar: AppBar(
        backgroundColor: ColorResources.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: boldText("", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Container(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                  child: SvgPicture.asset(
                Images.NoInternetPage,
                height: 200,
                width: 225,
              )),
              Column(
                children: [
                  regularText(
                      "No puedes acceder a la aplicación sin conexión a Internet.",
                      ColorResources.blue1D3,
                      20),
                  SizedBox(height: 8),
                  regularText(
                      "Por favor, verifica tus datos móviles o tu conexión WiFi y vuelve a intentarlo.",
                      ColorResources.grey6B7,
                      16),
                ],
              ),
              containerButton(() async {
                Navigator.of(context).pushReplacementNamed('/menu');
              }, "Volver a intentar"),
            ],
          ),
        ),
      ),
    );
  }
}
