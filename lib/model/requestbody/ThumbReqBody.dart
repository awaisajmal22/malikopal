class ThumbReqBody {
  ThumbReqBody({
    this.data,
  });

  final ThumbReqData? data;

  factory ThumbReqBody.fromJson(Map<String, dynamic> json) => ThumbReqBody(
        data: ThumbReqData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class ThumbReqData {
  ThumbReqData({this.Activate, this.DeviceId, this.LoginMethod});

  var Activate;
  var DeviceId;
  var LoginMethod;
  factory ThumbReqData.fromJson(Map<String, dynamic> json) => ThumbReqData(
      Activate: json["Activate"],
      DeviceId: json["DeviceId"],
      LoginMethod: json["LoginMethod"]);

  Map<String, dynamic> toJson() =>
      {"Activate": Activate, "DeviceId": DeviceId, "LoginMethod": LoginMethod};
}
