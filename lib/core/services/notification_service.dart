import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await _notifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
  }

  static Future<void> showProductNotification({
    required String productName,
    required String state, // 'approved' or 'rejected'
  }) async {
    final isApproved = state == 'approved';

    await _notifications.show(
      0,
      isApproved ? '✅ Product Approved' : '❌ Product Rejected',
      'Product: $productName\nStatus: ${state.toUpperCase()}',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'product_state_changes',
          'Product Status Updates',
          importance: Importance.high,
          styleInformation: BigTextStyleInformation(''), // Multi-line support
        ),
      ),
    );
  }
}
