import 'package:flutter/material.dart';
import '../../../../core/shared_widgets/common_app_bar.dart';
import '../widgets/notefication_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(
        title: 'Notifications',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [NoteficationCard()],
        ),
      ),
    );
  }
}
