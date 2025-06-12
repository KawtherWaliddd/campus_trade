import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/presentation/widget/signup_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubit/signup_cubit/signup_cubit.dart';
import '../view/signin_view.dart';

class SignupViewBodyBlocConsumer extends StatefulWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  State<SignupViewBodyBlocConsumer> createState() =>
      _SignupViewBodyBlocConsumerState();
}

class _SignupViewBodyBlocConsumerState
    extends State<SignupViewBodyBlocConsumer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          log("User data stored successfully in Firestore!");

          if (mounted) {
            const SnackBar(content: Text("your data has added please sign in"));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SigninView()),
            );
          }
        }
        if (state is SignupFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading,
          child: SignUpViewBody(),
        );
      },
    );
  }
}
