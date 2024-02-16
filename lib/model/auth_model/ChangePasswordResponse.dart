import 'package:malikopal/model/requestbody/ChangePasswordReqBody.dart';

class ChangePasswordResponse {
  ChangePasswordResponse({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late ChangePasswordReqData data;
  late String message;
  late List<String> errorList;
  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
        data: json["Data"] == null
            ? ChangePasswordReqData(
                ConfirmPassword: '', NewPassword: '', OldPassword: '')
            : ChangePasswordReqData.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}
