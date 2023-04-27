class PropertyTypeModel {
  PropertyTypeModel({
    required this.objectId,
    required this.propertyTypeName,
  });

  String objectId;
  String propertyTypeName;

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "propertyTypeName": propertyTypeName,
      };

  factory PropertyTypeModel.fromJson(Map<String, dynamic> json) =>
      PropertyTypeModel(
        objectId: json["objectId"] as String,
        propertyTypeName: json["propertyTypeName"] as String,
      );
}
