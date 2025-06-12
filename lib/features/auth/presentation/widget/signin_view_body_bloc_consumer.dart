import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/presentation/widget/signin_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../product/presentaion/home/view/home_screen.dart';
import '../cubit/signin_cubit/signin_cubit.dart';

class SigninViewBodyBlocConsumer extends StatelessWidget {
  const SigninViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          log("correct email and password");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }

        if (state is SigninFailure) {
          SnackBar(content: Text(state.message));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SigninLoading ? true : false,
          child: const SignInViewBody(),
        );
      },
    );
  }
}
