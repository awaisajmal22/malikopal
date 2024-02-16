import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:malikopal/model/auth_model/ChangePasswordResponse.dart';
import 'package:malikopal/model/auth_model/LoginResponse.dart';
import 'package:malikopal/model/auth_model/SendOtpResponse.dart';
import 'package:malikopal/model/auth_model/VerifyOtpResponse.dart';
import 'package:malikopal/model/requestbody/ChangePasswordReqBody.dart';
import 'package:malikopal/model/requestbody/SendOtpReqBody.dart';
import 'package:malikopal/model/requestbody/ThumbReqBody.dart';
import 'package:malikopal/model/requestbody/UserLoginReqBody.dart';
import 'package:malikopal/networking/ApiBaseHelper.dart';
import 'package:malikopal/networking/Endpoints.dart';
import 'package:malikopal/repositories/BaseRepository.dart';

dp({msg, arg}) {
  debugPrint(" ===== $msg   $arg  ====== \n");
}

class AuthRepository extends BaseRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  static final AuthRepository _AuthRepository = AuthRepository._internal();

  factory AuthRepository() {
    return _AuthRepository;
  }

  AuthRepository._internal();
  Future<UserLoginResponse> postLoginFormData(UserLoginReqBody reqBody) async {
    //

    dp(msg: "user login data", arg: reqBody.data!.toJson());

    final response = await _helper.post(Endpoints.LoginUrl, reqBody);

    dp(msg: "Login responce", arg: jsonEncode(response).toString());

    var resp = UserLoginResponse.fromJson(response);
    return resp;
  }
  // Future<UserLoginResponse> postLoginFormData(UserLoginReqBody reqBody) async {
  //   final response = await _helper.post(Endpoints.LoginUrl, reqBody);
  //   var resp = UserLoginResponse.fromJson(response);
  //   return resp;
  // }

  Future<SendOtpResponse> postSendOtpData(SendOtpReqBody reqBody) async {
    final response = await _helper.post(Endpoints.OtpUrl, reqBody);
    return SendOtpResponse.fromJson(response);
  }

  Future<VerifyOtpResponse> postVerifyOtpData(VerifyOtpReqBody reqBody) async {
    final response = await _helper.post(Endpoints.VerifyOtpUrl, reqBody);
    return VerifyOtpResponse.fromJson(response);
  }

  Future<ChangePasswordResponse> postChangePassword(
      ChangePasswordReqBody reqBody) async {
    final response = await _helper.post(Endpoints.ChangePasswordUrl, reqBody);
    return ChangePasswordResponse.fromJson(response);
  }

  Future<UserLoginResponse> ActivateThumb(ThumbReqBody reqBody) async {
    final response = await _helper.post(Endpoints.ActivateThumbUrl, reqBody);
    return UserLoginResponse.fromJson(response);
  }

  Future<UserLoginResponse> LoginByThumb(ThumbReqBody reqBody) async {
    final response = await _helper.post(Endpoints.LoginByThumbUrl, reqBody);
    return UserLoginResponse.fromJson(response);
  }
}
