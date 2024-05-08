import 'package:get/get.dart';
import 'package:appepunemiscan/src/widget/extends_files.dart';
import 'package:appepunemiscan/src/widget/rout_controller.dart';
import 'package:appepunemiscan/src/pages/profile/profile.dart';
import 'graduaciones/escaneartaller.dart';


class RoutScreen extends StatelessWidget {
  final RoutController routController = Get.put(RoutController());

  final pages = [EscanerGraduadosPage(titulo: "JORNADAS ACADEMICAS"), ProfilePage()];

  buildMyNavBar(BuildContext context) {
    // USAR ESTA FUNCION UNICAMENTE CUANDO LA PAGINA NO SE DIBUJE POR RUTA Y NO ESTE USANDO EL AUTHMIDLEWARE
    context.verifySessionAndRedirectIfNecessary();
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: ColorResources.white,
          borderRadius: BorderRadius.circular(70),
          boxShadow: [
            BoxShadow(
              blurRadius: 60,
              spreadRadius: 0,
              offset: Offset(0, 4),
              color: ColorResources.black.withOpacity(0.25),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(
              () => Column(
                children: [
                  IconButton(
                    enableFeedback: true,
                    onPressed: () {
                      routController.pageIndex.value = 0;
                      print(routController.pageIndex.value);
                    },
                    icon: routController.pageIndex.value == 0
                        ? const Icon(
                            Icons.qr_code_2_sharp,
                            color: ColorResources.naranja,
                            size: 40,
                          )
                        : // Espacio entre el Row y el Icon
                        const Icon(
                            Icons.qr_code_2_sharp,
                            color: ColorResources.grey6B7,
                            size: 40,
                          ),
                  ),
                  routController.pageIndex.value == 0
                      ? boldText("Ingreso Campus", ColorResources.naranja, 12)
                      : regularText(
                          "Ingreso Campus", ColorResources.grey6B7, 11),
                ],
              ),
            ),
            Obx(
              () => Column(
                children: [
                  IconButton(
                    enableFeedback: true,
                    onPressed: () {
                      routController.pageIndex.value = 1;
                    },
                    icon: routController.pageIndex.value == 1
                        ? SvgPicture.asset(Images.profileFillIcon)
                        : SvgPicture.asset(Images.profileBlankIcon),
                  ),
                  routController.pageIndex.value == 1
                      ? boldText("Perfil", ColorResources.naranja, 12)
                      : regularText("Perfil", ColorResources.grey6B7, 11),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            pages[routController.pageIndex.value],
            buildMyNavBar(context),
          ],
        ),
      ),
    );
  }
}
