class PropertyBookingModel {
  PropertyBookingModel({
    required this.objectId,
    required this.userId,
    required this.bookedPropertyId,
  });

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
        objectId: json["objectId"] as String,
        userId: json["userId"] as String,
        bookedPropertyId: json["bookedPropertyId"] as String,
      );
}
