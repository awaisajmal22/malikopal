import 'package:malikopal/model/auth_model/LoginData.dart';

class UserLoginResponse {
  UserLoginResponse({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late UserLoginData data;
  late String message;
  late List<String> errorList;
  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      UserLoginResponse(
        data: json["Data"] == null
            ? UserLoginData(token: '')
            : UserLoginData.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}
