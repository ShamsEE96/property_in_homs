import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/utils/dio_helper.dart';
import 'package:property_in_homs/models/property_booking_model.dart';
import 'package:property_in_homs/models/property_model.dart';
import 'package:property_in_homs/models/property_type_model.dart';
import 'package:property_in_homs/pages/admin_home_page.dart';
import 'package:property_in_homs/pages/property_booked_page.dart';
import 'package:property_in_homs/pages/property_edit_page.dart';
import 'package:collection/collection.dart';
import 'package:property_in_homs/utils/enums/property_state_enum.dart';
import 'package:property_in_homs/widgets/propertys.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  TextEditingController addressController = TextEditingController();
  TextEditingController roomCountController = TextEditingController();
  TextEditingController spaceController = TextEditingController();
  bool withFurniture = false;
  TextEditingController costController = TextEditingController();
  PropertyStateEnum propertyStateEnum = PropertyStateEnum.rental;

  bool propertyPostApproval = false;

  TextEditingController propertyTypeNameController = TextEditingController();

  String? selectedPropertyId = "";
  String? selectedPropertyTypeId = "";
  String? selectedPropertyBookingId = "";
  String? currentUserId = "rOIkuoPLN2";
  late PropertyModel currentPropertyItem;
  late List<bool> selections = List.generate(2, (_) => false);

  List<PropertyModel> propertyList = [];
  List<PropertyTypeModel> propertyTypeList = [];
  List<PropertyBookingModel> propertyBookingList = [];
  // List<PropertyModel> readyPropertyList = [];
  List<PropertyBookingModel> currentUserPropertyBookingList = [];

  void fillPropertyDetailsPage(PropertyModel propertyList) {
    selectedPropertyId = propertyList.objectId;
    addressController.text = propertyList.address;
    spaceController.text = propertyList.space.toString();
    costController.text = propertyList.cost.toString();
    roomCountController.text = propertyList.roomCount.toString();
    withFurniture = propertyList.withFurniture;
    propertyPostApproval = propertyList.propertyPostApproval;
    propertyStateEnum = propertyList.propertyState;
    emit(AppRefreshUIState());
  }

  void clearPropertyDetailsPage() {
    selectedPropertyId = "";
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
    if (selectedPropertyId == '') {
      await postProperty();
    } else {
      await updateProperty();
    }
  }

  void propertyTypeChangedEvent(String? objectId) {
    selectedPropertyTypeId = objectId;
    emit(
      AppRefreshUIState(),
    );
  }

  void fillPropertyTypeDetailsPage(PropertyTypeModel propertyTypeList) {
    selectedPropertyTypeId = propertyTypeList.objectId;
    propertyTypeNameController.text = propertyTypeList.propertyTypeName;

    emit(AppRefreshUIState());
  }

  void withFurnitureChangedEvent(newValue) {
    withFurniture = newValue;
    emit(AppRefreshUIState());
  }

  void clearPropertyTypeDetailsPage() {
    selectedPropertyTypeId = '';
    propertyTypeNameController.text = '';

    emit(AppRefreshUIState());
  }

  Future<void> savePropertyType() async {
    if (selectedPropertyTypeId == '') {
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
    if (propertyStateEnum.index == 1) {
      selections = [true, false];
    }
    if (propertyStateEnum.index == 0) {
      selections = [false, true];
    }
    emit(AppRefreshUIState());
  }

  String? changePropertyTypeIdToNameEvent(String id) {
    PropertyTypeModel temp =
        propertyTypeList.firstWhere((element) => element.objectId == id);
    return temp.propertyTypeName;
  }

  String? changePropertyTypeNameToIdEvent(String name) {
    PropertyTypeModel temp = propertyTypeList
        .firstWhere((element) => element.propertyTypeName == name);
    return temp.objectId;
  }

  findAndCreateCurrentUserBookedPropertyListEvent() {
    currentUserPropertyBookingList = propertyBookingList.where(
      (element) {
        return element.userId == currentUserId;
      },
    ).toList();
    return currentUserPropertyBookingList;
  }

  replacePropertyTypeIdtoNameEvent(PropertyModel item) {
    var type = propertyTypeList.where(
      (element) {
        return element.objectId == currentPropertyItem.propertyTypeId;
      },
    );
    return type;
  }

  navigateFromBookedPropertyListToSelectedPropertyViewPageEvent(int index) {
    var res = currentUserPropertyBookingList.where(
      (element) {
        return element.bookedPropertyId ==
            propertyTypeList[index].propertyTypeName;
      },
    );
  }

  // void addBookedPropertyIdEvent(int index) {
  //   propertyBookingList.where(
  //     (element) {
  //       return element.bookedPropertyId == propertyList[index].objectId;
  //     },
  //   ).firstOrNull;
  // }
/////////////////////////////////////Bottom Navigation Bar////////////////////////////////////////////////////////////////////////

  List bottomNavBarPages = [
    const PropertyListWidget(),
    const PropertyBookedPage(),
    PropertyEditPage(),
    const AdminHomePage(),
  ];
  int navigationBarCurrentIndex = 0;

  void changeBottomNavBar(int index) {
    navigationBarCurrentIndex = index;
    emit(AppRefreshUIState());
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
        print(propertyList);
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
        print(propertyTypeList);
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
          objectId: "",
          propertyTypeName: propertyTypeNameController.text.trim(),
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
          objectId: selectedPropertyTypeId ?? "",
          propertyTypeName: propertyTypeNameController.text.trim(),
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
          objectId: "",
          userId: "rOIkuoPLN2",
          bookedPropertyId: "bookedPropertyId",
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
          objectId: selectedPropertyBookingId ?? "",
          userId: "rOIkuoPLN2",
          bookedPropertyId: "bookedPropertyId",
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
