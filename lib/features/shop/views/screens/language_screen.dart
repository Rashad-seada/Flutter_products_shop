import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../bloc/language/language_cubit.dart';
import '../components/language/language_item.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();

}

class _LanguageScreenState extends State<LanguageScreen> {

  @override
  void initState() {
    context.read<LanguageCubit>().initLanguage(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: 100.w,
            child: SingleChildScrollView(
              child: BlocConsumer<LanguageCubit, LanguageState>(
                listener: (context, state) {
                  print(state);
                },
                builder: (context, state) {
                  return Column(
                    children: [


                      Space(height: 5.h,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            (state is LanguageChanging)? circleIndicator() : CustomBackButton(),
                            Text(LocaleKeys.language.tr(), style: AppTheme.heading2TextStyle(),).tr(),

                            Space(width: 5.w,),

                          ],
                        ),
                      ),

                      Space(height: 4.h,),

                      ListView.builder(
                        itemCount: context.read<LanguageCubit>().languages.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index) {

                          return LanguageItem(
                              isActive: context.read<LanguageCubit>().languages[index].isActive,
                              label: context.read<LanguageCubit>().languages[index].label,
                              image: context.read<LanguageCubit>().languages[index].image,
                              onTap: ()=> context.read<LanguageCubit>().onLanguageClick(index,context),
                              locale: context.read<LanguageCubit>().languages[index].locale,
                          );

                        }
                      ),

                    ],
                  );
                },
              ),
            ),
          ),
        )
    );
  }

  Widget circleIndicator(){
    return  Padding(
      padding: EdgeInsets.all(3.w),
      child: SizedBox(width:4.w,height:4.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: AppTheme.neutral900,)),
    );
  }
}



