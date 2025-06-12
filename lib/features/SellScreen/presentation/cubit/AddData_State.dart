import '../../Data/model/Sell_Product_Model.dart';

abstract class AddDataState {}

class AddInitial extends AddDataState {}

class AddLoading extends AddDataState {}

class AddSuccess extends AddDataState {
  final SellProductModel product;
  AddSuccess(this.product);
}

class AddFailure extends AddDataState {
  final String errorMessage;
  AddFailure(this.errorMessage);
}
