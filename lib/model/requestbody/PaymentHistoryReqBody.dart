class PaymentHistoryReqBody {
  PaymentHistoryReqBody({
    this.data,
  });

  final PaymentHistoryReqData? data;

  factory PaymentHistoryReqBody.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryReqBody(
        data: PaymentHistoryReqData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class PaymentHistoryReqData {
  String? Month;
  String? Year;
  num? Pno;
  num? profileId;

  PaymentHistoryReqData({this.Month, this.Year, this.Pno, this.profileId});

  PaymentHistoryReqData.fromJson(Map<String, dynamic> json) {
    Month = json['Month'];
    Year = json['Year'];
    Pno = json['Pno'];
    profileId = json['profileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Month'] = this.Month;
    data['Year'] = this.Year;
    data['Pno'] = this.Pno;
    data['profileId'] = this.profileId;
    return data;
  }
}
