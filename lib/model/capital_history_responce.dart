// To parse this JSON data, do
//
//     final capitalHistoryResponse = capitalHistoryResponseFromJson(jsonString);

import 'dart:convert';

CapitalHistoryResponse capitalHistoryResponseFromJson(String str) =>
    CapitalHistoryResponse.fromJson(json.decode(str));

String capitalHistoryResponseToJson(CapitalHistoryResponse data) =>
    json.encode(data.toJson());

class CapitalHistoryResponse {
  CapitalHistoryResponse({
    this.data,
    this.message,
    this.errorList,
  });

  CapitalHistoryResponseData? data;
  dynamic message;
  List<dynamic>? errorList;

  factory CapitalHistoryResponse.fromJson(Map<String, dynamic> json) =>
      CapitalHistoryResponse(
        data: json["Data"] == null
            ? null
            : CapitalHistoryResponseData.fromJson(json["Data"]),
        message: json["Message"],
        errorList: json["ErrorList"] == null
            ? null
            : List<dynamic>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data == null ? null : data?.toJson(),
        "Message": message,
        "ErrorList": errorList == null
            ? null
            : List<dynamic>.from(errorList!.map((x) => x)),
      };
}

class CapitalHistoryResponseData {
  CapitalHistoryResponseData({
    this.history,
    this.capitalAmount,
  });

  List<History>? history;
  num? capitalAmount;

  factory CapitalHistoryResponseData.fromJson(Map<String, dynamic> json) =>
      CapitalHistoryResponseData(
        history: json["History"] == null
            ? null
            : List<History>.from(
                json["History"].map((x) => History.fromJson(x))),
        capitalAmount:
            json["CapitalAmount"] == null ? null : json["CapitalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "History": history == null
            ? null
            : List<dynamic>.from(history!.map((x) => x.toJson())),
        "CapitalAmount": capitalAmount == null ? null : capitalAmount,
      };
}

class History {
  History({
    this.totalCapitalAmount,
    this.id,
    this.date,
    this.dateStr,
    this.type,
    this.closingMonth,
    this.desc,
    this.debit,
    this.credit,
    this.balance,
    this.fnFDetails,
  });

  num? totalCapitalAmount;
  num? id;
  DateTime? date;
  String? dateStr;
  String? type;
  String? closingMonth;
  String? desc;
  num? debit;
  num? credit;
  num? balance;
  dynamic fnFDetails;

  factory History.fromJson(Map<String, dynamic> json) => History(
        totalCapitalAmount: json["TotalCapitalAmount"] == null
            ? null
            : json["TotalCapitalAmount"],
        id: json["ID"] == null ? null : json["ID"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        dateStr: json["DateStr"] == null ? null : json["DateStr"],
        type: json["Type"] == null ? null : json["Type"],
        closingMonth:
            json["ClosingMonth"] == null ? null : json["ClosingMonth"],
        desc: json["Desc"] == null ? null : json["Desc"],
        debit: json["Debit"] == null ? null : json["Debit"],
        credit: json["Credit"] == null ? null : json["Credit"],
        balance: json["Balance"] == null ? null : json["Balance"],
        fnFDetails: json["FnFDetails"] != null
            ? FnfDetailsData.fromJson(json["FnFDetails"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "TotalCapitalAmount":
            totalCapitalAmount == null ? null : totalCapitalAmount,
        "ID": id == null ? null : id,
        "Date": date == null ? null : date?.toIso8601String(),
        "DateStr": dateStr == null ? null : dateStr,
        "Type": type == null ? null : type,
        "ClosingMonth": closingMonth == null ? null : closingMonth,
        "Desc": desc == null ? null : desc,
        "Debit": debit == null ? null : debit,
        "Credit": credit == null ? null : credit,
        "Balance": balance == null ? null : balance,
        "FnFDetails": fnFDetails,
      };
}

class FnfDetailsData {
  String? fullName;
  String? userID;
  String? type;
  String? date;
  num? amount;

  FnfDetailsData(
      {this.fullName, this.userID, this.type, this.date, this.amount});

  FnfDetailsData.fromJson(Map<String, dynamic> json) {
    fullName = json['FullName'];
    userID = json['UserID'];
    type = json['Type'];
    date = json['Date'];
    amount = json['Amount']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FullName'] = this.fullName;
    data['UserID'] = this.userID;
    data['Type'] = this.type;
    data['Date'] = this.date;
    data['Amount'] = this.amount;
    return data;
  }
}
