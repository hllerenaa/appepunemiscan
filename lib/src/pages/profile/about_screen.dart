import 'package:appepunemiscan/src/widget/extends_files.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({Key? key}) : super(key: key);
  final List<Map> aboutList = [
    {
      "image": Images.softwareLicensesImage,
      "text": "Todos los derechos reservados",
    },
    {
      "image": Images.aboutImage,
      "text": "Version ${version}\n(validador_qr_ister)",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
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
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: ColorResources.black,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
        title: boldText("Acerca de", ColorResources.blue1D3, 20),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 40),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: aboutList.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: ListTile(
            leading: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorResources.greyF6F,
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(aboutList[index]["image"]),
              ),
            ),
            title: mediumText(
                aboutList[index]["text"], ColorResources.blue1D3, 16),
          ),
        ),
      ),
    );
  }
}
