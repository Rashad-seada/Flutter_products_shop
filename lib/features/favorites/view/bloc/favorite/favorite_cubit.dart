import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/di/app_module.dart';
import 'package:eng_shop/core/error/error_messages.dart';
import 'package:eng_shop/features/favorites/domain/usecase/add_to_favorite_usecase.dart';
import 'package:eng_shop/features/favorites/domain/usecase/get_user_favorite_usecase.dart';
import 'package:eng_shop/features/favorites/domain/usecase/remove_from_favorite_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../shop/domain/entity/product_entity.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  int? indexOfLoadingFavoriteProduct;

  Future<void> getFavorites() async {
    FavoriteSuccess.products.clear();
    emit(FavoriteLoading());
    getIt<GetUserFavoriteUsecase>().call(GetUserFavoriteParams(screenCode: AppConsts.favoriteScreen)).then(
      (value) => value.fold(
        (error) {
          emit(FavoriteFailure(error));
          print(ErrorMessages().debugErrorCode(error.code()));
        },
        (success) {
          emit(FavoriteSuccess());

          FavoriteSuccess.products = success;

          FavoriteSuccess.favoriteIds = success.map((e) => int.parse("${e.itemId}")).toList();


          emit(FavoriteInitial());


        }
      )
    );
  }

  addFavorites(int productId,int index,BuildContext context){
    indexOfLoadingFavoriteProduct = index;
    emit(FavoriteLoading());
    getIt<AddToFavoriteUsecase>().call(AddToFavoriteParams(screenCode: AppConsts.favoriteScreen, productId: productId)).then(
            (value) => value.fold(
                (error) {
              emit(FavoriteFailure(error));
              indexOfLoadingFavoriteProduct = null;
              emit(FavoriteInitial());

            },
                (success) {
              emit(FavoriteSuccess());
              CustomFlushBar(
                  title: 'Success ',
                  message: "${success.msg}",
                  context: context
              );
              int index = FavoriteSuccess.favoriteIds.indexWhere((element) => element == productId);
              if(index != -1){

                FavoriteSuccess.favoriteIds.removeAt(index);
              }else{
                FavoriteSuccess.favoriteIds.add(productId);
              }

              indexOfLoadingFavoriteProduct = null;
              emit(FavoriteInitial());


            }
        )
    );
  }

  removeFavorites(int productId,int index,BuildContext context){
    indexOfLoadingFavoriteProduct = index;
    emit(FavoriteItemLoading());
    getIt<RemoveFromFavoriteUsecase>().call(RemoveFromFavoriteParams(screenCode: AppConsts.favoriteScreen, productId: productId)).then(
      (value) => value.fold(
        (error) {
          emit(FavoriteFailure(error));
          indexOfLoadingFavoriteProduct = null;
          emit(FavoriteInitial());

        },
        (success) {
          emit(FavoriteSuccess());
          CustomFlushBar(
            title: 'Success ',
            message: "${success.msg}",
            context: context
          );

          int index = FavoriteSuccess.favoriteIds.indexWhere((element) => element == productId);
          if(index != -1){

            FavoriteSuccess.favoriteIds.removeAt(index);
          }else{
            FavoriteSuccess.favoriteIds.add(productId);
          }
          indexOfLoadingFavoriteProduct = null;
          emit(FavoriteInitial());


        }
      )
    );
  }

  List<int> get getFavoriteProductsIds {
    return FavoriteSuccess.products.map((e) => int.parse("${e.itemId!}")).toList();
  }

  onRefreash() {
    getFavorites();
  }

}
