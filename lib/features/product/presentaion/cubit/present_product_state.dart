part of 'present_product_cubit.dart';

@immutable
sealed class PresentProductState {}

final class PresentProductInitial extends PresentProductState {}

final class PresentProductLoading extends PresentProductState {}

final class PresentProductLoaded extends PresentProductState {
  final List<ProductModel> productModel;
  PresentProductLoaded({
    required this.productModel,
  });
}

final class PresentProductError extends PresentProductState {
  final String message;
  PresentProductError(this.message);
  @override
  List<Object> get props => [message];
}
