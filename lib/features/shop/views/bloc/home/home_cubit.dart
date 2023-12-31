import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/config/app_images.dart';
import '../../../../../core/views/screens/playground_screen.dart';
import '../../../../auth/domain/util/user_type_enum.dart';
import '../../../../cart/view/pages/cart_page.dart';
import '../../../../favorites/view/pages/favorite_page.dart';
import '../../../../profile/views/pages/me_page.dart';
import '../../pages/admin_home_page.dart';
import '../../../../categories/views/pages/categories_page.dart';
import '../../pages/customer_home_page.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()){
    cartCount.addListener(() {
      emit(HomeSuccess());
      emit(HomeInitial());

    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndex = 0;

  static ValueNotifier<int> cartCount = ValueNotifier<int>(0);


  List<Widget> get adminHomePages  =>  [
    const AdminHomePage(),
    const PlayGroundScreen(),
    const Scaffold(),
    const Scaffold(),
  ];

  List<Widget> get customerHomePages  =>  [
    const CustomerHomePage(),
    const CategoriesPage(),
    FavoritePage(),
    CartPage(),
    const MePage(),
  ];

  List<BottomNavigationBarItem> get adminNavItems => [
    /// Home
    BottomNavigationBarItem(
        label: LocaleKeys.favorite.tr(),
        icon: SvgPicture.asset(AppImages.home),
        activeIcon: SvgPicture.asset(AppImages.home)
    ),

    /// Search
    BottomNavigationBarItem(
        label: LocaleKeys.categories.tr(),
        icon: SvgPicture.asset(AppImages.search),
        activeIcon: SvgPicture.asset(AppImages.search)
    ),


    /// Likes
    BottomNavigationBarItem(
        label: LocaleKeys.favorite.tr(),
        icon: SvgPicture.asset(AppImages.heart),
        activeIcon: SvgPicture.asset(AppImages.heart)

    ),

    /// Profile
    BottomNavigationBarItem(
        label: LocaleKeys.cart.tr(),
        icon: SvgPicture.asset(AppImages.cart),
        activeIcon: SvgPicture.asset(AppImages.cart)
    ),
  ];

  List<BottomNavigationBarItem> get customerNavItems => [
    /// Home
    BottomNavigationBarItem(
        label: LocaleKeys.home.tr(),
        icon: SvgPicture.asset(AppImages.home),
        activeIcon: SvgPicture.asset(AppImages.home)
    ),

    /// Search
    BottomNavigationBarItem(
        label: LocaleKeys.categories.tr(),
        icon: SvgPicture.asset(AppImages.search2),
        activeIcon: SvgPicture.asset(AppImages.search2)
    ),


    /// Likes
    BottomNavigationBarItem(
        label: LocaleKeys.favorite.tr(),
        icon: SvgPicture.asset(AppImages.heart),
        activeIcon: SvgPicture.asset(AppImages.heart)

    ),

    /// cart
    BottomNavigationBarItem(
      label: LocaleKeys.cart.tr(),
      icon: Badge(
          label: (cartCount.value ==0 )? null: ValueListenableBuilder<int>(
            valueListenable: cartCount,
            builder: (BuildContext context, int value, Widget? child) {
              return Text(cartCount.value.toString());
            },
          ),
          child: SvgPicture.asset(AppImages.cart)
      ),
      activeIcon: Badge(
          label:  (cartCount.value ==0 )? null:  ValueListenableBuilder<int>(
            valueListenable: cartCount,
            builder: (BuildContext context, int value, Widget? child) {
              return Text(cartCount.value.toString());
            },
          ),
          child: SvgPicture.asset(AppImages.cart)
      ),
    ),

    /// profile
    BottomNavigationBarItem(
        label: LocaleKeys.me.tr(),
        icon: SvgPicture.asset(AppImages.profile2),
        activeIcon: SvgPicture.asset(AppImages.profile2)
    ),
  ];


  Widget getCurrentPage(UserType userType) {
    if(userType == UserType.admin){
      return adminHomePages[currentIndex];
    } else {
      return customerHomePages[currentIndex];
    }
  }

  onMenuTap(UserType userType){
    scaffoldKey.currentState!.openDrawer();
  }

  List<BottomNavigationBarItem> getNavItems(UserType userType){
    if(userType == UserType.customer){
      return customerNavItems;
    }else {
      return adminNavItems;
    }
  }

  onNavigationBarTap(int index){
    emit(HomePageChanged());
    currentIndex = index;
    emit(HomeInitial());
  }

}
