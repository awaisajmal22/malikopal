import 'dart:async';
import 'package:malikopal/bloc/base_bloc.dart';
import 'package:malikopal/model/auth_model/LoginResponse.dart';
import 'package:malikopal/model/auth_model/SendOtpResponse.dart';
import 'package:malikopal/model/auth_model/VerifyOtpResponse.dart';
import 'package:malikopal/model/requestbody/ChangePasswordReqBody.dart';
import 'package:malikopal/model/requestbody/SendOtpReqBody.dart';
import 'package:malikopal/model/requestbody/ThumbReqBody.dart';
import 'package:malikopal/model/requestbody/UserLoginReqBody.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/model/auth_model/LoginData.dart';
import 'package:malikopal/utils/Const.dart';

class AuthBloc implements BaseBloc {
  //

  AuthRepository _repository = AuthRepository();

  late StreamController<ApiResponse<UserLoginData>> _scPostLogin;
  late StreamController<ApiResponse<SendOtpResponseData>> _scSendOtp;
  late StreamController<ApiResponse<VerifyOtpResponseData>> _scVerifyOtp;
  late StreamController<ApiResponse<ChangePasswordReqData>> _scPassChangePost;
  late StreamController<ApiResponse<UserLoginData>> _scActivateThumb;
  late StreamController<ApiResponse<UserLoginData>> _scLoginByThumb;

  StreamSink<ApiResponse<UserLoginData>> get loginResponseSink =>
      _scPostLogin.sink;
  Stream<ApiResponse<UserLoginData>> get loginResponseStream =>
      _scPostLogin.stream;

  StreamSink<ApiResponse<SendOtpResponseData>> get sendOtpDataSink =>
      _scSendOtp.sink;
  Stream<ApiResponse<SendOtpResponseData>> get sendOtopDateStream =>
      _scSendOtp.stream;

  StreamSink<ApiResponse<VerifyOtpResponseData>> get verifyOtpSink =>
      _scVerifyOtp.sink;
  Stream<ApiResponse<VerifyOtpResponseData>> get verifyOtpStream =>
      _scVerifyOtp.stream;

  StreamSink<ApiResponse<ChangePasswordReqData>> get passChangeSink =>
      _scPassChangePost.sink;
  Stream<ApiResponse<ChangePasswordReqData>> get passChangeStream =>
      _scPassChangePost.stream;

  StreamSink<ApiResponse<UserLoginData>> get ActivateThumbSink =>
      _scActivateThumb.sink;
  Stream<ApiResponse<UserLoginData>> get ActivateThumbStream =>
      _scActivateThumb.stream;

  StreamSink<ApiResponse<UserLoginData>> get LoginByThumbSink =>
      _scLoginByThumb.sink;
  Stream<ApiResponse<UserLoginData>> get LoginByThumbStream =>
      _scLoginByThumb.stream;

  AuthBloc() {
    _scPostLogin = StreamController<ApiResponse<UserLoginData>>();
    _scSendOtp = StreamController<ApiResponse<SendOtpResponseData>>();
    _scVerifyOtp = StreamController<ApiResponse<VerifyOtpResponseData>>();
    _scPassChangePost = StreamController<ApiResponse<ChangePasswordReqData>>();
    _scActivateThumb = StreamController<ApiResponse<UserLoginData>>();
    _scLoginByThumb = StreamController<ApiResponse<UserLoginData>>();
    _repository = AuthRepository();
  }

  postLoginFormData(LoginFormData data) async {
    UserLoginReqBody reqBody = UserLoginReqBody(data: data);

    loginResponseSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));

    try {
      UserLoginResponse response = await _repository.postLoginFormData(reqBody);
      loginResponseSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      loginResponseSink.add(
          ApiResponse.error("User name or password is empty please try again"));
      print(e.toString());
    }
  }

  postSendOtp(SendOtpData data) async {
    SendOtpReqBody reqBody = SendOtpReqBody(data: data);
    sendOtpDataSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      var response = await _repository.postSendOtpData(reqBody);
      sendOtpDataSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      sendOtpDataSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  postVerifyOtp(VerifyOtpData data) async {
    VerifyOtpReqBody reqBody = VerifyOtpReqBody(data: data);
    verifyOtpSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      var response = await _repository.postVerifyOtpData(reqBody);
      verifyOtpSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      verifyOtpSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  SaveChangePassword(ChangePasswordReqData data) async {
    ChangePasswordReqBody reqBody = ChangePasswordReqBody(data: data);
    passChangeSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      var response = await _repository.postChangePassword(reqBody);
      passChangeSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      passChangeSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  ActivateThumbLogin(ThumbReqData data) async {
    ThumbReqBody reqBody = ThumbReqBody(data: data);
    ActivateThumbSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      var response = await _repository.ActivateThumb(reqBody);
      ActivateThumbSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      ActivateThumbSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  ThumbLogin(ThumbReqData data) async {
    ThumbReqBody reqBody = ThumbReqBody(data: data);

    LoginByThumbSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));

    try {
      UserLoginResponse response = await _repository.LoginByThumb(reqBody);
      LoginByThumbSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      LoginByThumbSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _scPostLogin.close();
    _scSendOtp.close();
    _scVerifyOtp.close();
  }
}
