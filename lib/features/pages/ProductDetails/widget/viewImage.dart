import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85), // خلفية رمادي غامق شفاف
      body: Stack(
        children: [
          PhotoView(
            imageProvider: AssetImage(image),
            backgroundDecoration: const BoxDecoration(
              color: Color.fromARGB(138, 231, 234, 241),
            ),
          ),

          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}
