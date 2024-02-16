import 'package:malikopal/model/auth_model/LoginData.dart';

class SendOtpReqBody {
  SendOtpReqBody({
    this.data,
  });

  final SendOtpData? data;

  factory SendOtpReqBody.fromJson(Map<String, dynamic> json) => SendOtpReqBody(
        data: SendOtpData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class VerifyOtpReqBody {
  VerifyOtpReqBody({
    this.data,
  });

  final VerifyOtpData? data;

  factory VerifyOtpReqBody.fromJson(Map<String, dynamic> json) =>
      VerifyOtpReqBody(
        data: VerifyOtpData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}
