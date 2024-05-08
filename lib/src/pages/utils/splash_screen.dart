import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appepunemiscan/src/utils/colors.dart';
import 'package:appepunemiscan/src/utils/images.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,  // This makes the image cover the entire screen
                ),
              ),
            ),
            // Centered image with size adjusted to screen dimensions
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double screenWidth = constraints.maxWidth;
                double screenHeight = constraints.maxHeight;

                return Center(
                  child: Image.asset(
                    'assets/images/eplogoblanco.png',
                    width: screenWidth * 0.5,  // 50% of screen width
                    height: screenHeight * 0.25,  // 25% of screen height
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


// @override
//  Widget build(BuildContext context) {
//   return Scaffold(
//   backgroundColor: ColorResources.white,
//   body: Center(
//     child: SvgPicture.asset(Images.gpayLog),
//    ),
//  );
// }
}
