import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubit/forget_password_cubit/forget_password_cubit.dart';
import '../view/signin_view.dart';
import 'forget _passwod_view_body.dart';

class ForgetPasswordViewBodyBlocConsumer extends StatelessWidget {
  const ForgetPasswordViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          log("email is sent");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SigninView(),
            ),
          );
        }

        if (state is ForgetPasswordFailure) {
          SnackBar(
            content: Text(state.message),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ForgetPasswordLoading ? true : false,
          child: ForgetPasswordViewBody(),
        );
      },
    );
  }
}
