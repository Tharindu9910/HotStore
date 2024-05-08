import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hot_store1/screens/bag/bag_screen.dart';
import 'package:hot_store1/screens/favourites/favourites_screen.dart';
import 'package:hot_store1/screens/profile/profile_screen.dart';
import 'package:hot_store1/screens/shop/shop_screen.dart';
import 'package:hot_store1/utils/hex_color.dart';

import 'home/home_screen.dart';

enum BottomNavPage { home, shop, bag, favourites, profile }

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  BottomNavPage selectedPage = BottomNavPage.home;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: Stack(children: [
        _buildBottomNav(BottomNavPage.home),
        _buildBottomNav(BottomNavPage.shop),
        _buildBottomNav(BottomNavPage.bag),
        _buildBottomNav(BottomNavPage.favourites),
        _buildBottomNav(BottomNavPage.profile),
      ]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38.withOpacity(0.05),
                spreadRadius: 0.1,
                blurRadius: 9,
                offset: const Offset(0, 1)),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: Theme(
            data: ThemeData(splashFactory: NoSplash.splashFactory),
            child: BottomNavigationBar(
              currentIndex: BottomNavPage.values.indexOf(selectedPage),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: HexColor("#D42427"),
              backgroundColor: Colors.white,
              selectedFontSize: 9,
              unselectedFontSize: 9,
              selectedLabelStyle: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 10, fontWeight: FontWeight.w700),
              unselectedLabelStyle: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 10),
              onTap: (index) {
                final currentSelectedItem = BottomNavPage.values[index];
                setState(() {
                  selectedPage = currentSelectedItem;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    activeIcon: Icon(
                      Icons.home,
                      color: HexColor("#D42427"),
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    activeIcon: Icon(
                      Icons.shopping_cart_outlined,
                      color: HexColor("#D42427"),
                    ),
                    label: "Shop"),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.shopping_bag_outlined),
                    activeIcon: Icon(
                      Icons.shopping_bag_outlined,
                      color: HexColor("#D42427"),
                    ),
                    label: "Bag"),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.favorite_border_outlined),
                    activeIcon: Icon(
                      Icons.favorite_border_outlined,
                      color: HexColor("#D42427"),
                    ),
                    label: "Favourites"),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.person_3_outlined),
                    activeIcon: Icon(
                      Icons.person,
                      color: HexColor("#D42427"),
                    ),
                    label: "Profile")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BottomNavPage currentItem) {
    return Offstage(
      offstage: currentItem != selectedPage,
      child: _getScreen(context, currentItem),
    );
  }

  _getScreen(BuildContext context, BottomNavPage page) {
    switch (page) {
      case BottomNavPage.home:
        return const HomeScreen();
      case BottomNavPage.shop:
        return const ShopScreen();
      case BottomNavPage.bag:
        return const BagScreen();
      case BottomNavPage.favourites:
        return const FavouritesScreen();
      case BottomNavPage.profile:
        return const ProfileScreen();
      default:
        return const Scaffold();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
