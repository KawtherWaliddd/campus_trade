import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/resources/icon_manager.dart';
import 'package:flutter_application_1/features/auth/presentation/cubit/user_personal_data_cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/services/get_it_sevice.dart';
import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/text_styles.dart';
import '../../../../auth/data/repos/user_repo_impl.dart';
import '../../../../auth/presentation/cubit/user_personal_data_cubit/user_state.dart';

class UserDataRow extends StatefulWidget {
  final String sellerId;

  const UserDataRow({super.key, required this.sellerId});

  @override
  State<UserDataRow> createState() => _UserDataRowState();
}

class _UserDataRowState extends State<UserDataRow> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserCubit(getIt<UserRepository>(), widget.sellerId)..fetchUserData(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserError) {
            return Center(child: Text(state.message));
          }
          if (state is UserLoaded) {
            final user = state.user;
            return Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.image),
                  radius: 25.r,
                ),
                SizedBox(width: 8.w),
                Text(user.firstName, style: TextStyles.black14Bold),
                const Spacer(),
                SvgPicture.asset(
                  IconManager.phone,
                  width: 12.5.w,
                  height: 12.5.h,
                ),
                SizedBox(width: 10.w),
                Text(user.mobileNumber, style: TextStyles.blue12Bold),
                SizedBox(width: 10.w),
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: ColorManager.veryLightBlue,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: SvgPicture.asset(
                    IconManager.chat,
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
