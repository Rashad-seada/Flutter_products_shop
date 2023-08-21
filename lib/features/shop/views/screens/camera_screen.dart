import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../bloc/camera/camera_cubit.dart';
import '../components/camera/camera_item.dart';
import '../components/camera/photos_section.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: SingleChildScrollView(
                child: BlocConsumer<CameraCubit, CameraState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Column(
                      children: [
                        Space(height: 5.h,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            CustomBackButton(),

                            Text(LocaleKeys.camera.tr(),
                              style: AppTheme.heading2TextStyle(),),

                            Space(width: 5.w,),

                          ],
                        ),

                        Space(height: 4.h,),

                        CameraItem(
                          onTap: () => context.read<CameraCubit>().onCameraTap(),
                        ),
                        Space(height: 3.h,),

                        Row(
                          children: [
                            Text(LocaleKeys.camera_sub_text2.tr(), style: AppTheme.textMTextStyle(),),
                          ],
                        ),
                        Space(height: 3.h,),


                        PhotosSection(
                          photos: context.read<CameraCubit>().photos,
                        ),
                        Space(height: 3.h,),


                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        )
    );
  }
}
