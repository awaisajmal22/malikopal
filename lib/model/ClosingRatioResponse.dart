class ClosingRatioResponse {
  ClosingRatioResponse({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late ClosingRatioResponseData data;
  late String message;
  late List<String> errorList;
  factory ClosingRatioResponse.fromJson(Map<String, dynamic> json) =>
      ClosingRatioResponse(
        data: json["Data"] == null
            ? ClosingRatioResponseData()
            : ClosingRatioResponseData.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class ClosingRatioResponseData {
  num? closingRatio;
  String? closingRatioText;

  ClosingRatioResponseData({this.closingRatio, this.closingRatioText});

  ClosingRatioResponseData.fromJson(Map<String, dynamic> json) {
    closingRatio = json['ClosingRatio'];
    closingRatioText = json['ClosingRatioText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClosingRatio'] = this.closingRatio;
    data['ClosingRatioText'] = this.closingRatioText;
    return data;
  }
}
