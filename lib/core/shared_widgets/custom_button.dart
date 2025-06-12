import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String labelText;
  final Color backgroundColor;
  final TextStyle textStyle;
  final Color? borderColor;
  final double? width;
  final double? height;
  final String? iconPath;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.labelText,
    required this.backgroundColor,
    required this.textStyle,
    this.borderColor,
    this.iconPath,
    this.height,
    this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 353.spMax,
      height: height ?? 42.spMax,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textStyle.color,
          side: BorderSide(color: borderColor ?? Colors.transparent),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              Image.asset(iconPath!, height: 20),
              const SizedBox(width: 10),
            ],
            Text(
              labelText,
              style: textStyle, // هنا يتم استخدام الـ TextStyle الممرر
            ),
          ],
        ),
      ),
    );
  }
}
