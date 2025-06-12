import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/resources/color_manager.dart';
import 'package:flutter_application_1/core/utils/resources/image_manager.dart';
import 'package:flutter_application_1/core/utils/resources/text_styles.dart';
import 'package:flutter_application_1/features/notification/presentaion/views/notification_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const ChatAppBar({super.key, required this.title});
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
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(ImageManager.backButton),
          ),
          const Spacer(),
          Text(title, style: TextStyles.white24Bold),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const NotificationScreen();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.notifications,
              color: ColorManager.PrimaryColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
