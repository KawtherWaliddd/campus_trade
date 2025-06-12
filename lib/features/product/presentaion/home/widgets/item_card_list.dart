import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/services/get_it_sevice.dart';
import '../../cubit/present_product_cubit.dart';
import 'Seller_name_bloc_provider.dart';
import 'item_card.dart';

class ItemCardList extends StatelessWidget {
  const ItemCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductCubit>()..fetchAllProducts(),
      child: SizedBox(
        height: 250.h,
        child: BlocBuilder<ProductCubit, PresentProductState>(
          builder: (context, state) {
            if (state is PresentProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PresentProductError) {
              return Center(child: Text(state.message));
            }

            if (state is PresentProductLoaded) {
              final approvedProducts = state.productModel
                  .where((product) => product.productState == "approved")
                  .toList();

              if (approvedProducts.isEmpty) {
                return const Center(
                    child: Text('No approved products available!'));
              }

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final product = approvedProducts[index];
                  return ItemCard(
                    sellerNameWidget: SellerName(sellerId: product.userId),
                    productName: product.name,
                    productPrice: '\$${product.price}',
                    productAddress: product.address,
                    productImage: product.imageUrl,
                    productId: product.productId,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 16.w),
                itemCount: approvedProducts.length,
              );
            }
            return const Center(child: Text('No products available!'));
          },
        ),
      ),
    );
  }
}
