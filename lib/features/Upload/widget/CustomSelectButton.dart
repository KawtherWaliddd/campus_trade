import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/text_styles.dart';

class Customselectbutton extends StatefulWidget {
  String text;
  final IconData? icon;
  double top;
  void Function()? UploadImage;
  Customselectbutton(
      {super.key,
      this.icon,
      required this.text,
      required this.top,
      this.UploadImage});

  @override
  State<Customselectbutton> createState() => _CustomselectbuttonState();
}

class _CustomselectbuttonState extends State<Customselectbutton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353.w,
      height: 42.h,
      margin: EdgeInsets.only(top: widget.top.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r),
          color: ColorManager.SecondaryColor),
      child: InkWell(
        onTap: widget.UploadImage,
        child: Padding(
          padding: EdgeInsets.only(left: 118.5.r),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: ColorManager.PrimaryColor,
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                widget.text,
                style: TextStyles.white14Bold,
              )
            ],
          ),
        ),
      ),
    );
  }
}
