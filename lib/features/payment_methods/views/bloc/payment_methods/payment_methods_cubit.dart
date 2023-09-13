import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/app_images.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../cart/view/bloc/cart/cart_cubit.dart';
import '../../../../order/view/screens/payment_datails_screen.dart';
import '../../util/payment_method.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());

  int? selectedIndex;

  List<PaymentMethod> get paymentMethods => [
    PaymentMethod(
      isSelected: true,
      icon: AppImages.cash,
      label: LocaleKeys.cash.tr(),
      discription: LocaleKeys.cash_sub_text.tr(),
      methodImages: [
        AppImages.money
      ],
    ),

    PaymentMethod(
      isSelected: false,
      icon: AppImages.card,
      label: LocaleKeys.card.tr(),
      discription: LocaleKeys.card_sub_text.tr(),
      methodImages: [
        AppImages.mastercard,
        AppImages.visa
      ],
    )
  ];


  onNextTap(
    BuildContext context,
  ) {

    if(selectedIndex == null){
      CustomFlushBar(
          title: LocaleKeys.payment_methods.tr(),
          message: LocaleKeys.payment_methods_hint.tr(),
          context: context
      );

    }else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PaymentDetailsScreen(
                totalItemsPrice:
                context.read<CartCubit>().calculateTotalPrice(),
                products: CartSuccess.cart.map((e) => e.cartEntity).toList(),
              )));
    }

  }

  void onMethodTap(int index,) {
    emit(PaymentMethodsSelect());
    selectedIndex = index;
    emit(PaymentMethodsSuccess());

  }

}
