import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/services/get_it_sevice.dart';
import 'package:flutter_application_1/core/utils/resources/icon_manager.dart';
import 'package:flutter_application_1/features/auth/data/repos/user_repo_impl.dart';
import 'package:flutter_application_1/features/auth/presentation/view/signin_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/resources/text_styles.dart';
import '../../../auth/presentation/cubit/logout_cubit/logout_cubit.dart';
import '../../../auth/presentation/cubit/user_personal_data_cubit/user_cubit.dart';
import '../../../auth/presentation/cubit/user_personal_data_cubit/user_state.dart';
import '../widgets/profile_feture.dart';
import '../widgets/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserCubit(getIt<UserRepository>(), widget.uid!)..fetchUserData(),
      child: Scaffold(
        body: Column(
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is UserError) {
                  return Center(child: Text(state.message));
                }
                if (state is UserLoaded) {
                  final user = state.user;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ProfileImage(imageUrl: user.image),
                        Text(user.firstName, style: TextStyles.black20Bold),
                      ],
                    ),
                  );
                }
                return const Center(child: Text('Something went wrong'));
              },
            ),
            InkWell(
              onTap: () {},
              child: const ProfileFeature(
                title: "Pending Uploads",
                iconPath: IconManager.pending,
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ProfileFeature(
                title: "Order History",
                iconPath: IconManager.timing,
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ProfileFeature(
                title: "Info",
                iconPath: IconManager.info,
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ProfileFeature(
                title: "Settings",
                iconPath: IconManager.setting,
              ),
            ),
            BlocListener<LogoutCubit, LogoutState>(
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SigninView()),
                  );
                }
              },
              child: InkWell(
                onTap: () {
                  context.read<LogoutCubit>().logout();
                },
                child: const ProfileFeature(
                  title: "Log out",
                  iconPath: IconManager.exit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
