part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchFailure extends SearchState {
  static Failure myError = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);

  SearchFailure(Failure error){
    myError = error;
  }

  @override
  List<Object> get props => [];
}

class SearchSuccess extends SearchState {
  static List<ProductEntity> products = [];
  static List<RecentSearchEntity> recentSearches = [];

  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchResult extends SearchState {
  @override
  List<Object> get props => [];
}
