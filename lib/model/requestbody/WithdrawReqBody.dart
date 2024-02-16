class WithdrawReqBody {
  WithdrawReqBody({
    this.data,
  });

  final WithdrawReqData? data;

  factory WithdrawReqBody.fromJson(Map<String, dynamic> json) =>
      WithdrawReqBody(
        data: WithdrawReqData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class WithdrawReqData {
  num? withdrawAmount;
  String? source;

  WithdrawReqData({this.withdrawAmount, this.source});

  WithdrawReqData.fromJson(Map<String, dynamic> json) {
    withdrawAmount = json['WithdrawAmount'];
    source = json['Source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WithdrawAmount'] = this.withdrawAmount;
    data['Source'] = this.source;
    return data;
  }
}
