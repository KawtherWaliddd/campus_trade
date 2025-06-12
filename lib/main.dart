import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/campus_trade_app.dart';
import 'package:flutter_application_1/core/services/get_it_sevice.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'core/services/notification_service.dart';
import 'features/notification/data/product_state_listener.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initialize();

  final userId =
      FirebaseAuth.instance.currentUser?.uid; // Get from your auth system
  ProductStateListener(FirebaseFirestore.instance).listen(userId!);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  runApp(const CampusTradeApp());
}
