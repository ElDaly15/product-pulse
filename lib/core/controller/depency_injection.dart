import 'package:get/get.dart';
import 'package:product_pulse/core/controller/internet_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
