import 'package:bloc/bloc.dart';
import 'package:eng_shop/features/In_app_payments/view/screens/paymnet_user_info_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

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

  confirm(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (_)=> PaymentUserInfoScreen()));
  }

  onNextTap(){

  }


}
