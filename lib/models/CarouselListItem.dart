import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokegrunn/models/CarouselItem.dart';
import 'package:pokegrunn/views/BoxContainer.dart';

class CarouselListItem extends StatelessWidget {
  final CarouselItem item;

  const CarouselListItem(
    this.item,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.zero,
      color: Colors.red,
    );
  }
}