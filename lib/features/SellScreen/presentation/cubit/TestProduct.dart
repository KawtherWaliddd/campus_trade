import 'package:flutter_bloc/flutter_bloc.dart';

enum productState { Sell, Donate }

class Testproduct extends Cubit<productState> {
  Testproduct() : super(productState.Sell);

  void changeState(productState newstate) {
    emit(newstate);
  }
}
