import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/models/property_booking_model.dart';
import 'package:property_in_homs/models/property_model.dart';
import 'package:property_in_homs/models/property_type_model.dart';
import 'package:property_in_homs/utils/dio_helper.dart';

import '../../utils/enums/property_state_enum.dart';
import '../../utils/enums/property_types_enum.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  TextEditingController addressController = TextEditingController();
  TextEditingController spaceController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController roomCountController = TextEditingController();
  bool withFurniture = false;
  PropertyStateEnum propertyStateEnum = PropertyStateEnum.rental;
  bool propertyPostApproval = false;
  String? selectedId;

  List<PropertyModel> propertyList = [];
  List<PropertyTypeModel> propertyTypeList = [];
  List<PropertyBookingModel> propertyBookingList = [];

  void fillPage(PropertyModel propertyList) {
    addressController.text = propertyList.address;
    spaceController.text = propertyList.space as String;
    costController.text = propertyList.cost as String;
    roomCountController.text = propertyList.roomCount as String;
    withFurniture = propertyList.withFurniture;
    propertyPostApproval = propertyList.propertyPostApproval;
    propertyStateEnum = propertyList.propertyState;
    emit(AppRefreshUIState());
  }

  void clearPage() {
    addressController.text = "";
    spaceController.text = "";
    costController.text = "";
    roomCountController.text = "";
    withFurniture = false;
    propertyPostApproval = PropertyStateEnum.rental as bool;
    propertyStateEnum = PropertyTypesEnum.house as PropertyStateEnum;
    emit(AppRefreshUIState());
  }

  void save() {
    if (selectedId == null) {}
  }

  // void propretyTypeChangedEvent(PropertyTypesEnum newType) {
  //   propertyTypesEnum
  // }
 
  void propretyStateChangedEvent(PropertyStateEnum newState) {
    propertyStateEnum = newState;
    emit(AppRefreshUIState());
    
  }

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
