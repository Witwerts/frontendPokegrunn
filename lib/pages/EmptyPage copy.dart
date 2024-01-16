import 'package:flutter/material.dart';
import '../models/NavigationPage.dart';

class EmptyPage extends NavigationPage  {
  EmptyPage();

  @override
  Widget getWidget(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }
}