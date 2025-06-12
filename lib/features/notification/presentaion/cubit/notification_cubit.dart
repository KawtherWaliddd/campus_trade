// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:campus_trade/features/product/data/model/product_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:meta/meta.dart';
//
// import '../../../../core/services/notification_service.dart';
//
// part 'notification_state.dart';
//
// class NotificationCubit extends Cubit<NotificationState> {
//   final ProductRepository _repository;
//   StreamSubscription? _subscription;
//
//   NotificationCubit(this._repository) : super(NotificationInitial());
//
//   void listenToUserProducts(String userId) {
//     emit(NotificationLoading());
//     _subscription?.cancel();
//
//     _subscription = _repository.getProductsByUser(userId).listen(
//       (products) {
//         emit(NotificationLoaded(products));
//       },
//       onError: (error) {
//         emit(NotificationError(error.toString()));
//       },
//     );
//   }
//
//   Future<void> handleStateChange(ProductModel product, String newState) async {
//     try {
//       await _repository.updateProductState(product.productId, newState);
//
//       // Show notification
//       final title = newState == 'approved' ? '✅ Approved' : '❌ Rejected';
//       final message = '${product.name} has been $newState';
//       emit(ProductNotification(title, message));
//       await NotificationService.showProductNotification(
//         title: title,
//         body: message,
//       );
//     } catch (e) {
//       emit(NotificationError('Failed to update product state'));
//     }
//   }
//
//   @override
//   Future<void> close() {
//     _subscription?.cancel();
//     return super.close();
//   }
// }
