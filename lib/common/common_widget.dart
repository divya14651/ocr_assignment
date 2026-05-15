import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonWidgets {

  static PreferredSizeWidget commonAppBar({
    required String title,
    double? elevation,
    Color? backgroundColor,
    Color? iconColor,
    Color? textColor,
    bool centerTitle = true,
    VoidCallback? onBack,
  }) {
    return AppBar(
      elevation: elevation ?? 0,
      backgroundColor: backgroundColor ?? const Color(0xff8B0021),
      centerTitle: centerTitle,

      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),

      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: iconColor ?? Colors.white,
        ),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();

          if (onBack != null) {
            onBack();
          } else {
            Get.offAllNamed('/home');
          }
        },
      ),
    );
  }

  static Widget commonElevatedButton({
    double? height,
    double? width,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    double? elevation,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    Color? borderColor,
    TextStyle? textStyle,
    Widget? child,
    Widget? prefixIcon,
    bool isLoading = false,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 55,

      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
          FocusManager.instance.primaryFocus?.unfocus();
          onPressed();
        },

        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0,
          padding:
          contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16),

          backgroundColor:
          backgroundColor ??
              Theme.of(Get.context!).primaryColor,

          shadowColor: Colors.transparent,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? 14,
            ),

            side: BorderSide(
              color: borderColor ?? Colors.transparent,
            ),
          ),
        ),

        child: isLoading
            ? SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: Colors.white,
          ),
        )
            : child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon,
                  const SizedBox(width: 10),
                ],

                Text(
                  text,
                  style:
                  textStyle ??
                      TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:
                        textColor ?? Colors.white,
                      ),
                ),
              ],
            ),
      ),
    );
  }

  static Widget infoTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(
              value.isEmpty ? "N/A" : value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ================= IMAGE VIEW =================
  static Widget imageBox(String path) {
    if (path.isEmpty) return const SizedBox();

    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: FileImage(File(path)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}