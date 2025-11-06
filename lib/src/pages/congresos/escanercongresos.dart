import 'package:appepunemiscan/src/widget/extends_files.dart';
import 'package:appepunemiscan/src/services/escanear_congreso_model.dart';

class EscanerCongresosPage extends StatefulWidget {
  final String titulo;

  EscanerCongresosPage({required this.titulo});

  @override
  _EscanerCongresosPageState createState() => _EscanerCongresosPageState();
}

class _EscanerCongresosPageState extends State<EscanerCongresosPage> {
  Future<void> _refreshData() async {
    // Simular una pausa de 1 segundo para mostrar el indicador de recarga
    await Future.delayed(Duration(seconds: 0));

    // Navegar a una nueva instancia de la página actual
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            EscanerCongresosPage(titulo: widget.titulo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/menu');
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorResources.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorResources.greyE5E, width: 1),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: ColorResources.black,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
          title: boldText("Validador Congresos", ColorResources.black0F1, 20),
        ),
        backgroundColor: ColorResources.white,
        body: Padding(
          padding: EdgeInsets.only(top: 5, left: 30, right: 30),
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 40),
                        Text(
                          widget.titulo,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ), // Espacio entre el Row y el Icon
                        const Icon(
                          Icons.qr_code_2_sharp,
                          color: Color(0xFF282828),
                          size: 250,
                        ),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            EscanerCongresosModel(context.userId)
                                .scanQRCode(context);
                          },
                          child: Container(
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorResources.orangeFB9,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 16,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                  color: ColorResources.white,
                                ),
                              ],
                              border: Border.all(
                                color: ColorResources.white,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.qr_code_2_sharp,
                                  color: ColorResources.white,
                                  size: 30,
                                ),
                                SizedBox(width: 2),
                                mediumText(
                                  "Validar Codigo",
                                  ColorResources.white,
                                  16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
