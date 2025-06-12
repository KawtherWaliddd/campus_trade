import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/image_manager.dart';
import '../../../core/utils/resources/text_styles.dart';

class Selectfile extends StatefulWidget {
  File? image;
  void Function()? UploadImage;
  Selectfile({super.key, required this.image, required this.UploadImage});

  @override
  State<Selectfile> createState() => _SelectfileState();
}

class _SelectfileState extends State<Selectfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353.w,
      height: 150.h,
      decoration: BoxDecoration(
          // image: DecorationImage(image: ),
          border: Border.all(
              color: ColorManager.SecondaryColor,
              width: 3,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 15.r, right: 0.r, left: 0.r),
              child: (widget.image == null)
                  ? Image.asset(
                      ImageManager.DefaultPic,
                    )
                  : Image.file(
                      widget.image!,
                      filterQuality: FilterQuality.high,
                      width: 100.w,
                      height: 100.h,
                    )),
          Padding(
              padding: EdgeInsets.only(top: 5.r, right: 120.5.r, left: 120.5.r),
              child: InkWell(
                  onTap: widget.UploadImage,
                  child: Text(
                    "Select file",
                    style: TextStyles.grey16Medium,
                  ))),
        ],
      ),
    );
  }
}
