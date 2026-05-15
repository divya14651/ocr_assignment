import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_assignment/model/card_model.dart';
import 'package:ocr_assignment/services/ocr_service.dart';
import 'package:ocr_assignment/services/card_parser_service.dart';

class CardDetailsController extends GetxController {
  final picker = ImagePicker();

  RxBool isLoading = true.obs;
  Rx<CardModel?> card = Rx<CardModel?>(null);
  RxString errorMessage = "".obs;
  RxString imagePath = "".obs;

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

  String maskNumber(String? num) {
    if (num == null ||
        num.isEmpty ||
        num == "Not Found") return "N/A";

    if (num.length < 4) return num;

    return "XXXX XXXX XXXX ${num.substring(num.length - 4)}";
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = "";

    final image = Get.parameters["image"] ?? "";

    if (image.isEmpty) {
      errorMessage.value = "No image found.";
      isLoading.value = false;
      return;
    }

    imagePath.value = image;

    try {
      final text = await OCRService.extractText(image);

      if (text.trim().isEmpty) {
        errorMessage.value =
        "OCR could not read text. Try a clearer photo.";
        return;
      }

      final result = CardParserService.parseCard(text);

      if (!result.isValid) {
        errorMessage.value =
        "Invalid Card: Luhn check failed or number not found.";
        return;
      }

      card.value = CardModel(
        imagePath: image,
        holderName: result.holderName,
        cardNumber: result.cardNumber,
        expiryDate: result.expiryDate,
        isValid: result.isValid,
      );

    } catch (e) {
      errorMessage.value = "Scanning failed. Please try again.";
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