import 'package:customer_zimkey/constants/initial_object_values.dart';
import 'package:customer_zimkey/data/model/checkout/checkout_summary_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../constants/strings.dart';

class CalculatedServiceCostCubit extends Cubit<ServiceCostCalculated> {
  CalculatedServiceCostCubit() : super(InitialObjectValues.initialServiceCost);
  ServiceCostCalculated cubitState = InitialObjectValues.initialServiceCost;


  void calculateTotalCost({required int unitPrice,required int minPrice,int unit = 0,required int minUnit, required String billingId}) {
    emit(InitialObjectValues.initialServiceCost);
    int totalCost = minPrice+(unitPrice*(cubitState.selectedUnit-minUnit));
    cubitState = cubitState.copyWith(totalCost: totalCost.toString(),selectedBillingId: billingId,selectedUnit:unit !=0?unit:cubitState.selectedUnit);
    emit(cubitState);
  }

  void fetchCurrentData(){
    emit(InitialObjectValues.initialServiceCost);
    emit(cubitState);
  }

  void setTotalCost({required String totalCost} ){
    emit(InitialObjectValues.initialServiceCost);
    cubitState = cubitState.copyWith(totalCost: totalCost);
    emit(cubitState);
  }
  void setCouponList({required List<Coupon> couponList} ){
    emit(InitialObjectValues.initialServiceCost);
    cubitState = cubitState.copyWith(couponList: couponList);
    emit(cubitState);
  }
  void showCouponListingScreen({required bool show} ){
    emit(InitialObjectValues.initialServiceCost);
    cubitState = cubitState.copyWith(showCouponListingScreen: show);
    emit(cubitState);
  }
  void setCurrentUnit({required int unit} ){
    cubitState = cubitState.copyWith(selectedUnit: unit);
  }


  void addCurrentUnit({required int unitPrice,required int minPrice,required String billingId,required int maxUnit,required minUnit}){
    if (cubitState.selectedUnit < maxUnit) {
      cubitState = cubitState.copyWith(selectedUnit:((cubitState.selectedUnit)+1));
      calculateTotalCost(unitPrice: unitPrice, billingId: billingId,minUnit: minUnit,minPrice: minPrice);
    }  else {
      Logger().w("max unit reached");
    }
  }
  void subtractCurrentUnit({required int unitPrice,required int minPrice,required String billingId,required int minUnit}){
    if (minUnit < cubitState.selectedUnit) {
      cubitState = cubitState.copyWith(selectedUnit:(cubitState.selectedUnit)-1);
      calculateTotalCost(unitPrice: unitPrice, billingId: billingId,minUnit: minUnit,minPrice: minPrice);
    } else {
      Logger().w("min unit reached");
    }
  }

  void changeButtonName({required String btnName}) {
    emit(InitialObjectValues.initialServiceCost);
    cubitState = cubitState.copyWith(btnName: btnName);
    emit(cubitState);
  }

  void clearTotalCalculation() {
   cubitState = InitialObjectValues.initialServiceCost;
    emit(cubitState);
  }
}

class ServiceCostCalculated {
  final String totalCost;
  final String btnName;
  final String rewardPoint;
  final String selectedBillingId;
  final int selectedUnit;
  final bool showCouponListingScreen;
  final List<Coupon> couponList;

  const ServiceCostCalculated(
      {required this.totalCost,required this.couponList, required this.btnName, required this.rewardPoint, required this.selectedBillingId,required this.selectedUnit,required this.showCouponListingScreen});

  ServiceCostCalculated copyWith({
     String? totalCost,
     String? btnName,
     String? rewardPoint,
     String? selectedBillingId,
     int? selectedUnit,
    bool? showCouponListingScreen,
    List<Coupon>? couponList
}){
    return ServiceCostCalculated(
        totalCost: totalCost??this.totalCost,
      btnName: btnName??this.btnName,
      rewardPoint: rewardPoint??this.rewardPoint,
      selectedBillingId: selectedBillingId??this.selectedBillingId,
      selectedUnit: selectedUnit??this.selectedUnit,
      showCouponListingScreen: showCouponListingScreen??this.showCouponListingScreen,
      couponList: couponList??this.couponList,
    );
}
}
