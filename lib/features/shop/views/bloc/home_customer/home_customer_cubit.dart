import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/di/app_module.dart';
import 'package:eng_shop/core/infrastructure/services/network_service.dart';
import 'package:eng_shop/features/auth/domain/usecase/logout_usecase.dart';
import 'package:eng_shop/features/auth/views/screens/auth_methods_screen.dart';
import 'package:eng_shop/features/shop/domain/usecase/products/get_product_by_id_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../cart/view/bloc/cart/cart_cubit.dart';
import '../../../../categories/domain/entities/category_entity.dart';
import '../../../../categories/domain/usecase/get_all_categories_usecase.dart';
import '../../../../favorites/view/bloc/favorite/favorite_cubit.dart';
import '../../../../profile/views/components/diaglog.dart';
import '../../../../search/views/screens/search_screen.dart';
import '../../../../settings/data/data_source/local/settings_local_data_source.dart';
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

  bool isRecommendedLoading = false;
  bool isCategoriesLoading = false;


  HomeCustomerCubit(BuildContext context) : super(HomeCustomerInitial()){
    scrollController = ScrollController();
    scrollController.addListener(()=> _listener());

    getProducts();
    getAllCategories();
  }

  ScrollController scrollController = ScrollController();

  int pageNumber = 1;


  onLogoutClick(BuildContext context) {
    showCustomDialog(
        context,
        label: LocaleKeys.logout.tr(),
        message: LocaleKeys.logout_sub_text.tr(),
        callToAction: LocaleKeys.logout.tr(),
        antiCallToAction: LocaleKeys.cancel.tr(),
        onAntiCallToActionTap: (){
          Navigator.pop(context);
        },
        onCallToActionTap: (){
          logout(context);
        }
    );
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

  Future<void> getProducts({bool refresh = false}) async {
    isRecommendedLoading = true;
    pageNumber = HomeCustomerSuccess.products.length ~/ 10 + 1 ;

    emit(HomeCustomerIsLoading());

    getIt<GetProductsUsecase>().call(GetProductsParams(pageNumber, AppConsts.homeScreen,refresh: refresh)).then(
      (value) => value.fold(
        (error) {
          isRecommendedLoading = false;

          getProducts();
          emit(HomeCustomerFailure(error));

        },
        (success) async {
          isRecommendedLoading = false;

          emit(HomeCustomerSuccess());
          HomeCustomerSuccess.products = success;
          emit(HomeCustomerInitial());

        }
      )
    );
  }

  void onAddToFavorite(ProductEntity productEntity,BuildContext context){

  }

  void onSearchTap(BuildContext context) {
   Navigator.push(context,MaterialPageRoute(builder: (_)=> const SearchScreen() )) ;
  }

  void onRefresh() async  {
    pageNumber = 1;
    HomeCustomerSuccess.products.clear();
    HomeCustomerSuccess.categories.clear();

    getProducts(refresh: true);
    getAllCategories();
  }

  getAllCategories(){
    isCategoriesLoading = true;
    emit(HomeCustomerIsLoading());
    getIt<GetAllCategoriesUsecase>().call(GetAllCategoriesParams(AppConsts.categoryScreen)).then(
            (value) => value.fold(
                (error) {
                  isCategoriesLoading = false;
                  emit(HomeCustomerFailure(error));
            },
                (success) {
                  isCategoriesLoading = false;

                  emit(HomeCustomerSuccess());
                  HomeCustomerSuccess.categories = success;
                  emit(HomeCustomerInitial());
            }
        )
    );
  }

  onSubCategoryItemTap(int index, CategoryEntity categoryEntity) {

  }

  Future<String> getImage(int id) async {
    String? domain = await getIt<SettingsLocalDataSource>().getServiceProviderDomain();
    String? url = AppConsts.baseProductImageUrl(domain!, "$id");
    return url;
  }

  Future<void> getProductById(int id) async {
    emit(HomeCustomerIsLoading());

    await getIt<GetProductByIdUsecase>().call(GetProductByIdParams(id, AppConsts.categoryScreen)).then((value) => value.fold(
            (error) {
              emit(HomeCustomerFailure(error));
            },
            (success) {
              emit(HomeCustomerSuccess());
              HomeCustomerSuccess.productEntity = success[0];
              emit(HomeCustomerInitial());
            }
    ));
  }



}
