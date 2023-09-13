import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/features/additional/domain/entities/get_cities_entity.dart';
import 'package:eng_shop/features/additional/domain/entities/get_countries_entity.dart';
import 'package:eng_shop/features/additional/domain/entities/get_regions_entity.dart';
import 'package:eng_shop/features/additional/domain/usecases/get_cities_usecase.dart';
import 'package:eng_shop/features/additional/domain/usecases/get_countries_usecase.dart';
import 'package:eng_shop/features/additional/domain/usecases/get_regions_usecase.dart';
import 'package:eng_shop/features/cart/view/bloc/cart/cart_cubit.dart';
import 'package:eng_shop/features/order/domain/usecase/get_billing_address_usecase.dart';
import 'package:eng_shop/features/order/domain/usecase/make_order_items_usecase.dart';
import 'package:eng_shop/features/order/domain/usecase/put_billing_address_usecase.dart';
import 'package:eng_shop/features/shop/views/bloc/home/home_cubit.dart';
import 'package:eng_shop/features/shop/views/screens/home_screen.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../core/di/app_module.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../auth/domain/usecase/get_user_type_usecase.dart';
import '../../../../cart/domain/entity/cart_entity.dart';
import '../../../../payment_methods/views/screens/payment_methods_screen.dart';
import '../../../domain/entities/billing_address_entity.dart';
import '../../../domain/usecase/make_order_usecase.dart';
import '../../screens/order_complete_screen.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  Future initBillingAddress(BuildContext context) async {
    getBillingAddress().then(
            (value) async {

              if(billingAddress != null){

                countryId = billingAddress!.countryId;
                areaId = billingAddress!.areaId;
                cityId = billingAddress!.cityId;
                addressController.text = billingAddress!.address;
                phoneController.text = billingAddress!.phone;
                phoneNumber = billingAddress!.phone;

                await getCountries(context,selectCounty: true);
                await getRegions(context, billingAddress!.countryId,selectRegion: true);
                await getCities(context, billingAddress!.areaId,selectCity: true);

              } else {
                getCountries(context);
              }

            }
    );

    getCountries(context);


  }

  TextEditingController promoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String phoneNumber = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  int? countryId;
  int? areaId;
  int? cityId;

  bool isCountriesLoading = false;
  bool isAreasLoading = false;
  bool isCitiesLoading = false;

  bool saveBillingAddress = false;

  PhoneNumber initialPhoneValue = PhoneNumber(isoCode: "KW" );
  bool isPhoneNumberValid = false;

  BillingAddressEntity? billingAddress;

  void onPhoneValidated(bool value){
    isPhoneNumberValid = value;
  }

  void onPhoneChanged(PhoneNumber value){
    if(value.phoneNumber != null) {
      phoneNumber = value.phoneNumber!;
      print(phoneNumber);
    }
  }

  bool validateBillingAddress(BuildContext context){
    if(countryId == null) {
      CustomFlushBar(
          title: LocaleKeys.country.tr(),
          message: LocaleKeys.country_validate_message.tr(),
          context: context
      );
      return false;
    }
    if(areaId == null) {
      CustomFlushBar(
          title: LocaleKeys.area.tr(),
          message: LocaleKeys.area_validate_message.tr(),
          context: context
      );
      return false;

    }
    if(cityId == null) {
      CustomFlushBar(
          title: LocaleKeys.city.tr(),
          message: LocaleKeys.city_validate_message.tr(),
          context: context
      );
      return false;
    }
    return true;
  }

  addressValidator(String? s) {
    if (addressController.text.isNotEmpty) {
      return null;
    } else {
      return "Please enter your address";
    }
  }

  String? phoneValidator(String value){
    if (isPhoneNumberValid) {
      return null;
    } else {
      return "Please enter a valid phone number";
    }
  }

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
    if(validateBillingAddress(context) && formKey.currentState!.validate() ){

      if(saveBillingAddress){
        putPillingAddress(
            BillingAddressEntity(
                countryId: countryId!,
                areaId: areaId!,
                cityId: cityId!,
                address: addressController.text,
                phone: phoneNumber
            ));
      }


      Navigator.push(context, MaterialPageRoute(builder: (_)=> PaymentMethodsScreen(
        totalItemsPrice: context.read<CartCubit>().calculateTotalPrice(),
        products: products,
      )));
    }

  }

  void onRegionChanged(int region,BuildContext context){
    areaId = region;
    getCities(context,region);
  }

  void onCityChanged(int city,BuildContext context){
    cityId = city;
  }

  void onCountryChanged(int country,BuildContext context){
    countryId = country;
    getRegions(context,country);
  }

  makeOrder(BuildContext context,{required List<CartEntity> products,required String paidAmount}){
    emit(OrderLoading());
    getIt<MakeOrderUsecase>().call(MakeOrderParams(
        countryId: "$countryId",
        regionId: "$areaId",
        cityId: "$cityId",
        district: "",
        address: addressController.text,
        mobile: extractPlusFromPhoneNumber(phoneNumber),
        note: "",
        itemsCount: products.length,
        paidAmount: paidAmount,
        screenCode: AppConsts.billingAddressScreen
    )).then((value) => value.fold(
        (error) {
          emit(OrderFailure(error));
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
              emit(OrderFailure(error));
              CustomFlushBar(
                  title: "Error",
                  message: error.message.toString(),
                  context: context
              );
        },
            (success) {

              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> OrderCompleteScreen()), (route) => false);
              emit(OrderSuccess());
              emit(OrderInitial());
            }
    ));

  }

  Future getCountries(BuildContext context, {bool selectCounty = false}) async {
    selectCounty? null : OrderSuccess.countries.clear();
    selectCounty? null : OrderSuccess.cities.clear();
    selectCounty? null : OrderSuccess.regions.clear();
    selectCounty? null : countryId = null;
    isCountriesLoading = true;
    emit(OrderLoading());

    await getIt<GetCountriesUsecase>().call(GetCountriesParams(screenCode: AppConsts.billingAddressScreen)).then(

      (value) => value.fold(
        (error) {
          emit(OrderFailure(error));
          isCountriesLoading = false;

        },
        (success) {
          isCountriesLoading = false;
          OrderSuccess.countries = success;
          emit(OrderSuccess());
          emit(OrderInitial());
        }
      )
    );
  }

  Future getRegions(BuildContext context,int countryId,{bool selectRegion = false}) async {
    isAreasLoading = true;
    selectRegion? null : areaId = null;
    selectRegion? null : OrderSuccess.cities.clear();
    selectRegion? null : OrderSuccess.regions.clear();

    emit(OrderLoading());

    await getIt<GetRegionsUsecase>().call(GetRegionsParams(screenCode: AppConsts.billingAddressScreen, countryId: countryId)).then(
            (value) => value.fold(
                (error) {
                  emit(OrderFailure(error));
                  isAreasLoading = false;


            },
                (success) {
                  OrderSuccess.regions = success;
                  isAreasLoading = false;
                  emit(OrderSuccess());
                  emit(OrderInitial());
            }
        )
    );
  }

  Future getCities(BuildContext context,int regionsId,{bool selectCity = false}) async {
    isCitiesLoading = true;
    selectCity? null : cityId = null ;
    selectCity? null : OrderSuccess.cities.clear();
    print("region id : $regionsId and "+OrderSuccess.cities.toString());
    emit(OrderLoading());

    await getIt<GetCitiesUsecase>().call(GetCitiesParams(screenCode: AppConsts.billingAddressScreen, regionsId: regionsId)).then(
            (value) => value.fold(
                (error) {
                  emit(OrderFailure(error));
                  isCitiesLoading = false;

            },
                (success) {
                  OrderSuccess.cities = success;
                  emit(OrderSuccess());
                  isCitiesLoading = false;
                  emit(OrderInitial());

                }
        )
    );
  }

  String extractPlusFromPhoneNumber(String number){
    List numberInList = number.split("");
    for(int i = 0; i < numberInList.length; ++i ){
      if(numberInList[i] == "+"){
        numberInList.removeAt(i);
        return numberInList.join();
      }
    }
    return number;
  }

  Future getBillingAddress() async {
    emit(OrderLoading());
    await getIt<GetBillingAddressUsecase>().call(GetBillingAddressParams(AppConsts.billingAddressScreen)).then(
            (value) => value.fold(
                    (error) {
                      emit(OrderFailure(error));
                      emit(OrderInitial());
                    },
                    (success) {
                      emit(OrderSuccess());
                      billingAddress = success;
                      emit(OrderInitial());
                    },
            )
    );
  }

  putPillingAddress(BillingAddressEntity billingAddressEntity){
    emit(OrderLoading());
    getIt<PutBillingAddressUsecase>().call(PutBillingAddressParams(billingAddressEntity: billingAddressEntity, screenCode: AppConsts.billingAddressScreen)).then(
            (value) => value.fold(
                    (error) {
                      emit(OrderFailure(error));
                      emit(OrderInitial());

                    },
                    (success) {
                      emit(OrderSuccess());
                      emit(OrderInitial());

                      print("putPillingAddress success");

                    }
            ));
  }




}
