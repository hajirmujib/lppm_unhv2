import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lppm_unhv2/view/homeView.dart';

class BottomBarC extends GetxController {
  final PageController pageController = PageController();
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeView();

  var currentIndex = 0.obs;
  void indexSelect({int index}) {
    pageController.jumpToPage(index);
  }

  void indexChange({int index}) {
    currentIndex(index);
  }

  void pageSelect({Widget index}) {
    currentScreen = index;
  }
}
