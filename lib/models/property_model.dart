import 'package:property_in_homs/utils/enums/property_state_enum.dart';
import 'package:property_in_homs/utils/enums/property_types_enum.dart';

class Property {
  Property(
      this.objectId,
      this.address,
      this.roomCount,
      this.space,
      this.withFurniture,
      this.cost,
      this.propertyState,
      this.propertyType,
      this.posterUserId,
      this.propertyPostApproval);

  String objectId;
  String address;
  int roomCount;
  int space;
  bool withFurniture;
  int cost;
  PropertyStateEnum propertyState;
  PropertyTypesEnum propertyType;
  String posterUserId;
  bool propertyPostApproval;

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "address": address,
        "roomCount": roomCount,
        "space": space,
        "withFurniture": withFurniture,
        "cost": cost,
        "propertyTypeId": propertyType,
        "propertyState": propertyState,
        "posterUserId": posterUserId,
        "propertyPostApproval": propertyPostApproval,
      };

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        json["objectId"] as String,
        json["address"] as String,
        json["roomCount"] as int,
        json["space"] as int,
        json["withFurniture"] as bool,
        json["cost"] as int,
        json["propertyState"] as PropertyStateEnum,
        json["propertyType"] as PropertyTypesEnum,
        json["posterUserId"] as String,
        json["propertyPostApproval"] as bool,
      );
}
