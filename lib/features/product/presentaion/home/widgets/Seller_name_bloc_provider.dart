import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/get_it_sevice.dart';
import '../../../../auth/data/repos/user_repo_impl.dart';
import '../../../../auth/presentation/cubit/user_personal_data_cubit/user_cubit.dart';
import '../../../../auth/presentation/cubit/user_personal_data_cubit/user_state.dart';

class SellerName extends StatefulWidget {
  final String sellerId;
  const SellerName({super.key, required this.sellerId});

  @override
  State<SellerName> createState() => _SellerNameState();
}

class _SellerNameState extends State<SellerName> {
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
            return Text(user.firstName);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
