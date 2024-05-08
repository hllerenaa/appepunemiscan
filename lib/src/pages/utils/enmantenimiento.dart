import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appepunemiscan/src/utils/colors.dart';
import 'package:appepunemiscan/src/utils/common_widget.dart';
import 'package:appepunemiscan/src/utils/images.dart';

class MantenimientoPage extends StatelessWidget {
  MantenimientoPage({Key? key}) : super(key: key);

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
                Images.EnMantenimiento,
                height: 220,
                width: 250,
              )),
              Column(
                children: [
                  regularText(
                      "Estamos en mantenimiento", ColorResources.blue1D3, 20),
                  SizedBox(height: 8),
                  Center(
                    child: regularText(
                        "Agredecemos su comprensión y pedimos disculpas por las molestias ocasionadas",
                        ColorResources.grey6B7,
                        16,
                        TextAlign.center),
                  ),
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
