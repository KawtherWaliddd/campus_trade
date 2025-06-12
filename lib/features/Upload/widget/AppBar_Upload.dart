import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/text_styles.dart';

class AppBarUpload extends StatelessWidget implements PreferredSizeWidget {
  final bool isvisible;
  const AppBarUpload({super.key, required this.isvisible});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorManager.SecondaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        toolbarHeight: 147,
        title: Center(
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isvisible)
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.lightBlue,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: ColorManager.SecondaryColor,
                      ),
                    ),
                  )
                else
                  SizedBox(width: 32.w),
                Text(
                  "Upload",
                  style: TextStyles.White20Bold,
                ),
                SizedBox(
                  width: 32.w,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(147.h);
}
