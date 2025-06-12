import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product/presentaion/cubit/present_product_cubit.dart';
import '../widgets/appBar_search.dart';
import '../widgets/product_search_result.dart';
import '../widgets/search_card_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    context.read<ProductCubit>().searchProducts(query);
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSearch(
        controller: _searchController,
        onSubmitted: (_) => _onSearchChanged(), // Handle Enter key press
      ),
      body: searchQuery.isEmpty
          ? SearchCardList()
          : ProductSearchResults(query: searchQuery),
    );
  }
}
