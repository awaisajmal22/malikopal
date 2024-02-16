class ReceivePaymentReqBody {
  ReceivePaymentReqBody({
    this.data,
  });

  final ReceivePaymentReqData? data;

  factory ReceivePaymentReqBody.fromJson(Map<String, dynamic> json) =>
      ReceivePaymentReqBody(
        data: ReceivePaymentReqData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class ReceivePaymentReqData {
  num? transferAmount;
  num? rolloverAmount;
  String? source;

  ReceivePaymentReqData(
      {this.transferAmount, this.rolloverAmount, this.source});

  ReceivePaymentReqData.fromJson(Map<String, dynamic> json) {
    transferAmount = json['TransferAmount'];
    rolloverAmount = json['RolloverAmount'];
    source = json['Source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TransferAmount'] = this.transferAmount;
    data['RolloverAmount'] = this.rolloverAmount;
    data['Source'] = this.source;
    return data;
  }
}
