import 'package:get/get.dart';

import '../controllers/passbook_details_controller.dart';

class PassbookDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PassbookDetailsController>(
      () => PassbookDetailsController(),
    );
  }
}
