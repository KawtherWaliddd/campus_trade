import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/presentation/widget/textField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/text_styles.dart';
import '../cubit/forget_password_cubit/forget_password_cubit.dart';
import '../../../../core/shared_widgets/custom_button.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: ColorManager.PrimaryColor,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: ColorManager.SecondaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 66,
                      right: 100,
                      top: 90,
                      bottom: 76,
                    ),
                    child: Image.asset("assets/images/logo_text.png"),
                  ),
                ],
              ),
              const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Enter the email associated with your \n account.",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto_Condensed',
                    fontWeight: FontWeight.w700,
                    color: ColorManager.blackColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hintText: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const Spacer(),
              CustomButton(
                labelText: 'send',
                backgroundColor: ColorManager.SecondaryColor,
                textStyle: TextStyles.white14Bold,
                onPressed: () {
                  final email = emailController.text.trim();

                  if (email.isNotEmpty) {
                    context.read<ForgetPasswordCubit>().forgetPassword(email);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter your email')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
