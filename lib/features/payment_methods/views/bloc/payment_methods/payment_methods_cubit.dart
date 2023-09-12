import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cart/view/bloc/cart/cart_cubit.dart';
import '../../../../order/view/screens/payment_datails_screen.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());

  onNextTap(
    BuildContext context,
  ) {
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
