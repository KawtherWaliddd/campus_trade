import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/image_manager.dart';
import '../../../notification/presentaion/views/notification_screen.dart';

class AppbarSearch extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController? controller;
  final Function(String)? onSubmitted;

  const AppbarSearch({
    super.key,
    this.controller,
    this.onSubmitted,
  });

  @override
  Size get preferredSize => Size.fromHeight(140.h);

  @override
  State<AppbarSearch> createState() => _AppbarSearchState();
}

class _AppbarSearchState extends State<AppbarSearch> {
  late final TextEditingController _internalController;
  late final bool _usingExternalController;

  @override
  void initState() {
    super.initState();
    _usingExternalController = widget.controller != null;
    _internalController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (!_usingExternalController) {
      _internalController.dispose();
    }
    super.dispose();
  }

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
              FocusScope.of(context).unfocus();
            },
            child: Image.asset(ImageManager.backButton),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: _internalController,
              onSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                hintText: "Search Here",
                suffixIcon: const Icon(Icons.sync_alt),
                fillColor: ColorManager.PrimaryColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const NotificationScreen();
              }));
            },
            icon: const Icon(
              Icons.notifications,
              color: ColorManager.PrimaryColor,
              size: 30,
            ),
          ),
          SizedBox(width: 10.w),
          InkWell(
            child: Image.asset(ImageManager.cartButton),
          )
        ],
      ),
    );
  }
}
