import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CategoryItem extends StatefulWidget {
  String label;
  void Function()? onTap;
  bool isSelected;
  CategoryItem({super.key,required this.label,this.onTap,this.isSelected = true});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.onTap != null) {
          widget.onTap!();
        }
        setState(() {

        });
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: (widget.isSelected)? AppTheme.backgroundColor : AppTheme.neutral100,

          ),
        duration: Duration(milliseconds: 200),
        child: Row(
          children: [

            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              width: (widget.isSelected)? 1.w : 0,
              height: (widget.isSelected)? 3.h : 0,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppTheme.neutral500,
              ),
            ),

            Space(width: 2.w,),



            Text(widget.label,style: AppTheme.textMTextStyle(color: ( AppTheme.neutral900),)),
          ],
        ),
      ),
    );
  }
}
