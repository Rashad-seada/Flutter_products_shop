
import 'package:eng_shop/core/views/widgets/custom_drawer.dart';
import 'package:eng_shop/features/auth/domain/util/user_type_enum.dart';
import 'package:eng_shop/features/shop/views/bloc/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/view/bloc/cart/cart_cubit.dart';
import '../components/home/custom_navigation_bar.dart';
import '../components/home/custom_side_menu.dart';



class HomeScreen extends StatelessWidget {
  final BuildContext context;
  UserType userType;

  HomeScreen({super.key, required this.userType ,required this.context}){
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
                key: context.read<HomeCubit>().scaffoldKey ,
                drawer: CustomDrawer(
                  child: const CustomSideMenu(),
                ),
                body: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: context.read<HomeCubit>().getCurrentPage(userType),
                ),
                bottomNavigationBar: CustomNavigationBar(
                  currentIndex: context.read<HomeCubit>().currentIndex ,
                  onTap: (index)=> context.read<HomeCubit>().onNavigationBarTap(index),
                  items: context.read<HomeCubit>().getNavItems(userType),
                ),
              );
        },
      )
    );
  }

}

