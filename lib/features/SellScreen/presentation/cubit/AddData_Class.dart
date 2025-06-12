import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/model/Sell_Product_Model.dart';
import '../../Data/repo/sell_product_repo.dart';
import 'AddData_State.dart';

class AddDataCubit extends Cubit<AddDataState> {
  final SellProductRepo sellProductRepo;
  final FirebaseAuth auth = FirebaseAuth.instance;
  AddDataCubit(this.sellProductRepo) : super(AddInitial());

  Future<void> addProduct({
    required String productName,
    required String description,
    required String price,
    required String address,
    required String imageUrl,
  }) async {
    emit(AddLoading());

    final product = SellProductModel(
      productId: '',
      productName: productName,
      description: description,
      price: price,
      imageUrl: imageUrl,
      address: address,
      productState: "pending",
      userId: auth.currentUser!.uid,
    );

    final result = await sellProductRepo.uploadProductData(product);

    result.fold(
      (failure) => emit(AddFailure(failure.message)),
      (uploadedProduct) => emit(AddSuccess(uploadedProduct)),
    );
  }
}
