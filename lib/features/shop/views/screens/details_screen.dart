import 'package:cached_network_image/cached_network_image.dart';
import 'package:eng_shop/core/views/widgets/custom_back_button.dart';
import 'package:eng_shop/core/views/widgets/custom_shimmer.dart';
import 'package:eng_shop/features/shop/domain/entity/product_entity.dart';
import 'package:eng_shop/features/shop/views/bloc/home_customer/home_customer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../categories/views/bloc/category_product/category_product_cubit.dart';

class DetailsScreen extends StatefulWidget {
  int productId;
  DetailsScreen({super.key,required this.productId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

 

  @override
  void initState() {
    context.read<HomeCustomerCubit>().getProductById(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<HomeCustomerCubit,HomeCustomerState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: 100.w,
            child: ListView(
              shrinkWrap: true,
              children: [


                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      CustomBackButton(),

                      Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(100.w),
                            onTap: () => context.read<CategoryProductCubit>().onSearchTap(context),
                            child: SvgPicture.asset(AppImages.search,width: 26,height:26,),
                          ),
                          Space(width: 4.w,),

                          InkWell(
                            borderRadius: BorderRadius.circular(100.w),
                            onTap: () => context.read<CategoryProductCubit>().onCartTap(context),
                            child: SvgPicture.asset(AppImages.cart,width: 26,height:26,),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: FutureBuilder(
                      future: context.read<HomeCustomerCubit>().getImage(widget.productId),
                      builder:
                          (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: 100.w,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.w)),
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data!,
                              placeholder: (context, url) => CustomShimmer(child: Container(color: Colors.white,)),
                              errorWidget: (context, url, error) => CustomShimmer(child: Container(color: Colors.white,)),
                              fit: BoxFit.cover,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return CustomShimmer(child: Container(color: Colors.white,));
                        } else {
                          return CustomShimmer(child: Container(color: Colors.white,));
                        }

                          }),
                ),


              ],
            ),
          ),
        );
      },
    ));
  }
}
