import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:two_m_production/core/routes/navigation.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/ProductDetails/widget/viewImage.dart';

// ignore: must_be_immutable
class PhotosProductDetails extends StatefulWidget {
  PhotosProductDetails({super.key, required this.images});
  List<dynamic> images;
  @override
  State<PhotosProductDetails> createState() => _PhotosProductDetailsState();
}

class _PhotosProductDetailsState extends State<PhotosProductDetails> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Gap(10), Curouse_Slider(), Gap(10), Smooth_Effect()],
    );
  }

  SmoothPageIndicator Smooth_Effect() {
    return SmoothPageIndicator(
      controller: PageController(initialPage: currentIndex), // PageController
      count: widget.images.length,
      effect: ExpandingDotsEffect(
        dotWidth: 7,
        dotHeight: 7,
        spacing: 7,
        dotColor: AppColors.gray400,
        activeDotColor: AppColors.primary,
        expansionFactor: 5,
      ), // your preferred effect
      onDotClicked: (index) {},
    );
  }

  CarouselSlider Curouse_Slider() {
    return CarouselSlider.builder(
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Padding(
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  pushTo(
                    context,
                    Routes.viewImage,
                    widget.images[currentIndex],
                  );
                },
                child: Image.asset(
                  widget.images[currentIndex],
                  width: 300,
                  height: 300,
                ),
              ),
            ),
          ),
      itemCount: widget.images.length,
      options: CarouselOptions(
        height: 290,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
        onPageChanged: (int index, CarouselPageChangedReason reason) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
