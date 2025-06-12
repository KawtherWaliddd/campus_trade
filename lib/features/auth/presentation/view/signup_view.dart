import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_sevice.dart';
import '../../domain/repos/auth_repo.dart';
import '../cubit/signup_cubit/signup_cubit.dart';
import '../widget/signup_view_body_bloc_consumer.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const routeName = 'signup';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        getIt<AuthRepo>(),
      ),
      child: const Scaffold(
        body: SignupViewBodyBlocConsumer(),
      ),
    );
  }
}
