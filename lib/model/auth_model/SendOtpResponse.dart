class SendOtpResponse {
  SendOtpResponse({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late SendOtpResponseData data;
  late String message;
  late List<String> errorList;
  factory SendOtpResponse.fromJson(Map<String, dynamic> json) =>
      SendOtpResponse(
        data: json["Data"] == null
            ? SendOtpResponseData(Type: '', EmailPhone: '')
            : SendOtpResponseData.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class SendOtpResponseData {
  SendOtpResponseData({
    this.Type,
    this.EmailPhone,
  });
  String? Type;
  String? EmailPhone;

  factory SendOtpResponseData.fromJson(Map<String, dynamic> json) =>
      SendOtpResponseData(Type: json["Type"], EmailPhone: json["EmailPhone"]);

  Map<String, dynamic> toJson() => {"Type": Type, "EmailPhone": EmailPhone};
}
