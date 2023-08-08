import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/features/main_feature/views/util/services.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndex = 0;

  onNavigationBarTap(int index){
    emit(HomePageChanged());
    currentIndex = index;
    emit(HomeInitial());

  }

  onMenuTap(){
    scaffoldKey.currentState!.openDrawer();
  }

  List<Service> services = [
    Service(serviceName: LocaleKeys.bill_of_sale.tr(), image: AppImages.billOfSale),
    Service(serviceName: LocaleKeys.receipt.tr(), image: AppImages.receipt),
    Service(serviceName: LocaleKeys.sale_return.tr(), image: AppImages.saleReturn),
    Service(serviceName: LocaleKeys.purchase_return.tr(), image: AppImages.purchaseReturn),
    Service(serviceName: LocaleKeys.stock_order.tr(), image: AppImages.stockOrder),
    Service(serviceName: LocaleKeys.stock_transfer.tr(), image: AppImages.stockTransfer),
    Service(serviceName: LocaleKeys.receive_stock.tr(), image: AppImages.receiveStock),
    Service(serviceName: LocaleKeys.middleman_shipment.tr(), image: AppImages.middlemanShipment),
    Service(serviceName: LocaleKeys.modify_middleman_shipment.tr(), image: AppImages.modifyMiddlemanShipment),
    Service(serviceName: LocaleKeys.customers.tr(), image: AppImages.customers),
    Service(serviceName: LocaleKeys.suppliers.tr(), image: AppImages.suppliers),
    Service(serviceName: LocaleKeys.categories.tr(), image: AppImages.customers),
    Service(serviceName: LocaleKeys.classification.tr(), image: AppImages.classification),
    Service(serviceName: LocaleKeys.bond.tr(), image: AppImages.bond),

  ];


}
