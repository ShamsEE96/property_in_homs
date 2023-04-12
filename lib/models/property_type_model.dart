class PropertyTypeModel {
  PropertyTypeModel(
    this.objectId,
    this.propertyTypeName,
  );

  String objectId;
  String propertyTypeName;

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "propertyTypeName": propertyTypeName,
      };

  factory PropertyTypeModel.fromJson(Map<String, dynamic> json) =>
      PropertyTypeModel(
        json["objectId"] as String,
        json["propertyTypeName"] as String,
      );
}
