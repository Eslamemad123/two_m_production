import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:two_m_production/core/utils/colors.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85), // خلفية رمادي غامق شفاف
      body: SafeArea(
        child: Stack(
          children: [
            PhotoView(
              imageProvider: AssetImage(image),
              backgroundDecoration: const BoxDecoration(
                color: Color.fromARGB(138, 231, 234, 241),
              ),
            ),

            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
