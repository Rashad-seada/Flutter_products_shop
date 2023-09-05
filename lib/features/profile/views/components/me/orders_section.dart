import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:eng_shop/features/profile/views/components/me/order_item.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../shop/domain/entity/product_entity.dart';
import '../../../domain/entities/get_orders_entity.dart';

class OrderSection extends StatelessWidget {
  List<GetOrderItemsEntity> orders;

  OrderSection({super.key,required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
        itemCount: orders.length,
        shrinkWrap: true,
        itemBuilder: (context,index) {
          return OrderItem(order: orders[index],);
        },
      separatorBuilder: (BuildContext context, int index) {
          return Space(height: 5.w,);
      },
    );
  }
}
