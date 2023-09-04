import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_checkbox.dart';
import '../../../../core/views/widgets/custom_text_field.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';

class BillingAddressDetails extends StatelessWidget {
  TextEditingController? areaController;
  TextEditingController? cityController;
  TextEditingController? neighborhoodController;
  TextEditingController? addressController;
  TextEditingController? noteController;
  bool saveBillingAddress;
  void Function(bool?)? onChanged;

  BillingAddressDetails(
      {super.key,
      this.areaController,
      this.cityController,
      this.neighborhoodController,
      this.addressController,
      this.noteController,
      this.saveBillingAddress = false,
      this.onChanged,
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
            "*" + LocaleKeys.area.tr(),
            style: AppTheme.textL2TextStyle(color: AppTheme.neutral500),
          ),
          Space(
            height: 0.5.h,
          ),
          CustomTextField(
            borderRadius: BorderRadius.circular(3.w),
            controller: areaController,
            prefixIcon: Padding(
              padding: EdgeInsets.all(1.5.h),
              child: SvgPicture.asset(AppImages.area),
            ),
            hint: LocaleKeys.enter_area.tr(),
          ),
          Space(
            height: 1.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "*" + LocaleKeys.city.tr(),
                      style:
                          AppTheme.textL2TextStyle(color: AppTheme.neutral500),
                    ),
                    Space(
                      height: 0.5.h,
                    ),
                    CustomTextField(
                      borderRadius: BorderRadius.circular(3.w),
                      controller: cityController,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(1.5.h),
                        child: SvgPicture.asset(AppImages.city),
                      ),
                      hint: LocaleKeys.enter_city.tr(),
                    ),
                  ],
                ),
              ),
              Space(
                width: 3.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "*" + LocaleKeys.neighborhood.tr(),
                      style:
                          AppTheme.textL2TextStyle(color: AppTheme.neutral500),
                    ),
                    Space(
                      height: 0.5.h,
                    ),
                    CustomTextField(
                      borderRadius: BorderRadius.circular(3.w),
                      controller: neighborhoodController,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(1.5.h),
                        child: SvgPicture.asset(AppImages.neighborhood),
                      ),
                      hint: LocaleKeys.enter_neighborhood.tr(),
                    ),
                  ],
                ),
              )
            ],
          ),
          Space(
            height: 1.h,
          ),
          Text(
            "*" + LocaleKeys.address.tr(),
            style: AppTheme.textL2TextStyle(color: AppTheme.neutral500),
          ),
          Space(
            height: 0.5.h,
          ),
          CustomTextField(
            borderRadius: BorderRadius.circular(3.w),
            controller: addressController,
            prefixIcon: Padding(
              padding: EdgeInsets.all(1.5.h),
              child: SvgPicture.asset(AppImages.address),
            ),
            hint: LocaleKeys.enter_address.tr(),
          ),
          Space(
            height: 1.h,
          ),
          Text(
            "*" + LocaleKeys.note.tr(),
            style: AppTheme.textL2TextStyle(color: AppTheme.neutral500),
          ),
          Space(
            height: 0.5.h,
          ),
          CustomTextField(
            borderRadius: BorderRadius.circular(3.w),
            controller: noteController,
            prefixIcon: Padding(
              padding: EdgeInsets.all(1.5.h),
              child: SvgPicture.asset(AppImages.note),
            ),
            hint: LocaleKeys.enter_note.tr(),
          ),
          Space(
            height: 3.h,
          ),

          Row(
            children: [
              CustomCheckBox(
                  value: saveBillingAddress,
                  onChanged: (_){
                    if(onChanged != null){
                      onChanged!(_);
                    }
                  }
              ),

              Text(LocaleKeys.remember_me.tr(),style: AppTheme.textMTextStyle(),),
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
