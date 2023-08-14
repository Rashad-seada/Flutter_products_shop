import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../components/home/product_item.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [

                Space(height: 2.h,),

                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (_, index) {
                      return ProductItem();
                    },
                  separatorBuilder: (BuildContext context, int index) {
                      return Space(height: 2.h,);
                  },
                ),

                Space(height: 2.h,),

              ],
            ),
          ),
        ),
      ),
    ));
  }
}
