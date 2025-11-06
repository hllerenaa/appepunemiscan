import 'package:appepunemiscan/src/widget/extends_files.dart';
import 'package:get/get.dart';
import 'package:appepunemiscan/src/pages/profile/about_screen.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final List<Map> List1 = [
    {
      "image": Images.profileBlankIcon,
      "text": "Personal info",
      "onTap": () {},
    },
  ];

  List<Map> getList2(BuildContext context) {
    return [
      {
        "image": Images.aboutImage,
        "text": "Acerca de",
        "onTap": () {
          Get.to(() => AboutScreen());
        },
      },
      {
        "image": Images.logOutImage,
        "text": "Cerrar Sesión",
        "onTap": () {
          Get.defaultDialog(
            backgroundColor: ColorResources.white,
            contentPadding: EdgeInsets.zero,
            title: "",
            titlePadding: EdgeInsets.zero,
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  boldText("", ColorResources.blue1D3, 18),
                  SizedBox(height: 10),
                  regularText(
                      "Siempre puede acceder a su contenido volviendo a iniciar sesión",
                      ColorResources.grey6B7,
                      16,
                      TextAlign.center),
                  SizedBox(height: 20),
                  Divider(color: ColorResources.greyEDE, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child:
                            regularText("Cancelar", ColorResources.blue1D3, 16),
                      ),
                      SizedBox(width: 30),
                      const SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: ColorResources.greyEDE,
                          thickness: 1,
                          indent: 10,
                          endIndent: 0,
                          width: 20,
                        ),
                      ),
                      SizedBox(width: 30),
                      InkWell(
                        onTap: () async {
                          await JWTService().logout();
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: mediumText(
                            "Cerrar Sesión", ColorResources.redD90, 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List2 = getList2(context);
    return Scaffold(
      backgroundColor: ColorResources.white,
      appBar: AppBar(
        backgroundColor: ColorResources.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: boldText("Perfil", ColorResources.black0F1, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: ColorResources.blue1D3,
                      child: ClipOval(
                        child: ImageFile(
                          imagePath: "${context.userPhoto}",
                          isNetworkImage: true, // Es una imagen de la red
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              boldText("Información Personal", ColorResources.blue1D3, 16),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ColorResources.greyF3F, width: 1),
                  color: ColorResources.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          boldText("Nombres", ColorResources.grey6B7, 14),
                          SizedBox(height: 10),
                          boldText("Apellidos", ColorResources.grey6B7, 14),
                          SizedBox(height: 10),
                          boldText("Celular", ColorResources.grey6B7, 14),
                          SizedBox(height: 10),
                          boldText("Email", ColorResources.grey6B7, 14),
                          SizedBox(height: 10),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 10),
                          boldText(context.userFirstName,
                              ColorResources.blue1D3, 14),
                          SizedBox(height: 10),
                          boldText(
                              context.userLastName, ColorResources.blue1D3, 14),
                          SizedBox(height: 10),
                          boldText(
                              context.userCelular, ColorResources.blue1D3, 14),
                          SizedBox(height: 10),
                          boldText(
                              context.userEmail, ColorResources.blue1D3, 14),
                          SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              Divider(thickness: 1, color: ColorResources.greyF3F),
              ListView.builder(
                itemCount: List2.length,
                padding: EdgeInsets.only(top: 25, left: 10, right: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: List2[index]["onTap"],
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: Offset(0, 0),
                            color: ColorResources.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: ColorResources.greyF6F,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              List2[index]["image"],
                            ),
                          ),
                        ),
                        title: mediumText(
                            List2[index]["text"], ColorResources.blue1D3, 16),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: ColorResources.grey6B7, size: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
