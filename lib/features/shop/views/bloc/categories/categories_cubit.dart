
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../search/views/screens/search_screen.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void onSearchTap(BuildContext context) {
    Navigator.push(context,MaterialPageRoute(builder: (_)=> SearchScreen() )) ;
  }

  void onFavoritesClick() {

  }

  onRefreash() {}


}
