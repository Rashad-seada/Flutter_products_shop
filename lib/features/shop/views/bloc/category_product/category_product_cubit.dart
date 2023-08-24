
import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/features/search/views/screens/search_screen.dart';
import 'package:eng_shop/features/shop/domain/entity/category_entity.dart';
import 'package:eng_shop/features/shop/domain/usecase/categories/get_category_products_usecase.dart';
import 'package:eng_shop/features/shop/views/pages/cart_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../core/di/app_module.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entity/product_entity.dart';

part 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  CategoryProductCubit() : super(CategoryProductInitial()){
    scrollController = ScrollController();
    scrollController.addListener(()=> _listener());
  }

  void _listener(){
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels == 0) {
        // Top of the scrollable area
      } else {
        print("at the end of the page");
        getCategoryProducts(myCategoryEntity);
      }
    }
  }

  late CategoryEntity myCategoryEntity;

  ScrollController scrollController = ScrollController();

  int pageNumber = 1;


  void getCategoryProducts(CategoryEntity categoryEntity) {
    print("input $pageNumber");
    myCategoryEntity = categoryEntity;
    emit(CategoryProductLoading());
    getIt<GetCategoryProductsUsecase>().call(GetCategoryProductsParams(pageNumber,categoryEntity, AppConsts.categoryProductScreen)).then(
            (value) => value.fold(
              (error) {
              emit(CategoryProductFailure(error));
              print(error.message);
              print("error : $pageNumber");

            },
            (success) {

              ++pageNumber;
              print("success : $pageNumber");

              emit(CategoryProductSuccess());

              if(!success.every((element) => CategoryProductSuccess.products.map((e) => e.id).contains(element.id))){
                CategoryProductSuccess.products.addAll(success);
              }


              emit(CategoryProductInitial());

            }
        )
    );
  }

  onBackTap(BuildContext context) {
    Navigator.pop(context);
    print(pageNumber);
  }

  onSearchTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_)=> const SearchScreen()));
  }

  onCartTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_)=> CartPage(withBackBotton: true,)));
  }



}
