import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ocr_assignment/common/theme/color.dart';

import '../../../../common/common_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  "OCR Scanner",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8B0021),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Scan and extract data from cards and bank passbooks",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 40),

              Center(
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Image.asset(
                      "assets/home.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Spacer(),
              CommonWidgets.commonElevatedButton(
                text: "Scan Card",
                prefixIcon: Icon(
                  Icons.credit_card,
                  color: Colors.white,
                ),
                backgroundColor: AppColors.primary,
                onPressed: () {
                  controller.clickOnCard();
                },
              ),

              SizedBox(height: 16),

              CommonWidgets.commonElevatedButton(
                text: "Scan Passbook",
                prefixIcon: Icon(
                  Icons.account_balance,
                  color: Colors.white,
                ),
                backgroundColor: AppColors.secondary,
                onPressed: () {
                  controller.clickOnPassBook();
                },
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}