import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/di/app_module.dart';
import 'package:eng_shop/core/infrastructure/services/network_service.dart';
import 'package:eng_shop/features/auth/domain/usecase/logout_usecase.dart';
import 'package:eng_shop/features/auth/views/screens/auth_methods_screen.dart';
import 'package:eng_shop/features/shop/domain/usecase/products/drop_all_products_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/error_messages.dart';
import '../../../../../core/error/failure.dart';
import '../../../../search/views/screens/search_screen.dart';
import '../../../domain/entity/product_entity.dart';
import '../../../domain/usecase/products/get_products_usecase.dart';

part 'home_customer_state.dart';

class HomeCustomerCubit extends Cubit<HomeCustomerState> {

  void _listener(){
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels == 0) {
        // Top of the scrollable area
      } else {
        getProducts();
      }
    }
  }

  HomeCustomerCubit() : super(HomeCustomerInitial()){
    scrollController = ScrollController();
    scrollController.addListener(()=> _listener());
  }

  ScrollController scrollController = ScrollController();

  int pageNumber = 1;


  onLogoutClick(BuildContext context) {
    logout(context);
  }


  logout(BuildContext context) async {
    await getIt<LogoutUsecase>().call(LogoutParams(AppConsts.homeScreen)).then(
      (value) => value.fold(
        (error) {
          emit(HomeCustomerFailure(error));
          emit(HomeCustomerInitial());
        },
        (success) {
          return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const AuthMethodsScreen()), (route) => false);
        }
      )
    );
  }

  void getProducts({bool refresh = false}){
    emit(HomeCustomerIsLoading());
    getIt<GetProductsUsecase>().call(GetProductsParams(pageNumber, AppConsts.homeScreen,refresh: refresh)).then(
      (value) => value.fold(
        (error) {
          getProducts();
          emit(HomeCustomerFailure(error));

        },
        (success) async {
          if(await getIt<NetworkService>().isConnected == false) {

            emit(HomeCustomerSuccess());
            HomeCustomerSuccess.products = success;
            getProducts();

          }else {
            emit(HomeCustomerSuccess());
            HomeCustomerSuccess.products = success;
            emit(HomeCustomerInitial());
            pageNumber = HomeCustomerSuccess.products.length ~/ 10 + 1 ;
          }

        }
      )
    );
  }

  void onAddToFavorite(ProductEntity productEntity,BuildContext context){

  }

  void onSearchTap(BuildContext context) {
   Navigator.push(context,MaterialPageRoute(builder: (_)=> SearchScreen() )) ;
  }

  void onRefresh() async  {
    pageNumber = 1;
    HomeCustomerSuccess.products.clear();
    getProducts(refresh: true);
  }



}
