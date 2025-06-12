import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/text_styles.dart';
import '../cubit/TestProduct.dart';

class Datatextfield extends StatelessWidget {
  final String hinttext;
  final TextEditingController controller;
  final bool isRequired;
  final bool isVisible;
  final bool isPriceField;
  final productState currentState;

  const Datatextfield({
    super.key,
    required this.hinttext,
    required this.controller,
    this.isRequired = true,
    this.isPriceField = false,
    this.isVisible = true,
    required this.currentState,
  });

  String? _validateField(String? value) {
    if (!isVisible) return null; // Skip validation if not visible

    // Special handling for price field
    if (isPriceField) {
      if (currentState == productState.Sell) {
        if (value == null || value.isEmpty) return 'Price is required';
        if (double.tryParse(value) == null) return 'Enter a valid number';
        if (double.parse(value) <= 0) return 'Price must be greater than 0';
      }
      return null;
    }

    if (isRequired && (value == null || value.trim().isEmpty)) {
      switch (hinttext) {
        case 'Product Name':
          return 'Product name is required';
        case 'Description':
          return 'Description is required';
        case 'Your Address':
          return 'Address is required';
        default:
          return 'This field is required';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      maintainState: true,
      // maintainAnimation: true,
      // maintainSize: true,
      // maintainInteractivity: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, left: 20.w),
            child: Text(
              hinttext,
              style: TextStyles.black20Bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextFormField(
              minLines: 1,
              maxLines: hinttext == 'Description' ? 3 : 1,
              validator: _validateField,
              controller: controller,
              keyboardType: isPriceField
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2.w, color: ColorManager.greyColor),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                hintText: hinttext,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.w),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.w, color: Colors.red),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
