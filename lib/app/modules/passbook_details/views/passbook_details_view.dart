import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/passbook_details_controller.dart';
import 'package:ocr_assignment/common/common_widget.dart';

class PassbookDetailsView extends GetView<PassbookDetailsController> {
  const PassbookDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.commonAppBar(
        title: "Passbook Details",
        onBack: () => Get.back(),
      ),
      body: Obx(() {

        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xff8B0021),
            ),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: controller.clickAnother,
                    child: Text("Try Again"),
                  ),
                ],
              ),
            ),
          );
        }

        final header = controller.header.value;

        return Column(
          children: [

            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(controller.imagePath.value),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [

                  Text(
                    "Account Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 10),

                  if (header != null) ...[
                    CommonWidgets.infoTile("Account", controller.safeText(header.accountNumber),),
                    CommonWidgets.infoTile("IFSC", controller.safeText(header.ifsc),),
                    CommonWidgets.infoTile("Bank", controller.safeText(header.bankName),),
                    CommonWidgets.infoTile("Branch", controller.safeText(header.branchName),),
                  ],

                  SizedBox(height: 20),

                  Text(
                    "Transactions",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  if (controller.transactions.isEmpty)
                    Text("No transactions found in this scan.")
                  else
                    ...controller.transactions.map((t) {
                      return Card(
                        margin: EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Icon(
                            Icons.receipt_long,
                            color: Color(0xff8B0021),
                          ),
                          title: Text(controller.safeText(t.description)),
                          subtitle: Text(controller.safeText(t.date)),
                          trailing: Text(
                            controller.safeText(t.amount),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }),

                  SizedBox(height: 20),

                  CommonWidgets.commonElevatedButton(
                    text: "Scan Another Document",
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