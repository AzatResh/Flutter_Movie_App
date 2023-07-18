import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:flutter_movie/screens/home.dart';
import 'package:flutter_movie/screens/popular.dart';
import 'package:flutter_movie/screens/settings.dart';
import 'package:flutter_movie/screens/favourite.dart';

class BottomNavBar extends StatelessWidget{

  BottomNavBar({Key? key}) : super(key: key);
  
  PersistentTabController? _navbarController;

  final List<Widget> _screens = [
    HomePage(), 
    Popular(), 
    Favourite(),
    Settings(),
    ];

  final List<PersistentBottomNavBarItem> _navbarItems = [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home),
      title: 'Home',
      activeColorPrimary: CupertinoColors.systemRed,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.flame),
      title: 'Popular',
      activeColorPrimary: CupertinoColors.systemRed,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.plus_rectangle_on_rectangle),
      title: 'Lists',
      activeColorPrimary: CupertinoColors.systemRed,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.gear_alt),
      title: 'Settings',
      activeColorPrimary: CupertinoColors.systemRed,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context, 
      screens: _screens,
      navBarHeight: 80,
      items: _navbarItems,
      controller: _navbarController,
      backgroundColor: Colors.black,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      );
  }
}