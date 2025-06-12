import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_sevice.dart';
import '../../domain/repos/auth_repo.dart';
import '../cubit/forget_password_cubit/forget_password_cubit.dart';
import '../widget/forget_password_view_body_bloc_consumer.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  static const routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(
        getIt<AuthRepo>(),
      ),
      child: const Scaffold(
        body: ForgetPasswordViewBodyBlocConsumer(),
      ),
    );
  }
}
