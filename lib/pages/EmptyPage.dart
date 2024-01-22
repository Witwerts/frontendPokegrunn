import 'package:flutter/material.dart';
import '../models/NavigationPage.dart';

class EmptyPage extends NavigationPage  {
  const EmptyPage({super.key});

  @override
  Widget getWidget(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }
}