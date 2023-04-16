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

  TextEditingController propertyTypeNameController = TextEditingController();

  String? selectedPropertyId;
  String? selectedPropertyTypeId = "";
  String? selectedPropertyBookingId = "";
  String? currentUserId = "";

  List<PropertyModel> propertyList = [];
  List<PropertyTypeModel> propertyTypeList = [];
  List<PropertyBookingModel> propertyBookingList = [];

  void fillPropertyDetailsPage(PropertyModel propertyList) {
    addressController.text = propertyList.address;
    spaceController.text = propertyList.space as String;
    costController.text = propertyList.cost as String;
    roomCountController.text = propertyList.roomCount as String;
    withFurniture = propertyList.withFurniture;
    propertyPostApproval = propertyList.propertyPostApproval;
    propertyStateEnum = propertyList.propertyState;
    emit(AppRefreshUIState());
  }

  void clearPropertyDetailsPage() {
    addressController.text = "";
    spaceController.text = "";
    costController.text = "";
    roomCountController.text = "";
    withFurniture = false;
    propertyPostApproval = false;
    propertyStateEnum = PropertyStateEnum.rental;

    emit(AppRefreshUIState());
  }

  Future<void> saveProperty() async {
    if (selectedPropertyId == null) {
      await postProperty();
    } else {
      await updateProperty();
    }
  }

  void fillPropertyTypeDetailsPage(PropertyTypeModel propertyTypeList) {
    selectedPropertyTypeId = propertyTypeList.objectId;
    propertyTypeNameController.text = propertyTypeList.propertyTypeName;

    emit(AppRefreshUIState());
  }

  void clearPropertyTypeDetailsPage() {
    selectedPropertyTypeId = "";
    propertyTypeNameController.text = "";

    emit(AppRefreshUIState());
  }

  Future<void> savePropertyType() async {
    if (selectedPropertyTypeId == 'newTypeId') {
      await postPropertyType();
    } else {
      await updatePropertyType();
    }
  }

  Future<void> savePropertyBooking() async {
    if (selectedPropertyBookingId == null) {
      await postPropertyBooking();
    } else {
      await updatePropertyBooking();
    }
  }

  void propretyStateChangedEvent(PropertyStateEnum newState) {

      propertyStateEnum = newState;
   
    emit(AppRefreshUIState());
  }

  String? changePropertyTypeIdToNameEvent(String id) {
    PropertyTypeModel temp =
        propertyTypeList.firstWhere((element) => element.objectId == id);
    return temp.propertyTypeName;

    // propertyTypeList.firstWhere(
    //   (element) {
    //     return element.objectId == propertyList[index].propertyTypeId;
    //   },
    // ).firstOrNull;
  }

  String? changePropertyTypeNameToIdEvent(String name) {
    PropertyTypeModel temp = propertyTypeList
        .firstWhere((element) => element.propertyTypeName == name);
    return temp.objectId;

    // propertyTypeList.firstWhere(
    //   (element) {
    //     return element.objectId == propertyList[index].propertyTypeId;
    //   },
    // ).firstOrNull;
  }

  void addBookedPropertyIdEvent(int index) {
    propertyBookingList.where(
      (element) {
        return element.bookedPropertyId == propertyList[index].objectId;
      },
    ).firstOrNull;
  }

/////////////////////////////////////API Functions{GET, POST, PUT, DELETE}////////////////////////////////////////////////////////////////////////
/////////////////////////////////////for PropertyModel////////////////////////////////////////////////////////////////////////
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
          objectId: "",
          address: addressController.text.trim(),
          roomCount: int.parse(roomCountController.text.trim()),
          space: int.parse(spaceController.text.trim()),
          withFurniture: withFurniture,
          cost: int.parse(costController.text.trim()),
          propertyState: propertyStateEnum,
          propertyTypeId: selectedPropertyTypeId ?? "", //propertyTypeId
          posterUserId:
              "rOIkuoPLN2", //posterUserID for this is going to be the admin
          propertyPostApproval: propertyPostApproval,
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
          objectId: selectedPropertyId ?? "",
          address: addressController.text.trim(),
          roomCount: int.parse(roomCountController.text.trim()),
          space: int.parse(spaceController.text.trim()),
          withFurniture: withFurniture,
          cost: int.parse(costController.text.trim()),
          propertyState: propertyStateEnum,
          propertyTypeId: selectedPropertyTypeId ?? "", //propertyTypeId
          posterUserId:
              "rOIkuoPLN2", //posterUserID for this is going to be the admin
          propertyPostApproval: propertyPostApproval,
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
/////////////////////////////////////for PropertyTypeModel////////////////////////////////////////////////////////////////////////

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
          propertyTypeNameController.text.trim(),
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
          selectedPropertyTypeId ?? "",
          propertyTypeNameController.text.trim(),
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

/////////////////////////////////////for PropertyBookingModel////////////////////////////////////////////////////////////////////////

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
