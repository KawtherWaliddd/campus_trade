import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/services/notification_service.dart';

class ProductStateListener {
  final FirebaseFirestore _firestore;

  ProductStateListener(this._firestore);

  StreamSubscription<void> listen(String userId) {
    return _firestore
        .collection('products')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .listen((snapshot) async {
      for (final change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.modified) {
          final data = change.doc.data();
          final newState = data?['productState'];
          final productName = data?['name'] ?? 'Unnamed Product';

          if (newState == 'approved' || newState == 'rejected') {
            await NotificationService.showProductNotification(
              productName: productName,
              state: newState,
            );
          }
        }
      }
    });
  }
}
