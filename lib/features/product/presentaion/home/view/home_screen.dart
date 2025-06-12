import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/shared_widgets/common_app_bar.dart';
import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../Upload/view/UploadProductScreen.dart';
import '../../../../chat/presentation/view/chats_screen.dart';
import '../../../../profile/presentation/views/profile_screen.dart';
import '../../../../profile/presentation/widgets/appBar_profile.dart';
import '../../../../search/presentation/view/search_screen.dart';
import '../../cubit/present_product_cubit.dart';
import '../widgets/appBar_home.dart';
import '../widgets/card_home.dart';
import '../widgets/item_card_list.dart';
import '../widgets/item_show_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchAllProducts();
  }

  final List<Widget> screens = [
    const HomeContent(),
    const SearchScreen(),
    const ChatsScreen(),
    ProfileScreen()
  ];

  // Change this line only:
  final List<PreferredSizeWidget?> appBar = [
    AppbarHome(),
    null,
    const CommonAppBar(title: ""),
    const AppbarProfile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.SecondaryColor,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const UploadProductScreen();
          }));
        },
        child: const Icon(
          Icons.add,
          color: ColorManager.PrimaryColor,
        ),
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: ColorManager.SecondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavBarItem(
              icon: Icons.home,
              isSelected: selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            _buildNavBarItem(
              icon: Icons.search,
              isSelected: selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            const SizedBox(width: 30),
            _buildNavBarItem(
              icon: Icons.forum,
              isSelected: selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            _buildNavBarItem(
              icon: Icons.person,
              isSelected: selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBarItem({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected
            ? ColorManager.PrimaryColor
            : const Color.fromARGB(255, 223, 231, 237),
        size: 35,
      ),
      onPressed: onTap,
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CardHome(),
            ItemShowWidget(
              title: 'Nearby Sellers',
              text: 'See All',
            ),
            ItemCardList(),
            ItemShowWidget(
              title: 'Recommends',
              text: 'See All',
            ),
            ItemCardList(),
          ],
        ),
      ),
    );
  }
}
