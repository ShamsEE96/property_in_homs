import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/models/property_booking_model.dart';
import 'package:property_in_homs/models/property_model.dart';
import 'package:property_in_homs/models/property_type_model.dart';
import 'package:property_in_homs/utils/dio_helper.dart';
import 'package:collection/collection.dart';
import 'package:property_in_homs/utils/enums/property_state_enum.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  TextEditingController addressController = TextEditingController();
  TextEditingController roomCountController = TextEditingController();
  TextEditingController spaceController = TextEditingController();
  bool withFurniture = false;
  TextEditingController costController = TextEditingController();
  PropertyStateEnum propertyStateEnum = PropertyStateEnum.rental;
  PropertyStateEnum typeStateEnum = PropertyStateEnum.rental;

  bool propertyPostApproval = false;

  TextEditingController propertyTypeController = TextEditingController();

  String? selectedPropertyId;
  String selectedPropertyTypeId = "";
  String? selectedPropertyBookingId = "";

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
    propertyPostApproval = false;
    propertyStateEnum = PropertyStateEnum.rental;

    emit(AppRefreshUIState());
  }

  void save() {
    if (selectedPropertyId == null) {}
  }

  void propretyStateChangedEvent(PropertyStateEnum newState) {

      propertyStateEnum = newState;
   
    emit(AppRefreshUIState());
  }

  void addPropertyTypeIdEvent(int index) {
    propertyTypeList.where(
      (element) {
        return element.objectId == propertyList[index].propertyTypeId;
      },
    ).firstOrNull;
  }

  void addBookedPropertyIdEvent(int index) {
    propertyBookingList.where(
      (element) {
        return element.bookedPropertyId == propertyList[index].objectId;
      },
    ).firstOrNull;
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
        // print(propertyList);
        emit(AppSuccessState());
      } else {
        emit(AppErrorState("Error Code ${res.statusCode}"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> postProperty() async {
    try {
      DioHelper.initialize();
      var res = await DioHelper.dio!.post(
        "classes/Property",
        data: PropertyModel(
          "",
          addressController.text.trim(),
          int.parse(roomCountController.text.trim()),
          int.parse(spaceController.text.trim()),
          withFurniture,
          int.parse(costController.text.trim()),
          propertyStateEnum,
          selectedPropertyTypeId, //propertyTypeId
          "rOIkuoPLN2", //posterUserID for this is going to be the admin
          propertyPostApproval,
        ).toJson(),
      );
      if (res.statusCode == 201) {
        await getProperty();
        emit(AppSuccessState());
      } else {
        emit(AppErrorState("Error Code ${res.statusCode}"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> updateProperty() async {
    try {
      DioHelper.initialize();
      var res = await DioHelper.dio!.put(
        "classes/Property/$selectedPropertyId",
        data: PropertyModel(
          selectedPropertyId ?? "",
          addressController.text.trim(),
          int.parse(roomCountController.text.trim()),
          int.parse(spaceController.text.trim()),
          withFurniture,
          int.parse(costController.text.trim()),
          propertyStateEnum,
          selectedPropertyTypeId, //propertyTypeId
          "rOIkuoPLN2", //posterUserID for this is going to be the admin
          propertyPostApproval,
        ).toJson(),
      );
      if (res.statusCode == 200) {
        await getProperty();

        emit(AppSuccessState());
      } else {
        emit(AppErrorState("Error Code ${res.statusCode}"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> deleteProperty(String id) async {
    try {
      DioHelper.initialize();

      var res = await DioHelper.dio!.delete(
        "classes/Property/$id".toString(),
      );
      if (res.statusCode == 200) {
        await getProperty();

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
        // print(propertyTypeList);
        emit(AppSuccessState());
      } else {
        emit(AppErrorState("Error Code ${res.statusCode}"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> postPropertyType() async {
    try {
      DioHelper.initialize();
      var res = await DioHelper.dio!.post(
        "classes/PropertyTypes",
        data: PropertyTypeModel(
          "",
          propertyTypeController.text.trim(),
        ).toJson(),
      );
      if (res.statusCode == 201) {
        await getPropertyTypes();
        emit(AppSuccessState());
      } else {
        emit(AppErrorState("Error Code ${res.statusCode}"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> updatePropertyType() async {
    try {
      DioHelper.initialize();
      var res = await DioHelper.dio!.put(
        "classes/PropertyTypes/$selectedPropertyTypeId",
        data: PropertyTypeModel(
          selectedPropertyTypeId,
          propertyTypeController.text.trim(),
        ).toJson(),
      );
      if (res.statusCode == 200) {
        await getPropertyTypes();

        emit(AppSuccessState());
      } else {
        emit(AppErrorState("Error Code ${res.statusCode}"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> deletePropertyType(String id) async {
    try {
      DioHelper.initialize();

      var res = await DioHelper.dio!.delete(
        "classes/PropertyTypes/$id".toString(),
      );
      if (res.statusCode == 200) {
        await getPropertyTypes();

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

  Future<void> postPropertyBooking() async {
    try {
      DioHelper.initialize();
      var res = await DioHelper.dio!.post(
        "classes/PropertyBooking",
        data: PropertyBookingModel(
          "",
          "rOIkuoPLN2",
          "bookedPropertyId",
        ).toJson(),
      );
      if (res.statusCode == 201) {
        await getPropertyBooking();
        emit(AppSuccessState());
      } else {
        emit(AppErrorState("Error Code ${res.statusCode}"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> updatePropertyBooking() async {
    try {
      DioHelper.initialize();
      var res = await DioHelper.dio!.put(
        "classes/PropertyBooking/$selectedPropertyTypeId",
        data: PropertyBookingModel(
          selectedPropertyBookingId ?? "",
          "rOIkuoPLN2",
          "bookedPropertyId",
        ).toJson(),
      );
      if (res.statusCode == 200) {
        await getPropertyBooking();

        emit(AppSuccessState());
      } else {
        emit(AppErrorState("Error Code ${res.statusCode}"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> deletePropertyBooking(String id) async {
    try {
      DioHelper.initialize();

      var res = await DioHelper.dio!.delete(
        "classes/PropertyBooking/$id".toString(),
      );
      if (res.statusCode == 200) {
        await getPropertyBooking();

        emit(AppSuccessState());
      } else {
        emit(AppErrorState("Error Code ${res.statusCode}"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }
}
