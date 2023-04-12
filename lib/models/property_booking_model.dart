class PropertyBookingModel {
  PropertyBookingModel(
    this.objectId,
    this.userId,
    this.bookedPropertyId,
  );

  String objectId;
  String userId;
  String bookedPropertyId;

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "userId": userId,
        "bookedPropertyId": bookedPropertyId,
      };

  factory PropertyBookingModel.fromJson(Map<String, dynamic> json) =>
      PropertyBookingModel(
        json["objectId"] as String,
        json["userId"] as String,
        json["bookedPropertyId"] as String,
      );
}
