import 'package:get/get.dart';

class Dashboardcontroller extends GetxController{
  var selectedMenu = 0.obs;

  updateSelectedMenu(pos) => selectedMenu.value = pos;
}