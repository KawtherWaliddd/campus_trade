import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/resources/icon_manager.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/resources/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileFeature extends StatelessWidget {
  final String iconPath;
  final String title;

  const ProfileFeature({
    super.key,
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 23),
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          const Spacer(),
          Text(
            title,
            style: TextStyles.black16Regular.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(IconManager.arrow),
        ],
      ),
    );
  }
}
