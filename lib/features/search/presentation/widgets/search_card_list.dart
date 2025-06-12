import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/search/presentation/widgets/search_card.dart';

import '../../../../core/utils/resources/image_manager.dart';
import '../../data/models/category_model.dart';

class SearchCardList extends StatelessWidget {
  SearchCardList({super.key});
  final List<CategoryModel> categoryData = [
    CategoryModel(
      categoryName: 'Engineering',
      imageUrl: ImageManager.engineering,
    ),
    CategoryModel(categoryName: 'Medicine', imageUrl: ImageManager.medicine),
    CategoryModel(categoryName: 'Pharmacy', imageUrl: ImageManager.pharmacy),
    CategoryModel(categoryName: 'Business', imageUrl: ImageManager.business),
    CategoryModel(categoryName: 'Fine Arts', imageUrl: ImageManager.fineArts),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: categoryData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SearchCard(categoryModel: categoryData[index]);
        },
      ),
    );
  }
}
