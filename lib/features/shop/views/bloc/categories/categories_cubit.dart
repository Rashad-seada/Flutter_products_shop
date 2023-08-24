
import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/features/shop/domain/entity/category_entity.dart';
import 'package:eng_shop/features/shop/domain/usecase/categories/get_all_categories_usecase.dart';
import 'package:eng_shop/features/shop/domain/usecase/categories/get_sub_categories_usecase.dart';
import 'package:eng_shop/features/shop/views/bloc/category_product/category_product_cubit.dart';
import 'package:eng_shop/features/shop/views/screens/category_products_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_module.dart';
import '../../../../../core/error/failure.dart';
import '../../../../search/views/screens/search_screen.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void onSearchTap(BuildContext context) {
    Navigator.push(context,MaterialPageRoute(builder: (_)=> SearchScreen() )) ;
  }

  void onFavoritesClick() {

  }

  int selectedCategoryIndex = 0;



  onRefreash() {
    selectedCategoryIndex = 0;
    getAllCategories();
  }

  getAllCategories(){
    CategoriesSuccess.categories.clear();
    CategoriesSuccess.subCategories.clear();

    emit(CategoriesLoading());
    getIt<GetAllCategoriesUsecase>().call(GetAllCategoriesParams(AppConsts.categoryScreen)).then(
      (value) => value.fold(
        (error) {
          emit(CategoriesFailure(error));

        },
        (success) {
          emit(CategoriesSuccess());
          CategoriesSuccess.categories = success;
          emit(CategoriesInitial());

          getSubCategories(int.parse("${CategoriesSuccess.categories[selectedCategoryIndex].id!}"));

        }
      )
    );

  }

  getSubCategories(int parentCategoryId){

    emit(CategoriesSubLoading());
    getIt<GetSubCategoriesUsecase>().call(GetSubCategoriesParams(parentCategoryId,AppConsts.categoryScreen)).then(
            (value) => value.fold(
                (error) {
              emit(CategoriesFailure(error));


            },
                (success) {
              emit(CategoriesSuccess());
              if(!CategoriesSuccess.subCategories.contains(success)) {
                CategoriesSuccess.subCategories.add(success);
              }
              emit(CategoriesInitial());

            }
        )
    );
  }

  void onCategoryTap(int index,CategoryEntity categoryEntity){
    if(selectedCategoryIndex != index){
      selectedCategoryIndex = index;

      if(CategoriesSuccess.subCategories.elementAtOrNull(selectedCategoryIndex) == null){
        getSubCategories(int.parse("${categoryEntity.id!}"));
      }else {
        emit(CategoriesSuccess());
        emit(CategoriesInitial());
      }

    }

  }

  void onSubCategoryTap(int index, CategoryEntity categoryEntity,BuildContext context) {
    context.read<CategoryProductCubit>().pageNumber = 1;
    context.read<CategoryProductCubit>().getCategoryProducts(categoryEntity);
    Navigator.push(context, MaterialPageRoute(builder: (_)=> CategoryProductsScreen()));
  }


}
