class VerifyOtpResponse {
  VerifyOtpResponse({
    required this.data,
    required this.message,
    required this.errorList,
  });

  VerifyOtpResponseData data;
  String message;
  List<String> errorList;
  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponse(
        data: json["Data"] == null
            ? VerifyOtpResponseData(IsSuccess: false)
            : VerifyOtpResponseData.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class VerifyOtpResponseData {
  VerifyOtpResponseData({
    required this.IsSuccess,
  });
  bool IsSuccess;

  factory VerifyOtpResponseData.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponseData(IsSuccess: json["IsSuccess"]);

  Map<String, dynamic> toJson() => {"IsSuccess": IsSuccess};
}
