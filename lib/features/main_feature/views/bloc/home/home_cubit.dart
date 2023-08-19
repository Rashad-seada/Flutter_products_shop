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
import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';
import 'package:eng_shop/features/main_feature/domain/usecase/add_to_cart_usecase.dart';
import 'package:eng_shop/features/main_feature/domain/usecase/get_cart_usecase.dart';
import 'package:eng_shop/features/main_feature/domain/usecase/get_products_usecase.dart';
import 'package:eng_shop/features/main_feature/domain/usecase/remove_from_cart_usecase.dart';
import 'package:eng_shop/features/main_feature/views/pages/admin/admin_home_page.dart';
import 'package:eng_shop/features/main_feature/views/pages/customer/customer_home_page.dart';
import 'package:eng_shop/features/main_feature/views/pages/customer/cart_page.dart';
import 'package:eng_shop/features/main_feature/views/util/services.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/config/app_theme.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';

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
  ];

  List<DotNavigationBarItem> get adminNavItems => [
    /// Home
    DotNavigationBarItem(
      icon: Icon(Icons.home),
      selectedColor: AppTheme.primary500,
    ),

    /// Likes
    DotNavigationBarItem(
      icon: Icon(Icons.favorite),
      selectedColor: AppTheme.primary500,
    ),

    /// Search
    DotNavigationBarItem(
      icon: Icon(Icons.search),
      selectedColor: AppTheme.primary500,
    ),

    /// Profile
    DotNavigationBarItem(
      icon: Icon(Icons.person),
      selectedColor: AppTheme.primary500,
    ),
  ];

  List<DotNavigationBarItem> get customerNavItems => [
    /// Home
    DotNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      selectedColor: AppTheme.primary500,
    ),

    /// Likes
    DotNavigationBarItem(
      icon: Icon(Icons.favorite_border_rounded),
      selectedColor: AppTheme.primary500,
    ),

    /// Search
    DotNavigationBarItem(
      icon: Icon(Icons.search),
      selectedColor: AppTheme.primary500,
    ),

    /// Profile
    DotNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      selectedColor: AppTheme.primary500,
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

  List<DotNavigationBarItem> getNavItems(UserType userType){
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




}
