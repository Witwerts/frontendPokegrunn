import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/AchievementModel.dart';
import 'package:pokegrunn/models/CarouselItem.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/pages/AchievementOverview.dart';
import 'package:pokegrunn/views/BoxContainer.dart';
import 'package:provider/provider.dart';

class CarouselListItem extends StatelessWidget {
  final CarouselItem item;
  final EdgeInsets margin;

  const CarouselListItem(this.item, [this.margin = EdgeInsets.zero]);

  @override
  Widget build(BuildContext context) {
    NavigationController navController =
        Provider.of<NavigationController>(context);

    return Container(
      width: double.infinity,
      height: 80,
      margin: margin,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
          width: 1.0,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey.withOpacity(0.2),
              ),
              child: ClipOval(
                child: OverflowBox(
                  child: Center(
                    child: item.icon != null || item.icon == ""
                        ? Container(
                            margin: const EdgeInsets.all(6.0),
                            child: Image.network(
                              item.icon ?? "",
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.image_not_supported, // Use your fallback icon here
                            size: 40.0,
                            color: Colors.grey,
                          ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AchievementOverview(
                    achievement: item as AchievementModel,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 4.0,
                ),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title ?? '',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                        overflow: TextOverflow.ellipsis,
                        color: MainApp.color3,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.desc ?? '',
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 14.0,
                          height: 1.1,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}