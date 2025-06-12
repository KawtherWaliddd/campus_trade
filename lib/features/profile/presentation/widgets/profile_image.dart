import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/resources/color_manager.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;

  const ProfileImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          width: 5,
          color: ColorManager.SecondaryColor,
        ),
      ),
      child:
          CircleAvatar(radius: 60.r, backgroundImage: NetworkImage(imageUrl)),
    );
  }
}
