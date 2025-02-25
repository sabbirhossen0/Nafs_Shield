import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs; // Observable variable

  void increment() => count++;
  void reset() {
    count.value=0;
  }
  void decrement() {
    if (count > 0) count--; // Prevent negative values
  }
}
