import 'package:bloc/bloc.dart';
import 'package:eng_shop/features/shop/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/usecase/products/get_product_by_id_usecase.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  Future<void> getProductById(int id) async {
    emit(DetailsLoading());

    await getIt<GetProductByIdUsecase>().call(GetProductByIdParams(id, AppConsts.categoryScreen)).then((value) => value.fold(
            (error) {
          emit(DetailsFailure(error));
        },
            (success) {
          emit(DetailsSuccess());
          DetailsSuccess.productEntity = success[0];
          emit(DetailsInitial());
        }
    ));
  }
}
