

import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/search/domain/usecase/search_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/app_module.dart';
import '../../../../shop/domain/entity/product_entity.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  onCancelTap(BuildContext context) {
    SearchSuccess.products.clear();
    Navigator.pop(context);
  }

  search(String searchTerm) {
    emit(SearchLoading());
    if(searchTerm.trim().isNotEmpty){
      getIt<SearchUsecase>().call(SearchParams(searchTerm, AppConsts.searchScreen)).then((value) => value.fold(
              (error) {
            emit(SearchFailure(error));
            emit(SearchInitial());
          },
              (success) {
            emit(SearchSuccess());
            SearchSuccess.products = success;
            emit(SearchInitial());
          }
      ));
    }

  }

  onSearchSubmitted(String searchTerm) {
    search(searchTerm);
  }
}
