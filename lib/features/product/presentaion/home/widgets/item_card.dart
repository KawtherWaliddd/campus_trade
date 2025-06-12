import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/product/presentaion/details/view/detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/text_styles.dart';

class ItemCard extends StatelessWidget {
  final Widget sellerNameWidget;
  final String productName;
  final String productPrice;
  final String productAddress;
  final String productImage;
  final String productId;
  const ItemCard({
    super.key,
    required this.sellerNameWidget,
    required this.productName,
    required this.productPrice,
    required this.productAddress,
    required this.productImage,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(productId: productId),
          ),
        );
      },
      child: Container(
        width: 180.w,
        decoration: BoxDecoration(
          color: ColorManager.lightBlue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              width: 191.w,
              height: 136.h,
              productImage,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: sellerNameWidget,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                productName,
                style: TextStyles.white14Bold.copyWith(
                  color: ColorManager.blackColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 1.5,
                        color: ColorManager.blackColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          Text(
                            productAddress,
                            style: TextStyles.black16Regular,
                          ),
                          SizedBox(width: 5.w),
                          const Icon(Icons.location_pin, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    productPrice,
                    style: TextStyles.black16Regular.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
