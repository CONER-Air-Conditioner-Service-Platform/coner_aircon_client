import 'package:flutter/material.dart';

class TabBarProvider with ChangeNotifier {
  late TabController tabController;
  void setController(TabController tabController) {
    this.tabController = tabController;
  }

  void setIndex(int index) {
    tabController.index = index;
    notifyListeners();
  }
}
