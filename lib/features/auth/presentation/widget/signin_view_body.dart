import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/data/models/login_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/image_manager.dart';
import '../../../../core/utils/resources/text_styles.dart';
import '../cubit/signin_cubit/signin_cubit.dart';
import '../view/forget_passowd_view.dart';
import '../view/signup_view.dart';
import 'textField.dart';
import '../../../../core/shared_widgets/custom_button.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.PrimaryColor,
      body: Form(
        key: _globalKey,
        autovalidateMode: autovalidateMode,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          children: [
            SizedBox(height: 70.h),
            Center(
              child: Image.asset(
                ImageManager.logoText,
                width: 171.84.w,
                height: 101.h,
              ),
            ),
            SizedBox(height: 60.h),
            CustomTextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'field can\'t be empty';
                }
                return null;
              },
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 14.h),
            CustomTextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'field can\'t be empty';
                }
                return null;
              },
              hintText: 'Password',
              isPassword: true,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgetPasswordView(),
                    ),
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              labelText: "Sign In",
              backgroundColor: ColorManager.SecondaryColor,
              textStyle: TextStyles.white14Bold,
              onPressed: () {
                if (_globalKey.currentState!.validate()) {
                  _globalKey.currentState!.save();
                  LoginRequestModel loginRequestModel = LoginRequestModel(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  context.read<SigninCubit>().signin(loginRequestModel);
                } else {
                  autovalidateMode = AutovalidateMode.always;
                  setState(() {}); // error
                }
              },
            ),

            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: Divider(color: Colors.grey, thickness: 2)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    ' OR ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey, thickness: 2)),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              labelText: "Create New Account",
              backgroundColor: ColorManager.PrimaryColor,
              borderColor: ColorManager.SecondaryColor,
              textStyle: TextStyles.blue14Bold,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignupView();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            CustomButton(
              labelText: "Continue with Google",
              backgroundColor: ColorManager.PrimaryColor,
              borderColor: ColorManager.greyColor,
              textStyle: TextStyles.black14Bold,
              iconPath: ImageManager.google,
              onPressed: () {
                context.read<SigninCubit>().signinWithGoogle();
              },
            ),
            const SizedBox(height: 12),
            CustomButton(
              labelText: "Continue with Facebook",
              backgroundColor: ColorManager.brightBlue,
              borderColor: ColorManager.brightBlue,
              textStyle: TextStyles.white14Bold,
              iconPath: ImageManager.facebook,
              onPressed: () {
                context.read<SigninCubit>().signinWithFacebook();
              },
            ),

            SizedBox(height: 82.h),
            /////////////////////////////////////////////
            const Center(
              child: Text.rich(
                TextSpan(
                  text: 'By signing up, you accept our\n',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ', '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ', and use of '),
                    TextSpan(
                      text: 'Cookies',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
