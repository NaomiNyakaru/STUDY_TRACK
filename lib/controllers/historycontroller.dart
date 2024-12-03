import 'package:get/get.dart';

class Historycontroller extends GetxController{
  var historyList = [].obs;
  
  updateHistoryList(list){
    historyList.value = list;
  }
}