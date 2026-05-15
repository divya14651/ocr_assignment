import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_assignment/app/routes/app_pages.dart';

class HomeController extends GetxController {

  final ImagePicker picker = ImagePicker();

  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> clickOnCard() async {

    try {

      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
      );

      if (image == null) return;

      selectedImage.value = File(image.path);

      Get.toNamed(
        Routes.CARD_DETAILS,
        parameters: {
          "image": image.path,
          "type": "card",
        },
      );

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> clickOnPassBook() async {

    try {

      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
      );

      if (image == null) return;

      selectedImage.value = File(image.path);

      Get.toNamed(
        Routes.PASSBOOK_DETAILS,
        parameters: {
          "image": image.path,
          "type": "passbook",
        },
      );

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}