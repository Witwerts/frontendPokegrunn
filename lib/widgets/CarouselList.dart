import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokegrunn/models/CarouselItem.dart';
import 'package:pokegrunn/widgets/CarouselListItem.dart';
import 'package:pokegrunn/views/BoxContainer.dart';

class CarouselList extends StatefulWidget {
  final String? title;
  final String? icon;
  final List<dynamic> items;

  CarouselList({
    super.key,
    required this.title,
    required this.items,
    this.icon,
  });
  
  @override
  State<StatefulWidget> createState() => CarouselListState();
}

class CarouselListState extends State<CarouselList> {
  @override
  Widget build(BuildContext context){
    return BoxContainer(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Stack(
            children: [
              Align (
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: SvgPicture.asset(
                    'src/icons/map.svg',
                    height: 36,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(
                      widget.title ?? '',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  const Divider(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                    child: Column(
                      children: widget.items.map((item) {
                        bool isLast = widget.items.indexOf(item) == (widget.items.length-1);
                        return CarouselListItem(item, EdgeInsets.only(bottom: !isLast ? 4.0 : 0.0));
                      }).toList(),
                    )
                  ),
                ],
              )
            ],
          )
        ],
      )
    );
  }
}