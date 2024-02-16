class ChangePasswordReqBody {
  ChangePasswordReqBody({
    this.data,
  });

  final ChangePasswordReqData? data;

  factory ChangePasswordReqBody.fromJson(Map<String, dynamic> json) =>
      ChangePasswordReqBody(
        data: ChangePasswordReqData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class ChangePasswordReqData {
  String OldPassword = "";
  String NewPassword = "";
  String ConfirmPassword = "";
  ChangePasswordReqData(
      {required this.OldPassword,
      required this.NewPassword,
      required this.ConfirmPassword});

  ChangePasswordReqData.fromJson(Map<String, dynamic> json) {
    OldPassword = json['OldPassword'] ?? "";
    NewPassword = json['NewPassword'] ?? "";
    ConfirmPassword = json['ConfirmPassword'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OldPassword'] = this.OldPassword;
    data['NewPassword'] = this.NewPassword;
    data['ConfirmPassword'] = this.ConfirmPassword;
    return data;
  }
}
