import 'package:eng_shop/core/views/widgets/fade_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../config/app_theme.dart';
import '../widgets/main_button.dart';
import '../widgets/space.dart';

class MessageScreen extends StatelessWidget {
  String message;
  String messageSubText;
  String image;
  String buttonLabel;
  Widget? screen;

  MessageScreen({
    super.key,
    required this.message,
    required this.messageSubText,
    required this.image,
    required this.buttonLabel,
    this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Column(
              children: [
                Space(height: 27.h,),

                FadeInAnimation(child: SvgPicture.asset(image,width: 100.w,height: 20.h,)),

                Space(height: 5.h,),
                Column(
                  children: [
                    Text(message, style: AppTheme.heading2TextStyle(),),

                    Space(height: 1.h,),

                    Text(messageSubText, style: AppTheme.textLTextStyle(),textAlign: TextAlign.center,),
                  ],
                ),

                Space(height: 20.h,),


                MainButton(width: 100.w,height: 7.h,label: Text(buttonLabel,style: AppTheme.textLTextStyle(color: AppTheme.neutral100),),onTap: (){
                  if(screen != null) {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> screen!));
                  }
                }),

              ],
            ),
          ),
        )
    );
  }
}
