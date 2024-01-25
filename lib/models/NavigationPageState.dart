import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/AnimationManager.dart';
import 'package:pokegrunn/models/NavigationPage.dart';

class NavigationPageState<T extends NavigationPage> extends State<T> with TickerProviderStateMixin {
  late AnimationManager animationManager;

  NavigationPageState(){
    animationManager = AnimationManager(this);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context){
    //return widget.getWidget(context);
    return Container();
  }

  @override
  void dispose(){
    super.dispose();
  }
}
