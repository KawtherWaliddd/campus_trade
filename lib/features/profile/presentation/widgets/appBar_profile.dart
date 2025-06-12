import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/image_manager.dart';
import '../../../../core/utils/resources/text_styles.dart';
import '../../../notification/presentaion/views/notification_screen.dart';

class AppbarProfile extends StatelessWidget implements PreferredSizeWidget {
  const AppbarProfile({super.key});

  @override
  Size get preferredSize => Size.fromHeight(140.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: ColorManager.SecondaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 70.h, 16.h, 30.h),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Image.asset(
              ImageManager.backButton,
            ),
          ),
          const Spacer(),
          Text(
            'Profile',
            style: TextStyles.white24Bold,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const NotificationScreen();
                }),
              );
            },
            icon: const Icon(
              Icons.notifications,
              color: ColorManager.PrimaryColor,
              size: 30,
            ),
          ),
          InkWell(
            child: Image.asset(ImageManager.cartButton),
          ),
        ],
      ),
    );
  }
}
