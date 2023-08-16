import 'package:eng_shop/core/views/widgets/custom_drawer.dart';
import 'package:eng_shop/features/main_feature/views/bloc/home/home_cubit.dart';
import 'package:eng_shop/features/main_feature/views/components/home/custom_side_menu.dart';
import 'package:eng_shop/features/auth/domain/util/user_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/home/custom_navigation_bar.dart';



class HomeScreen extends StatelessWidget {
  UserType userType;

  HomeScreen({super.key, required this.userType });


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
                key: context.read<HomeCubit>().scaffoldKey,
                drawer: CustomDrawer(
                  child: const CustomSideMenu(),
                ),
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [


                    AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: context.read<HomeCubit>().getCurrentPage(userType),
                    ),

                    CustomNavigationBar(
                      currentIndex: context.read<HomeCubit>().currentIndex ,
                      onTap: (index)=> context.read<HomeCubit>().onNavigationBarTap(index),
                    ),

                  ],
                ) ,
          );
        },
      )
    );
  }
}
