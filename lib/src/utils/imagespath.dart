import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class ImageFile extends StatelessWidget {
  final dynamic imagePath;
  final bool isNetworkImage;

  const ImageFile({required this.imagePath, this.isNetworkImage = false});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _loadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // return Center(
          //   child: CircularProgressIndicator(
          //     strokeWidth: 3.0,
          //     valueColor: AlwaysStoppedAnimation<Color>(
          //       Color.fromARGB(255, 67, 70, 221),
          //     ),
          //     backgroundColor: Colors.grey,
          //   ),
          // );

          return LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: constraints.maxWidth,  // Ajusta al ancho del contenedor padre
                    height: constraints.maxHeight,  // Ajusta a la altura del contenedor padre
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),  // Ajusta según tus necesidades
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              );
            },
          );

        } else if (snapshot.hasError || !snapshot.hasData) {
          return Icon(Icons.error);
        } else {
          return snapshot.data!;
        }
      },
    );
  }

  Future<Widget> _loadImage() async {
    try {
      if (isNetworkImage) {
        final response = await http.get(Uri.parse(imagePath));
        if (response.statusCode == 200) {
          // return CachedNetworkImage(
          //   imageUrl: imagePath,
          //   fit: BoxFit.cover,
          //   placeholder: (context, url) => CircularProgressIndicator(),
          //   errorWidget: (context, url, error) => Icon(Icons.error),
          // );
          return CachedNetworkImage(
            imageUrl: imagePath,
            fit: BoxFit.cover,
            placeholder: (context, url) => LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: constraints.maxWidth,  // Ajusta al ancho del contenedor padre
                      height: constraints.maxHeight,  // Ajusta a la altura del contenedor padre
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),  // Ajusta según tus necesidades
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                );
              },
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );


        }
      } else {
        return Image.asset(
          imagePath,
          fit: BoxFit.cover,
        );
      }
    } catch (e) {
      print('Error loading image: $e');
    }
    return Icon(Icons.error);
  }
}
