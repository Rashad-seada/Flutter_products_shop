import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/views/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_checkbox.dart';
import '../../../../core/views/widgets/custom_drop_down_menu.dart';
import '../../../../core/views/widgets/custom_text_field.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../additional/domain/entities/get_cities_entity.dart';
import '../../../additional/domain/entities/get_countries_entity.dart';
import '../../../additional/domain/entities/get_regions_entity.dart';
import '../../../auth/views/components/phone_number_field.dart';

class BillingAddressDetails extends StatelessWidget {
  int? country;
  List<GetCountriesEntity> countries;
  Function(int?)? onCountryChanged;
  bool isCountriesLoading;

  int? region;
  List<GetRegionsEntity> regions;
  Function(int?)? onRegionChanged;
  bool isRegionsLoading;

  int? city;
  List<GetCitiesEntity> cities;
  Function(int?)? onCityChanged;
  bool isCitiesLoading;

  TextEditingController? addressController;
  bool saveBillingAddress;
  void Function(bool?)? onChanged;

  TextEditingController? phoneController;
  PhoneNumber initialPhoneValue;
  void Function(bool)? onPhoneValidated;
  void Function(PhoneNumber)? onPhoneChanged;
  String? Function(String?)? phoneValidator;

  String? Function(String?)? addressValidator;

  Key? formKey;

  BillingAddressDetails({
    super.key,
    this.region,
    required this.regions,
    this.onRegionChanged,
    this.isRegionsLoading = false,
    this.city,
    required this.cities,
    this.onCityChanged,
    this.isCitiesLoading = false,
    this.country,
    required this.countries,
    this.onCountryChanged,
    this.isCountriesLoading = false,

    this.addressController,
    this.saveBillingAddress = false,
    this.onChanged,

    required this.initialPhoneValue,
    this.onPhoneValidated,
    this.onPhoneChanged,
    this.phoneValidator,
    this.addressValidator,
    this.formKey,
    this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.neutral100,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "*" + LocaleKeys.country.tr(),
            style: AppTheme.textL2TextStyle(color: AppTheme.neutral500),
          ),
          CustomDropDownButton<int>(
            borderRadius: BorderRadius.all(Radius.circular(3.w)),

            hint: LocaleKeys.country_hint.tr(),
            value: country,
            items: countries.map((e) => DropdownMenuItem(
                      value: e.id,
                      child: Text("${e.etxt}"),
                    ))
                .toList(),
            onChanged: onCountryChanged,
            suffixIcon: isCountriesLoading ? CustomProgressIndicator() : null,
          ),

          Space(
            height: 1.h,
          ),
          Text(
            "*" + LocaleKeys.area.tr(),
            style:
                AppTheme.textL2TextStyle(color: AppTheme.neutral500),
          ),
          CustomDropDownButton<int>(
            borderRadius: BorderRadius.all(Radius.circular(3.w)),
            hint: LocaleKeys.enter_area.tr(),
            value: region,
            items: regions
                .map((e) => DropdownMenuItem(
                      value: e.id,
                      child: Text("${e.etxt}"),
                    ))
                .toList(),
            onChanged: onRegionChanged,
            suffixIcon: isRegionsLoading ? CustomProgressIndicator() : null,

          ),

          Space(
            height: 1.h,
          ),
          Text(
            "*" + LocaleKeys.city.tr(),
            style:
                AppTheme.textL2TextStyle(color: AppTheme.neutral500),
          ),
          CustomDropDownButton<int>(
            borderRadius: BorderRadius.all(Radius.circular(3.w)),
            hint: LocaleKeys.enter_city.tr(),
            value: city,
            items: cities
                .map((e) => DropdownMenuItem(
                      value: e.id,
                      child: Text("${e.etxt}"),
                    ))
                .toList(),
            onChanged: onCityChanged,
            suffixIcon: isCitiesLoading ? CustomProgressIndicator() : null,

          ),

          Space(
            height: 1.h,
          ),
          Text(
            "*" + LocaleKeys.address.tr(),
            style: AppTheme.textL2TextStyle(color: AppTheme.neutral500),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [

                CustomTextField(
                  borderRadius: BorderRadius.circular(3.w),
                  controller: addressController,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(1.5.h),
                    child: SvgPicture.asset(AppImages.address),
                  ),
                  hint: LocaleKeys.enter_address.tr(),
                  validator: addressValidator,
                ),

                Space(
                  height: 3.h,
                ),

                PhoneNumberField(
                  controller: phoneController,
                  initialValue: initialPhoneValue,
                  onInputValidated: onPhoneValidated,
                  onInputChanged: onPhoneChanged,
                  validator: phoneValidator,
                ),

              ],
            ),
          ),



          Space(
            height: 2.h,
          ),
          Row(
            children: [
              CustomCheckBox(
                  value: saveBillingAddress,
                  onChanged: (_) {
                    if (onChanged != null) {
                      onChanged!(_);
                    }
                  }),
              Text(
                LocaleKeys.remember_me.tr(),
                style: AppTheme.textMTextStyle(),
              ),
            ],
          ),
          Space(
            height: 1.h,
          ),
        ],
      ),
    );
  }
}
