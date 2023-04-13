import 'package:property_in_homs/utils/enums/property_state_enum.dart';

class PropertyModel {
  PropertyModel(
      this.objectId,
      this.address,
      this.roomCount,
      this.space,
      this.withFurniture,
      this.cost,
      this.propertyState,
      this.propertyTypeId,
      this.posterUserId,
      this.propertyPostApproval);

  String objectId;
  String address;
  int roomCount;
  int space;
  bool withFurniture;
  int cost;
  PropertyStateEnum propertyState;
  String propertyTypeId;
  String posterUserId;
  bool propertyPostApproval;

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "address": address,
        "roomCount": roomCount,
        "space": space,
        "withFurniture": withFurniture,
        "cost": cost,
        "propertyState": propertyState,
        "propertyTypeId": propertyTypeId,
        "posterUserId": posterUserId,
        "propertyPostApproval": propertyPostApproval,
      };

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        json["objectId"] as String,
        json["address"] as String,
        json["roomCount"] as int,
        json["space"] as int,
        json["withFurniture"] as bool,
        json["cost"] as int,
        PropertyStateEnum.values[json["propertyState"] as int],
        json["propertyTypeId"] as String,
        json["posterUserId"] as String,
        json["propertyPostApproval"] as bool,
      );
}
