
import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/features/cart/view/bloc/cart/cart_cubit.dart';
import 'package:eng_shop/features/order/domain/usecase/make_order_items_usecase.dart';
import 'package:eng_shop/features/shop/views/bloc/home/home_cubit.dart';
import 'package:eng_shop/features/shop/views/bloc/home_customer/home_customer_cubit.dart';
import 'package:eng_shop/features/shop/views/screens/home_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart'; // Import the services package

import '../../../../../core/di/app_module.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../auth/domain/usecase/get_user_type_usecase.dart';
import '../../../../cart/domain/entity/cart_entity.dart';
import '../../../domain/usecase/make_order_usecase.dart';
import '../../screens/order_complete_screen.dart';
import '../../screens/payment_datails_screen.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  TextEditingController promoController = TextEditingController();

  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  bool saveBillingAddress = true;

  void onChanged(bool value){
    saveBillingAddress = value;
  }

  apply(BuildContext context) {}

  onApply(BuildContext context){
    apply(context);
  }

  confirm(BuildContext context,List<CartEntity> products,String paidAmount){
    makeOrder(context,products: products, paidAmount: paidAmount);
  }

  onDoneClick(BuildContext context) async {
    await getIt<GetUserTypeUsecase>().call(GetUserTypeParams(AppConsts.languageScreen)).then((
    value) => value.fold(
    (error) {

    },
    (success) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> HomeScreen(userType: success!, context: context)), (route) => false);
      context.read<HomeCubit>().onNavigationBarTap(0);
    }
    ));
  }

  onNextTap(BuildContext context,List<CartEntity> products,){

    Navigator.push(context, MaterialPageRoute(builder: (_)=> PaymentDetailsScreen(
      totalItemsPrice: context.read<CartCubit>().calculateTotalPrice(),
      products: products,
      )));


  }



  makeOrder(BuildContext context,{required List<CartEntity> products,required String paidAmount}){
    emit(OrderLoading());
    getIt<MakeOrderUsecase>().call(MakeOrderParams(
        countryId: "",
        regionId: areaController.text,
        cityId: cityController.text,
        district: neighborhoodController.text,
        address: addressController.text,
        mobile: "",
        note: noteController.text,
        itemsCount: products.length,
        paidAmount: paidAmount,
        screenCode: AppConsts.billingAddressScreen
    )).then((value) => value.fold(
        (error) {
          emit(OrderFailure());
          CustomFlushBar(
              title: "Error",
              message: error.message,
              context: context
          );
        },
        (success) {
          makeOrderItems(
            context,
              orderId: int.parse(success.res!),
              paidAmount: paidAmount,
              products: products,
          );


          emit(OrderSuccess());
          emit(OrderInitial());
        }
    ));
  }

  makeOrderItems(
      BuildContext context,
      {required int orderId,
        required String paidAmount,
        required List<CartEntity> products}){
    getIt<MakeOrderItemsUsecase>().call(MakeOrderItemsParams(
        orderId: orderId.toString(),
        paidAmount: paidAmount,
        products: products,
        screenCode: AppConsts.billingAddressScreen,
    )).then((value) => value.fold(
            (error) {
              emit(OrderFailure());
              CustomFlushBar(
                  title: "Error",
                  message: error.message.toString(),
                  context: context
              );
        },
            (success) {
              emit(OrderSuccess());

              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> OrderCompleteScreen()), (route) => false);

              emit(OrderInitial());
            }
    ));

  }


}
