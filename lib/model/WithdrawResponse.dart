class WithdrawResponse {
  WithdrawResponse({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late WithdrawResponseData data;
  late String message;
  late List<String> errorList;
  factory WithdrawResponse.fromJson(Map<String, dynamic> json) =>
      WithdrawResponse(
        data: json["Data"] == null
            ? WithdrawResponseData()
            : WithdrawResponseData.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class WithdrawResponseData {
  var TotalCapital;
  bool? IsWithdrawEnable;
  String? WidthdrawRequestDate;
  String? WidthdrawRequestStatus;
  num? WithdrawRequestAmount;
  WithdrawResponseData(
      {this.TotalCapital,
      this.IsWithdrawEnable,
      this.WidthdrawRequestDate,
      this.WidthdrawRequestStatus,
      this.WithdrawRequestAmount});

  WithdrawResponseData.fromJson(Map<String, dynamic> json) {
    TotalCapital = json['TotalCapital'];
    IsWithdrawEnable = json['IsWithdrawEnable'] ?? "";
    WidthdrawRequestDate = json['WidthdrawRequestDate'] ?? "";
    WidthdrawRequestStatus = json['WidthdrawRequestStatus'] ?? "";
    WithdrawRequestAmount = json['WithdrawRequestAmount'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalCapital'] = this.TotalCapital;
    data['IsWithdrawEnable'] = this.IsWithdrawEnable;
    data['WidthdrawRequestDate'] = this.WidthdrawRequestDate;
    data['WidthdrawRequestStatus'] = this.WidthdrawRequestStatus;
    data['WithdrawRequestAmount'] = this.WithdrawRequestAmount;
    return data;
  }
}
