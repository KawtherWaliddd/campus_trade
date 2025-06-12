import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/services/get_it_sevice.dart';
import 'package:flutter_application_1/features/SellScreen/Data/repo/sell_product_repo.dart';
import 'package:flutter_application_1/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/Upload/Cubit/UploadCubit_class.dart';
import 'features/SellScreen/presentation/cubit/AddData_Class.dart';
import 'features/SellScreen/presentation/cubit/TestProduct.dart';
import 'features/auth/presentation/cubit/logout_cubit/logout_cubit.dart';
import 'features/auth/presentation/cubit/signin_cubit/signin_cubit.dart';
import 'features/auth/presentation/cubit/signup_cubit/signup_cubit.dart';
import 'features/product/data/repo/present_product_repo.dart';
import 'features/product/presentaion/cubit/present_product_cubit.dart';
import 'features/splash/splash.dart';

class CampusTradeApp extends StatelessWidget {
  const CampusTradeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UploadCubit()),
        BlocProvider(
          create: (context) => AddDataCubit(getIt<SellProductRepo>()),
        ),
        BlocProvider(create: (context) => Testproduct()),
        BlocProvider(create: (context) => SigninCubit(getIt<AuthRepo>())),
        BlocProvider(create: (context) => SignupCubit(getIt<AuthRepo>())),
        BlocProvider<ProductCubit>(
          create: (context) =>
              ProductCubit(getIt<PresentDataRepo>())..fetchAllProducts(),
        ),
        BlocProvider(create: (context) => getIt<LogoutCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        builder: (context, child) => const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Splash(),
        ),
      ),
    );
  }
}
