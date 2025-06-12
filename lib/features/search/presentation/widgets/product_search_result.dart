import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/presentaion/cubit/present_product_cubit.dart';
import '../../../product/presentaion/details/view/detail_screen.dart';

class ProductSearchResults extends StatelessWidget {
  final String query;

  const ProductSearchResults({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, PresentProductState>(
      builder: (context, state) {
        if (state is PresentProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PresentProductError) {
          return Center(child: Text(state.message));
        } else if (state is PresentProductLoaded) {
          final products = state.productModel
              .where((product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
          if (products.isEmpty) {
            return const Center(child: Text("No products found."));
          }
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        productId: product.productId, // Pass productId here
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
