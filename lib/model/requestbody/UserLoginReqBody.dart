import 'package:malikopal/model/auth_model/LoginData.dart';

class UserLoginReqBody {
  UserLoginReqBody({
    this.data,
  });

  final LoginFormData? data;

  factory UserLoginReqBody.fromJson(Map<String, dynamic> json) =>
      UserLoginReqBody(
        data: LoginFormData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}
