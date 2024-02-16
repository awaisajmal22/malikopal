import 'dart:convert';

WidthDrawStatus widthDrawStatusFromJson(String str) =>
    WidthDrawStatus.fromJson(json.decode(str));

String widthDrawStatusToJson(WidthDrawStatus data) =>
    json.encode(data.toJson());

class WidthDrawStatus {
  WidthDrawStatus({
    this.data,
    this.message,
    this.errorList,
  });

  Data? data;
  dynamic message;
  List<String>? errorList;

  factory WidthDrawStatus.fromJson(Map<String, dynamic> json) =>
      WidthDrawStatus(
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
        message: json["Message"],
        errorList: json["ErrorList"] == null
            ? null
            : List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data == null ? null : data?.toJson(),
        "Message": message,
        "ErrorList": errorList == null
            ? null
            : List<dynamic>.from(errorList!.map((x) => x)),
      };
}

class Data {
  Data({
    this.status,
    this.capitalAmount,
    this.withdrawRequest,
  });

  bool? status;
  num? capitalAmount;
  WithdrawRequest? withdrawRequest;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["Status"] == null ? null : json["Status"],
        capitalAmount:
            json["CapitalAmount"] == null ? null : json["CapitalAmount"],
        withdrawRequest: json["WithdrawRequest"] == null
            ? null
            : WithdrawRequest.fromJson(json["WithdrawRequest"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status == null ? null : status,
        "CapitalAmount": capitalAmount == null ? null : capitalAmount,
        "WithdrawRequest":
            withdrawRequest == null ? null : withdrawRequest?.toJson(),
      };
}

class WithdrawRequest {
  WithdrawRequest({
    this.withdrawAmount,
    this.requestDate,
    this.status,
  });

  num? withdrawAmount;
  DateTime? requestDate;
  String? status;

  factory WithdrawRequest.fromJson(Map<String, dynamic> json) =>
      WithdrawRequest(
        withdrawAmount:
            json["WithdrawAmount"] == null ? null : json["WithdrawAmount"],
        requestDate: json["RequestDate"] == null
            ? null
            : DateTime.parse(json["RequestDate"]),
        status: json["Status"] == null ? null : json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "WithdrawAmount": withdrawAmount == null ? null : withdrawAmount,
        "RequestDate":
            requestDate == null ? null : requestDate?.toIso8601String(),
        "Status": status == null ? null : status,
      };
}
