class UpdateBankReqBody {
  UpdateBankReqBody({
    this.data,
  });

  final UpdateBankReqData? data;

  factory UpdateBankReqBody.fromJson(Map<String, dynamic> json) =>
      UpdateBankReqBody(
        data: UpdateBankReqData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class UpdateBankReqData {
  String? bankName;
  String? accountTitle;
  String? branchCode;
  String? accountNo;
  String? iBAN;
  String? accountRelation;
  String? source;

  UpdateBankReqData({
    this.bankName,
    this.accountTitle,
    this.branchCode,
    this.accountNo,
    this.iBAN,
    this.accountRelation,
    this.source,
  });

  UpdateBankReqData.fromJson(Map<String, dynamic> json) {
    bankName = json['BankName'];
    accountTitle = json['AccountTitle'];
    branchCode = json['BranchCode'];
    accountNo = json['AccountNo'];
    iBAN = json['IBAN'];
    accountRelation = json['AccountRelation'];
    source = json['Source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BankName'] = this.bankName;
    data['AccountTitle'] = this.accountTitle;
    data['BranchCode'] = this.branchCode;
    data['AccountNo'] = this.accountNo;
    data['IBAN'] = this.iBAN;
    data['AccountRelation'] = this.accountRelation;
    data['Source'] = this.source;
    return data;
  }
}
