import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';

class AnimationManager {
  NavigationPageState widgetState;

  AnimationManager(this.widgetState);

  AnimationController createController(int duration){
    AnimationController controller = AnimationController(
      vsync: widgetState,
      duration: Duration(milliseconds: duration)
    );

    return controller;
  }

  Animation runAnimation(Tween tween, int duration, {void Function()? onUpdate}){
    AnimationController controller = createController(duration);
    Animation animation = tween.animate(controller);

    if(onUpdate != null){
      controller.addListener(() {
        onUpdate();
      });
    }

    controller.forward().then((value) => {
      controller.dispose()
    });

    return animation;
  }

  Future<bool> runTweens(List<Tween> tweens, int duration, {void Function()? onUpdate}) async {
    AnimationController controller = createController(duration);

    bool result = false;

    try {
      for(Tween tween in tweens){
        tween.animate(controller);
      }

      await controller.forward();

      result = true;
    } catch (error) {
      result = false;
    }

    controller.dispose();

    return result;
  }
}