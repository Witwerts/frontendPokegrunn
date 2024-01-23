import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pokegrunn/widgets/CarouselList.dart';
import 'package:pokegrunn/views/BoxContainer.dart';

class CarouselView extends StatefulWidget {
  final List<CarouselList> items;
  final double height;

  CarouselView({
    super.key,
    required this.height,
    required this.items,
  });

  @override
  State<StatefulWidget> createState() => CarouselViewState();
}

class CarouselViewState extends State<CarouselView>{
  int index = 0;

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Column(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return CarouselSlider(
                    items: widget.items,
                    options: CarouselOptions(
                      height: widget.height,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: true,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                      initialPage: index,
                      onPageChanged: (index, reason){
                        setState(() {
                          this.index = index;
                        });
                      }
                    ),
                  );
                }
              ),
              const SizedBox(height: 2,),
              DotsIndicator(
                dotsCount: widget.items.length,
                position: index,
                decorator: DotsDecorator(
                  shape: const Border(),
                  activeShape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  size: Size(10, 10),
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}