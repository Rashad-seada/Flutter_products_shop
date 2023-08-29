
import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/error/error_messages.dart';
import 'package:eng_shop/core/views/components/error_message.dart';
import 'package:eng_shop/features/categories/domain/entities/category_entity.dart';
import 'package:eng_shop/features/categories/domain/usecase/get_all_categories_usecase.dart';
import 'package:eng_shop/features/categories/views/screens/category_products_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_module.dart';
import '../../../../../core/error/failure.dart';
import '../../../../search/views/screens/search_screen.dart';
import '../../../domain/usecase/get_sub_categories_usecase.dart';
import '../category_product/category_product_cubit.dart';

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
    selectedCategoryIndex = 0;
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
    if(selectedCategoryIndex != index && state is! CategoriesLoading){
      selectedCategoryIndex = index;

      if(CategoriesSuccess.subCategories.elementAtOrNull(selectedCategoryIndex) == null){

        getSubCategories(int.parse("${categoryEntity.id!}"));

      }else {
        emit(CategoriesSuccess());
        emit(CategoriesInitial());
      }

    }

  }

  List<CategoryEntity> getSubCategory(){
    return CategoriesSuccess.subCategories.elementAtOrNull(selectedCategoryIndex) ?? [];
  }

  void onSubCategoryTap(int index, CategoryEntity categoryEntity,BuildContext context) {
    context.read<CategoryProductCubit>().pageNumber = 1;
    context.read<CategoryProductCubit>().getCategoryProducts(categoryEntity);
    Navigator.push(context, MaterialPageRoute(builder: (_)=> CategoryProductsScreen()));
  }


}
