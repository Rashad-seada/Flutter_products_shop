import 'package:bloc/bloc.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/di/app_module.dart';
import 'package:eng_shop/core/views/screens/playground_screen.dart';
import 'package:eng_shop/features/auth/domain/usecase/logout_usecase.dart';
import 'package:eng_shop/features/auth/domain/util/user_type_enum.dart';
import 'package:eng_shop/features/auth/views/screens/auth_methods_screen.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:eng_shop/features/shop/views/util/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/config/app_theme.dart';
import '../../../../../core/error/failure.dart';
import '../../../../search/views/screens/search_screen.dart';
import '../../../domain/entity/product_entity.dart';
import '../../../domain/usecase/cart/get_cart_usecase.dart';
import '../../../domain/usecase/products/get_products_usecase.dart';
import '../../pages/admin/admin_home_page.dart';
import '../../pages/cart_page.dart';
import '../../pages/customer/customer_home_page.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  void _listener(){
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels == 0) {
        // Top of the scrollable area
      } else {
        // End of the scrollable area
        getProducts();
      }
    }
  }

  HomeCubit() : super(HomeInitial()){
    scrollController = ScrollController();
    scrollController.addListener(()=> _listener());
    pageNumber = 1;

    getProducts();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController scrollController = ScrollController();

  int currentIndex = 0;


  int pageNumber = 1;

  List<Widget> get adminHomePages  =>  [
    const AdminHomePage(),
    const PlayGroundScreen(),
    const Scaffold(),
    const Scaffold(),
  ];

  List<Widget> get customerHomePages  =>  [
    const CustomerHomePage(),
    const PlayGroundScreen(),
    const Scaffold(),
    const CartPage(),
    const Scaffold(),
  ];

  List<BottomNavigationBarItem> get adminNavItems => [
    /// Home
    BottomNavigationBarItem(
        label: "Home",
        icon: SvgPicture.asset(AppImages.home),
        activeIcon: SvgPicture.asset(AppImages.home)
    ),

    /// Search
    BottomNavigationBarItem(
        label: "Search",
        icon: SvgPicture.asset(AppImages.search),
        activeIcon: SvgPicture.asset(AppImages.search)
    ),


    /// Likes
    BottomNavigationBarItem(
        label: "Favorite",
        icon: SvgPicture.asset(AppImages.heart),
        activeIcon: SvgPicture.asset(AppImages.heart)

    ),

    /// Profile
    BottomNavigationBarItem(
        label: "Cart",
        icon: SvgPicture.asset(AppImages.cart),
        activeIcon: SvgPicture.asset(AppImages.cart)
    ),
  ];

  List<BottomNavigationBarItem> get customerNavItems => [
    /// Home
    BottomNavigationBarItem(
      label: "Home",
      icon: SvgPicture.asset(AppImages.home),
      activeIcon: SvgPicture.asset(AppImages.home)
    ),

    /// Search
    BottomNavigationBarItem(
      label: "Categories",
      icon: SvgPicture.asset(AppImages.search2),
      activeIcon: SvgPicture.asset(AppImages.search2)
    ),


    /// Likes
    BottomNavigationBarItem(
      label: "Favorite",
      icon: SvgPicture.asset(AppImages.heart),
      activeIcon: SvgPicture.asset(AppImages.heart)

    ),

    /// cart
    BottomNavigationBarItem(
      label: "Cart",
      icon: SvgPicture.asset(AppImages.cart),
      activeIcon: SvgPicture.asset(AppImages.cart)
    ),

    /// profile
    BottomNavigationBarItem(
        label: "Me",
        icon: SvgPicture.asset(AppImages.profile2),
        activeIcon: SvgPicture.asset(AppImages.profile2)
    ),
  ];


  onNavigationBarTap(int index){
    emit(HomePageChanged());
    currentIndex = index;
    emit(HomeInitial());
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

  List<Service> get services  => [
    Service(serviceName: LocaleKeys.bill_of_sale.tr(), image: AppImages.billOfSale),
    Service(serviceName: LocaleKeys.receipt.tr(), image: AppImages.receipt),
    Service(serviceName: LocaleKeys.sale_return.tr(), image: AppImages.saleReturn),
    Service(serviceName: LocaleKeys.purchase_return.tr(), image: AppImages.purchaseReturn),
    Service(serviceName: LocaleKeys.stock_order.tr(), image: AppImages.stockOrder),
    Service(serviceName: LocaleKeys.stock_transfer.tr(), image: AppImages.stockTransfer),
    Service(serviceName: LocaleKeys.receive_stock.tr(), image: AppImages.receiveStock),
    Service(serviceName: LocaleKeys.middleman_shipment.tr(), image: AppImages.middlemanShipment),
    Service(serviceName: LocaleKeys.modify_middleman_shipment.tr(), image: AppImages.modifyMiddlemanShipment),
    Service(serviceName: LocaleKeys.customers.tr(), image: AppImages.customers),
    Service(serviceName: LocaleKeys.suppliers.tr(), image: AppImages.suppliers),
    Service(serviceName: LocaleKeys.categories.tr(), image: AppImages.customers),
    Service(serviceName: LocaleKeys.classification.tr(), image: AppImages.classification),
    Service(serviceName: LocaleKeys.bond.tr(), image: AppImages.bond),
  ];

  Widget getCurrentPage(UserType userType) {
    if(userType == UserType.admin){
      return adminHomePages[currentIndex];
    } else {
      return customerHomePages[currentIndex];
    }
  }

  onLogoutClick(BuildContext context) {
    logout(context);
  }


  logout(BuildContext context) async {
    await getIt<LogoutUsecase>().call(LogoutParams(AppConsts.homeScreen)).then(
      (value) => value.fold(
        (error) {
          emit(HomeFailure(error));
          emit(HomeInitial());
        },
        (success) {
          return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const AuthMethodsScreen()), (route) => false);
        }
      )
    );
  }


  void getProducts(){
    emit(HomeIsLoading());
    getIt<GetProductsUsecase>().call(GetProductsParams(pageNumber, AppConsts.homeScreen)).then(
      (value) => value.fold(
        (error) {
          emit(HomeFailure(error));
          emit(HomeInitial());
        },
        (success) {
          emit(HomeSuccess());
          HomeSuccess.products = success;
          emit(HomeInitial());
          pageNumber = HomeSuccess.products.length ~/ 10 + 1 ;
        }
      )
    );
  }

  void onAddToFavorite(ProductEntity productEntity,BuildContext context){

  }

  void onSearchTap(BuildContext context) {
   Navigator.push(context,MaterialPageRoute(builder: (_)=> SearchScreen() )) ;
  }




}
