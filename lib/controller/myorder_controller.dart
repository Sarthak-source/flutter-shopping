import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class MyOrderController extends GetxController{

  PageController pageController = PageController();
  RxInt selectedBtn = 0.obs;
  final RxList<bool> selectedFilter = <bool>[true, false, false, false].obs;
  final PagingController<int, dynamic> pagingController =
  PagingController(firstPageKey: 1);
}