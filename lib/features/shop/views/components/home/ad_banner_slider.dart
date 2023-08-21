import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/config/app_images.dart';

class AdBannerSlider extends StatefulWidget {

  List<String> ads;

  AdBannerSlider({super.key, required this.ads });

  _AdBannerSliderState createState() => _AdBannerSliderState();
}

class _AdBannerSliderState extends State<AdBannerSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), _handleTimer);
  }

  void _handleTimer(Timer timer) {
    if (_currentPage < widget.ads.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      _pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          alignment: Alignment.center,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.w),
            color: AppTheme.neutral100
          ),
          height: 200, // Adjust the height as needed
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.ads[index],
                placeholder: (context, url) => Center(child: SvgPicture.asset(AppImages.photo,width: 15.w,height: 15.w,)),
                errorWidget: (context, url, error) => Center(child: SvgPicture.asset(AppImages.photo,width: 15.w,height: 15.w,)),
                fit: BoxFit.cover,
              );
            },
            itemCount: widget.ads.length,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: .5.h),
          child: SmoothPageIndicator(
              controller: _pageController,  // PageController
              count:  widget.ads.length,
              effect: SlideEffect(
                  spacing:  8.0,
                  radius:  100.w,
                  dotWidth:  7,
                  dotHeight:  7,

                  dotColor:  AppTheme.primary100,
                  activeDotColor:  AppTheme.primary900
              ),
          ),
        )
      ],
    );
  }
}