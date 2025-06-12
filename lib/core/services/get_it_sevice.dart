import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/core/services/firebase_auth_services.dart';
import 'package:flutter_application_1/features/SellScreen/Data/repo/sell_product_repo.dart';
import 'package:flutter_application_1/features/SellScreen/presentation/cubit/AddData_Class.dart';
import 'package:flutter_application_1/features/auth/data/repos/auth_repo_impl.dart';
import 'package:flutter_application_1/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repos/user_repo_impl.dart';
import '../../features/auth/presentation/cubit/logout_cubit/logout_cubit.dart';
import '../../features/product/data/repo/present_product_repo.dart';
import '../../features/product/presentaion/cubit/present_product_cubit.dart';

final getIt = GetIt.instance;
void setup() {
  getIt.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(firebaseAuthServices: getIt<FirebaseAuthServices>()),
  );
  getIt.registerSingleton<UserRepository>(UserRepository());
  getIt.registerLazySingleton<PresentDataRepo>(
    () => PresentDataRepo(firestore: FirebaseFirestore.instance),
  );
  getIt.registerFactory<ProductCubit>(
    () => ProductCubit(getIt<PresentDataRepo>()),
  );
  getIt.registerLazySingleton<SellProductRepo>(() => SellProductRepo());
  getIt.registerFactory<AddDataCubit>(
    () => AddDataCubit(getIt<SellProductRepo>()),
  );
  getIt.registerFactory(() => LogoutCubit(getIt<AuthRepo>()));
}
