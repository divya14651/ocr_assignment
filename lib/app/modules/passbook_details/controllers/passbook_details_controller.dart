import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_assignment/model/passbook_model.dart';
import 'package:ocr_assignment/services/passbook_service.dart';
import 'package:ocr_assignment/services/ocr_service.dart';

class PassbookDetailsController extends GetxController {

  final picker = ImagePicker();

  RxBool isLoading = true.obs;
  RxString imagePath = "".obs;
  RxString errorMessage = "".obs;

  Rx<PassbookHeader?> header = Rx<PassbookHeader?>(null);
  RxList<Transaction> transactions = <Transaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  String safeText(String? value) {
    if (value == null ||
        value.isEmpty ||
        value == "Not Found") {
      return "N/A";
    }
    return value;
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = "";

    try {
      final image = Get.parameters["image"] ?? "";

      if (image.isEmpty) {
        errorMessage.value = "No image provided.";
        return;
      }

      imagePath.value = image;

      final text = await OCRService.extractText(image);

      if (text.trim().isEmpty) {
        errorMessage.value =
        "OCR could not detect any text. Please scan a clearer image.";
        return;
      }

      final result = PassbookParserService.parse(text);

      if (result.header.accountNumber == "Not Found") {
        errorMessage.value =
        "Could not find a valid Account Number.";
        return;
      }

      header.value = result.header;
      transactions.value = result.transactions;

    } catch (e) {
      errorMessage.value =
      "An unexpected error occurred during scanning.";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clickAnother() async {
    final XFile? image =
    await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    Get.offNamed(
      Get.currentRoute,
      parameters: {"image": image.path},
    );
  }
}