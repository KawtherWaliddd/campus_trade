import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/product_model.dart';
import '../../data/repo/present_product_repo.dart';

part 'present_product_state.dart';

class ProductCubit extends Cubit<PresentProductState> {
  final PresentDataRepo productRepository;
  final Map<String, String> _sellerNamesCache = {};
  List<ProductModel> _allProducts = [];

  ProductCubit(this.productRepository) : super(PresentProductInitial());

  Future<void> fetchAllProducts() async {
    emit(PresentProductLoading());
    try {
      final result = await productRepository.getAllProducts();

      result.fold(
        (failure) => emit(PresentProductError(failure.message)),
        (products) {
          emit(PresentProductLoaded(productModel: products));
          _allProducts = products;
        },
      );
    } catch (e) {
      emit(PresentProductError("Failed to load products: ${e.toString()}"));
    }
  }

  Future<String> getSellerNameForProduct(String sellerId) async {
    if (_sellerNamesCache.containsKey(sellerId)) {
      return _sellerNamesCache[sellerId]!;
    }

    final result = await productRepository.getUserNameById(sellerId);
    final sellerName = result.fold(
      (failure) => 'Unknown Seller',
      (name) => name,
    );

    _sellerNamesCache[sellerId] = sellerName;
    return sellerName;
  }

  void searchProducts(String query) {
    if (state is! PresentProductLoaded) return;

    if (query.isEmpty) {
    } else {
      final allApprovedProducts = _allProducts
          .where((product) => product.productState == "approved")
          .toList();
      final filtered = allApprovedProducts.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.description.toLowerCase().contains(query.toLowerCase());
      }).toList();

      emit(PresentProductLoaded(productModel: filtered));
    }
  }
}
