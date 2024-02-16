class ReceivedAmountReqBody {
  ReceivedAmountReqBody({
    this.data,
  });

  final ReceivedAmountReqData? data;

  factory ReceivedAmountReqBody.fromJson(Map<String, dynamic> json) =>
      ReceivedAmountReqBody(
        data: ReceivedAmountReqData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

/*
"SinceDateStr": "01-01-2021",
    "Filter": "Y",
    "DateStr": ""
     */

class ReceivedAmountReqData {
  ReceivedAmountReqData(
      {this.SinceDateStr, this.Filter, this.DateStr, this.profileId});

  var SinceDateStr;
  var Filter;
  var DateStr;
  num? profileId;
  factory ReceivedAmountReqData.fromJson(Map<String, dynamic> json) =>
      ReceivedAmountReqData(
          SinceDateStr: json["SinceDateStr"],
          Filter: json["Filter"],
          DateStr: json["DateStr"],
          profileId: json["profileId"]);

  Map<String, dynamic> toJson() => {
        "SinceDateStr": SinceDateStr,
        "Filter": Filter,
        "DateStr": DateStr,
        'profileId': profileId
      };
}
