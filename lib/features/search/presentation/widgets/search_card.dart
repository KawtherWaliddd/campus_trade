import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/text_styles.dart';
import '../../data/models/category_model.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 18),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Image.asset(
                height: 160.h,
                width: double.infinity,
                categoryModel.imageUrl,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          ColorManager.SecondaryColor.withOpacity(0.9),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            categoryModel.categoryName,
                            style: TextStyles.white24Bold
                                .copyWith(fontSize: 20.sp),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: ColorManager.PrimaryColor,
                          )
                        ],
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
