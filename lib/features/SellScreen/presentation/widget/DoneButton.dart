import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/text_styles.dart';

class DoneButton extends StatefulWidget {
  String text;
  void Function()? Continue;
  DoneButton({super.key, required this.text, this.Continue});

  @override
  State<DoneButton> createState() => _CustomselectbuttonState();
}

class _CustomselectbuttonState extends State<DoneButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353.w,
      height: 42.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r),
          color: ColorManager.SecondaryColor),
      child: InkWell(
        onTap: widget.Continue,
        child: Padding(
            padding: EdgeInsets.only(
                left: 150.5.r, right: 150.5.r, top: 10.r, bottom: 10.r),
            child: Text(
              widget.text,
              style: TextStyles.white14Bold,
            )),
      ),
    );
  }
}
