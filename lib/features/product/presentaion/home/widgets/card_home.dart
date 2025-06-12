import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/image_manager.dart';
import '../../../../../core/utils/resources/text_styles.dart';
import '../../../../search/presentation/view/search_screen.dart';

class CardHome extends StatelessWidget {
  const CardHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                ImageManager.cover,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Image not found'));
                },
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent.withOpacity(0.3),
                      ColorManager.SecondaryColor.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get Up to 35% Sale on all medical equipment!',
                    style: TextStyles.white24Bold,
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        ColorManager.foundationColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const SearchScreen();
                        }),
                      );
                    },
                    child: Text(
                      'Shop Now',
                      style: TextStyles.white14Bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
