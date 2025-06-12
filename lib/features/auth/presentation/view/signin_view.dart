import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_sevice.dart';
import '../../domain/repos/auth_repo.dart';
import '../cubit/signin_cubit/signin_cubit.dart';
import '../widget/signin_view_body_bloc_consumer.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(
        getIt<AuthRepo>(),
      ),
      child: const Scaffold(
        body: SigninViewBodyBlocConsumer(),
      ),
    );
  }
}
