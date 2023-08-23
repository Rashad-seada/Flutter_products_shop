

import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/search/domain/usecase/delete_all_recent_search_usecase.dart';
import 'package:eng_shop/features/search/domain/usecase/delete_recent_search_usecase.dart';
import 'package:eng_shop/features/search/domain/usecase/get_recent_search_usecase.dart';
import 'package:eng_shop/features/search/domain/usecase/insert_recent_search_usecase.dart';
import 'package:eng_shop/features/search/domain/usecase/search_usecase.dart';
import 'package:eng_shop/features/search/views/screens/search_result_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/app_module.dart';
import '../../../../shop/domain/entity/product_entity.dart';
import '../../../domain/entity/recent_search_entity.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  onCancelTap(BuildContext context) {
    SearchSuccess.products.clear();
    Navigator.pop(context);
  }

  search(String searchTerm) {
    emit(SearchLoading());
    if(searchTerm.trim().isNotEmpty){
      insertRecentSearch();
      getIt<SearchUsecase>().call(SearchParams(searchTerm, AppConsts.searchScreen)).then((value) => value.fold(
              (error) {
            emit(SearchFailure(error));
          },
              (success) {
            emit(SearchSuccess());
            SearchSuccess.products = success;
            emit(SearchResult());
          }
      ));
    }
  }

  insertRecentSearch(){
    getIt<InsertRecentSearchUsecase>().call(InsertRecentSearchParams(RecentSearchEntity(searchTerm: searchController.text), AppConsts.searchScreen)).then((value) => value.fold(
            (error) {},
            (success) {}
    ));
  }

  getRecentSearch(){
    getIt<GetRecentSearchUsecase>().call(GetRecentSearchParams(AppConsts.searchScreen)).then((value) => value.fold(
            (error) {
          emit(SearchFailure(error));
          emit(SearchInitial());
        },
            (success) {
          emit(SearchSuccess());
          SearchSuccess.recentSearches = success;
          print(success);
          emit(SearchInitial());
        }
    ));
  }

  deleteRecentSearch(RecentSearchEntity recentSearchEntity){
    getIt<DeleteRecentSearchUsecase>().call(DeleteRecentSearchParams(recentSearchEntity, AppConsts.searchScreen)).then((value) => value.fold(
        (error) {},
        (success) {}
    ));
  }

  deleteAllRecentSearch(){
    getIt<DeleteAllRecentSearchUsecase>().call(DeleteAllRecentSearchParams(AppConsts.searchScreen)).then((value) => value.fold(
            (error) {
              emit(SearchFailure(error));
              emit(SearchInitial());
            },
            (success) {
              emit(SearchSuccess());
              SearchSuccess.recentSearches.clear();
              emit(SearchInitial());
            }
    ));
  }



  onSearchSubmitted(BuildContext context) {
    search(searchController.text);
    Navigator.push(context,MaterialPageRoute(builder: (_)=> SearchResultScreen()));
  }

  onClearTap() {
    deleteAllRecentSearch();
  }

  onChangeSearch(){
    emit(SearchInitial());

  }

  onRecentSearchTap(String s,BuildContext context) {
    searchController.text = s;
    search(searchController.text);
    Navigator.push(context,MaterialPageRoute(builder: (_)=> SearchResultScreen()));
  }


}
