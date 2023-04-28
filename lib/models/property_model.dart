import 'package:property_in_homs/utils/enums/property_approval_enum.dart';
import 'package:property_in_homs/utils/enums/property_state_enum.dart';

class PropertyModel {
  PropertyModel({
    required this.objectId,
    required this.address,
    required this.roomCount,
    required this.space,
    required this.withFurniture,
    required this.cost,
    required this.propertyState,
    this.propertyTypeId = "",
    required this.posterUserId,
    required this.propertyPostApproval,
    this.propertyName,
  });

  String objectId;
  String address;
  int roomCount;
  int space;
  bool withFurniture;
  int cost;
  PropertyStateEnum propertyState;
  String propertyTypeId;
  String posterUserId;
  String? propertyName;
  PropertyApprovalEnum propertyPostApproval;

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "address": address,
        "roomCount": roomCount,
        "space": space,
        "withFurniture": withFurniture,
        "cost": cost,
        "propertyState": propertyState.index,
        "propertyTypeId": propertyTypeId,
        "posterUserId": posterUserId,
        "propertyPostApproval": propertyPostApproval.index,
      };

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        objectId: json["objectId"] as String,
        address: json["address"] as String,
        roomCount: json["roomCount"] as int,
        space: json["space"] as int,
        withFurniture: json["withFurniture"] as bool,
        cost: json["cost"] as int,
        propertyState: PropertyStateEnum.values[json["propertyState"] as int],
        propertyTypeId: json["propertyTypeId"] as String,
        posterUserId: json["posterUserId"] as String,
        propertyPostApproval:
            PropertyApprovalEnum.values[json["propertyPostApproval"] as int],
      );
}
