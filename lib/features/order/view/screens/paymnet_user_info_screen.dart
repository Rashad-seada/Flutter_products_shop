import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/cart/view/bloc/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../bloc/order/order_cubit.dart';
import '../components/billing_address_details.dart';

class PaymentUserInfoScreen extends StatefulWidget {
  const PaymentUserInfoScreen({super.key});

  @override
  State<PaymentUserInfoScreen> createState() => _PaymentUserInfoScreenState();
}

class _PaymentUserInfoScreenState extends State<PaymentUserInfoScreen> {

  @override
  void initState() {
    context.read<OrderCubit>().initBillingAddress(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<OrderCubit,OrderState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: SizedBox(
                width: 100.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [

                      Space(height: 2.h,),

                      Stack(
                        children: [

                          CustomBackButton(),

                          Center(
                            child: Text(LocaleKeys.user_info.tr(),
                              style: AppTheme.heading3TextStyle(),),
                          ),

                        ],
                      ),
                      Space(height: 2.h,),


                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Text(LocaleKeys.billing_address.tr(),
                                style: AppTheme.textL2TextStyle(color: AppTheme.neutral400),),
                              Space(height: 1.h,),

                            ],
                          ),
                        ],
                      ),
                      Space(height: 0.5.h,),


                      BillingAddressDetails(
                        phoneController: context.read<OrderCubit>().phoneController,
                        formKey: context.read<OrderCubit>().formKey,
                        addressValidator: (_)=> context.read<OrderCubit>().addressValidator(_),
                        region: context.read<OrderCubit>().areaId,
                        city: context.read<OrderCubit>().cityId,
                        country: context.read<OrderCubit>().countryId,
                        addressController: context.read<OrderCubit>().addressController,
                        saveBillingAddress: context.read<OrderCubit>().saveBillingAddress,
                        onChanged: (_)=> context.read<OrderCubit>().onChanged(_!),
                        regions: OrderSuccess.regions,
                        cities: OrderSuccess.cities,
                        countries: OrderSuccess.countries,
                        onRegionChanged: (_)=>  context.read<OrderCubit>().onRegionChanged(_!,context),
                        onCityChanged: (_)=>  context.read<OrderCubit>().onCityChanged(_!,context),
                        onCountryChanged: (_)=>  context.read<OrderCubit>().onCountryChanged(_!,context),
                        isCountriesLoading: context.read<OrderCubit>().isCountriesLoading,
                        isCitiesLoading: context.read<OrderCubit>().isCitiesLoading,
                        isRegionsLoading: context.read<OrderCubit>().isAreasLoading, 
                        
                        initialPhoneValue: context.read<OrderCubit>().initialPhoneValue,
                        onPhoneChanged: (_)=> context.read<OrderCubit>().onPhoneChanged(_),
                        onPhoneValidated: (_)=> context.read<OrderCubit>().onPhoneValidated(_),
                        phoneValidator: (_)=> context.read<OrderCubit>().phoneValidator(_!),

                      ),


                      Space(height: 4.h,),




                      MainButton(
                        height: 7.h,
                        label: Text(LocaleKeys.next.tr(),style: AppTheme.textL2TextStyle(color: AppTheme.neutral100),),
                        onTap: ()=> context.read<OrderCubit>().onNextTap(context,CartSuccess.cart.map((e) => e.cartEntity).toList()),
                      ),

                      Space(height: 5.h,),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
