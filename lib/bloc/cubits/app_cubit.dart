import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/models/property_booking_model.dart';
import 'package:property_in_homs/models/property_model.dart';
import 'package:property_in_homs/models/property_type_model.dart';
import 'package:property_in_homs/utils/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  String? selectedId;

  List<PropertyModel> propertyList = [];
  List<PropertyTypeModel> propertyTypeList = [];
  List<PropertyBookingModel> propertyBookingList = [];

  Future<void> getProperty() async {
    try {
      DioHelper.initialize();
      var res = await DioHelper.dio!.get("classes/Property");
      if (res.statusCode == 200) {
        propertyList.clear();
        for (var element in res.data["results"]) {
          propertyList.add(PropertyModel.fromJson(element));
        }
        print(propertyList);
        emit(AppSuccessState());
      } else {
        emit(AppErrorState("Error Code ${res.statusCode}"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> getPropertyTypes() async {
    try {
      DioHelper.initialize();
      var res = await DioHelper.dio!.get("classes/PropertyTypes");
      if (res.statusCode == 200) {
        propertyTypeList.clear();
        for (var element in res.data["results"]) {
          propertyTypeList.add(PropertyTypeModel.fromJson(element));
        }
        print(propertyTypeList);
        emit(AppSuccessState());
      } else {
        emit(AppErrorState("Error Code ${res.statusCode}"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> getPropertyBooking() async {
    try {
      DioHelper.initialize();
      var res = await DioHelper.dio!.get("classes/PropertyBooking");
      if (res.statusCode == 200) {
        propertyBookingList.clear();
        for (var element in res.data["results"]) {
          propertyBookingList.add(PropertyBookingModel.fromJson(element));
        }
        print(propertyBookingList);
        emit(AppSuccessState());
      } else {
        emit(AppErrorState("Error Code ${res.statusCode}"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }
}
