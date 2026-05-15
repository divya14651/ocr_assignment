import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocr_assignment/app/modules/card_details/controllers/card_details_controller.dart';
import 'package:ocr_assignment/common/common_widget.dart';

class CardDetailsView extends GetView<CardDetailsController> {
  const CardDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.commonAppBar(
        title: "Card Details",
        onBack: () => Get.back(),
      ),
      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    size: 48, color: Colors.red),
                const SizedBox(height: 10),
                Text(controller.errorMessage.value),
                TextButton(
                  onPressed: controller.clickAnother,
                  child: const Text("Scan Again"),
                ),
              ],
            ),
          );
        }

        final data = controller.card.value;

        if (data == null) {
          return const Center(child: Text("No Data Found"));
        }

        return Column(
          children: [
            CommonWidgets.imageBox(data.imagePath),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    "Extracted Data",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                   Divider(),
                  CommonWidgets.infoTile("Card Holder", controller.safeText(data.holderName),),
                  CommonWidgets.infoTile("Card Number", controller.maskNumber(data.cardNumber),),
                  CommonWidgets.infoTile("Expiry Date", controller.safeText(data.expiryDate),),
                  SizedBox(height: 30),
                  CommonWidgets.commonElevatedButton(
                    text: "Scan Another",
                    onPressed: controller.clickAnother,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}