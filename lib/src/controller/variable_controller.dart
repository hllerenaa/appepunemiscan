import 'package:get/get.dart';

class VariableController extends GetxController{
  // ignore: prefer_typing_uninitialized_variables
  var selectedIndex;

  onIndexChange(index) {
    selectedIndex = index;
    update();
  }
  var switchIsOpen = true.obs;
  var arrowClick1 = false.obs;
  var arrowClick2 = false.obs;
  var arrowClick3 = false.obs;
  var isScratch = false.obs;
}