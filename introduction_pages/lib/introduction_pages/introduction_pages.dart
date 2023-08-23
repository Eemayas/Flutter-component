// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'pages_list.dart';

class IntroductionPages extends StatefulWidget {
  static String id = "IntroductionPages";
  const IntroductionPages({super.key});

  @override
  State<IntroductionPages> createState() => _IntroductionPagesState();
}

class _IntroductionPagesState extends State<IntroductionPages> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          PageView(controller: _pageController, children: pagesList),

          //dot indicatore
          Container(
            alignment: Alignment(0, 0.8),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: pagesList.length,
            ),
          )
        ]),
      ),
    );
  }
}
