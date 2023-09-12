import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/views/widgets/custom_back_button.dart';
import 'package:eng_shop/features/payment_methods/views/bloc/payment_methods/payment_methods_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../cart/domain/entity/cart_entity.dart';

class PaymentMethodsScreen extends StatelessWidget {
  double totalItemsPrice;
  List<CartEntity> products;

  PaymentMethodsScreen(
      {super.key, required this.products, required this.totalItemsPrice});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Space(
                    height: 2.h,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(left: 0, child: CustomBackButton()),
                      Text(
                        LocaleKeys.payment_methods.tr(),
                        style: AppTheme.heading3TextStyle(),
                      ).tr(),
                    ],
                  ),
                  Space(
                    height: 2.h,
                  ),
                  MainButton(
                    height: 7.h,
                    label: Text(
                      LocaleKeys.next.tr(),
                      style:
                          AppTheme.textL2TextStyle(color: AppTheme.neutral100),
                    ),
                    onTap: () => context.read<PaymentMethodsCubit>().onNextTap(context),
                  ),
                  Space(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
