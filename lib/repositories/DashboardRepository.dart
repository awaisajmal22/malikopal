import 'dart:convert';

import 'package:malikopal/model/ClosingRatioResponse.dart';
import 'package:malikopal/model/DashboardResponse.dart';
import 'package:malikopal/model/GalleryResponse.dart';
import 'package:malikopal/model/MessageHistoryResponse.dart';
import 'package:malikopal/model/PaymentDetailResponse.dart';
import 'package:malikopal/model/ReceivedAmountResponse.dart';
import 'package:malikopal/model/ReferenceInResponse.dart';
import 'package:malikopal/model/SendNotificationResponse.dart';
import 'package:malikopal/model/ClosingPaymentResponse.dart';
import 'package:malikopal/model/UpdateBankResponse.dart';
import 'package:malikopal/model/UpdateProfileResponse.dart';
import 'package:malikopal/model/WithdrawResponse.dart';
import 'package:malikopal/model/requestbody/HistoryReqBody.dart';
import 'package:malikopal/model/requestbody/PaymentHistoryReqBody.dart';
import 'package:malikopal/model/requestbody/ReceivePaymentReqBody.dart';
import 'package:malikopal/model/requestbody/ReceivedAmountReqBody.dart';
import 'package:malikopal/model/requestbody/SaveMessageReqBody.dart';
import 'package:malikopal/model/requestbody/UpdateBankReqBody.dart';
import 'package:malikopal/model/requestbody/UpdateProfileReqBody.dart';
import 'package:malikopal/model/requestbody/WithdrawReqBody.dart';
import 'package:malikopal/model/rollerover_status.dart';
import 'package:malikopal/model/tranfer_rolll_over.dart';
import 'package:malikopal/model/widthfrawdata.dart';
import 'package:malikopal/networking/ApiBaseHelper.dart';
import 'package:malikopal/networking/Endpoints.dart';
import 'package:malikopal/repositories/BaseRepository.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/autorollerover/model/auto_roller_list_model.dart';
import 'package:malikopal/screens/setting/subreference/reference_user.dart';
import 'package:malikopal/screens/setting/subreference/sub_reference_user_model.dart';
import '../model/capital_history_responce.dart';
import '../model/last_deposit_data.dart';
import '../screens/setting/subreference/sub_reference_model.dart';
import '../screens/setting/subreference/sub_reference_post.dart';

class DashboardRepository extends BaseRepository {
  static final DashboardRepository _singleton = DashboardRepository._internal();

  factory DashboardRepository() {
    return _singleton;
  }

  DashboardRepository._internal();
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<DashboardResponse> GetDashboardData() async {
    final response = await _helper.get(Endpoints.DashboardDataUrl);
    return DashboardResponse.fromJson(response);
  }

  Future<WithdrawResponse> GetWithdrawalData() async {
    //

    final response = await _helper.get(Endpoints.WithdrawDataUrl);

    return WithdrawResponse.fromJson(response);
  }

  Future<WithdrawResponse> SaveWithdrawalData(WithdrawReqBody reqBody) async {
    final response = await _helper.post(Endpoints.SaveWithDrawUrl, reqBody);
    var resp = WithdrawResponse.fromJson(response);
    return resp;
  }

  Future<WithdrawResponse> getWidthDrawData(var reqBody) async {
    final response = await _helper.post(Endpoints.SaveWithDrawUrl, reqBody);

    var resp = WithdrawResponse.fromJson(response);
    return resp;
  }

  Future<WidthDrawStatus?> getWidrawStatus() async {
    final response = await _helper.getNew(Endpoints.widthdrawget);

    dp(msg: "Status data", arg: response.runtimeType);

    var resp = widthDrawStatusFromJson(response);
    print(resp.data?.withdrawRequest?.requestDate);
    return resp;
  }

  Future<AutoRollerOverList?> getAutoRollerOver() async {
    final response = await _helper.getNew(Endpoints.autoRollerOver);

    dp(msg: "Status data", arg: response.runtimeType);

    var resp = autoRollerOverListFromJson(response);

    return resp;
  }

  Future<Map<String, dynamic>> sendOtp(String userId) async {
    final response = await _helper.postNew(Endpoints.sendOtp + userId, {});

    dp(msg: "Status data", arg: response.runtimeType);
    var dresp = jsonDecode(response);

    return {"status": dresp['Status'], "message": dresp['Mesage']};
  }

  Future<Map<String, dynamic>> resetPassword(
      String userId, String otp, String password) async {
    final response = await _helper.postNew(
        Endpoints.verifyPassword +
            userId +
            "&Code=" +
            otp +
            "&Password=" +
            password,
        {});

    dp(msg: "Status data", arg: response.runtimeType);
    var dresp = jsonDecode(response);

    return {"status": dresp['Status'], "message": dresp['Mesage']};
  }

  Future<SubRefenceModel?> getSubRefence(SubRefencePostData data) async {
    //

    final response =
        await _helper.postNew(Endpoints.subRefenceApi, data.toJson());

    dp(msg: "Status data", arg: response.runtimeType);

    // return SubRefenceModel.fromJson(subRefeMap);
    // ;

    if (response != null) {
      var resp = subRefenceModelFromJson(response);

      return resp;
    } else {
      return null;
    }
  }

  Future<SubRefenceUserData?> getSubRefenceSub(SubRefencePostData data) async {
    //

    final response =
        await _helper.postNew(Endpoints.subRefenceApi, data.toJson());

    // dp(msg: "Status data", arg: response.runtimeType);

    // return SubRefenceUserData.fromJson(subRefenceUserFake);
    // ;

    if (response != null) {
      var resp = subRefenceUserDataFromJson(response);
      dp(msg: "Decode data", arg: resp.data?.toJson());
      return resp;
    } else {
      return null;
    }
  }

  Future<RefrenceInUser?> getSubUserRefence(SubRefencePostData data) async {
    //

    final response =
        await _helper.postNew(Endpoints.subRefenceUseranyApi, data.toJson());

    // dp(msg: "Status data", arg: response.runtimeType);

    // return SubRefenceUserData.fromJson(subRefenceUserFake);
    // ;

    if (response != null) {
      var resp = refrenceInUserFromJson(response);
      dp(msg: "Decode data", arg: resp.data?.toJson());
      return resp;
    } else {
      return null;
    }
  }

  var subRefenceUserFake = {
    "Data": {
      "ShowList": false,
      "ShowData": false,
      "MemberCount": 1.0,
      "TotalCapital": 1200000.0,
      "TotalClosing": 0.0,
      "ReferenceNodes": [
        {
          "ProfileID": 589,
          "UserID": "100023",
          "FullName": "Toqeer",
          "UserCapitalAmount": 1200000.0,
          "Allow": false,
          "AccountType": "Member",
          "ACD": "2021-04-11T00:00:00",
          "MemberCount": 0,
          "MemberCapital": 0.0,
          "PlusMemberCount": 0,
          "PlusMemberCapital": 0.0,
          "ReferenceUserID": "100362",
          "DirectReferenceUserID": "100614",
          "RecentClosingAmount": 121200.0
        }
      ]
    },
    "Message": null,
    "ErrorList": []
  };

  var subRefeMap = {
    "Data": {
      "ShowList": false,
      "ShowData": false,
      "MemberCount": 1.0,
      "TotalCapital": 715000.0,
      "TotalClosing": 0.0,
      "ReferenceNodes": [
        {
          "ProfileID": 615,
          "UserID": "100614",
          "FullName": "ZOHAIB AHMAD",
          "UserCapitalAmount": 715000.0,
          "Allow": true,
          "AccountType": "Plus",
          "ACD": "2022-05-28T00:00:00",
          "MemberCount": 1,
          "MemberCapital": 0.0,
          "PlusMemberCount": 0,
          "PlusMemberCapital": 0.0,
          "ReferenceUserID": "100362",
          "DirectReferenceUserID": null,
          "RecentClosingAmount": 57772.0
        }
      ]
    },
    "Message": null,
    "ErrorList": []
  };

  Future<UpdateProfileResponse> GetProfileData() async {
    final response = await _helper.get(Endpoints.ProfileDataUrl);
    return UpdateProfileResponse.fromJson(response);
  }

  Future<UpdateProfileResponse> GetProfileViewData(int profileid) async {
    final response = await _helper.get(
        Endpoints.ProfileViewDataUrl + "?profileId=" + profileid.toString());
    return UpdateProfileResponse.fromJson(response);
  }

  Future<UpdateProfileResponse> SaveProfileData(
      UpdateProfileReqBody reqBody) async {
    final response = await _helper.post(Endpoints.SaveProfileUrl, reqBody);
    var resp = UpdateProfileResponse.fromJson(response);
    return resp;
  }

  Future<dynamic> SaveProfilePicture(String path) async {
    final response = await _helper.postProfilePic(Endpoints.uploadPicUrl, path);
    return response;
  }

  Future<UpdateBankResponse> GetBankData() async {
    final response = await _helper.get(Endpoints.BankDataUrl);
    return UpdateBankResponse.fromJson(response);
  }

  Future<UpdateBankResponse> SaveBankData(UpdateBankReqBody reqBody) async {
    final response = await _helper.post(Endpoints.SaveBankUrl, reqBody);
    var resp = UpdateBankResponse.fromJson(response);
    return resp;
  }

  Future<TransferRollover> getTransferData() async {
    final response = await _helper.getNew(Endpoints.transferdata);
    print(response);
    return transferRolloverFromJson(response);
  }

  Future<ClosingPaymentResponse> GetPaymentRolloverData() async {
    final response = await _helper.get(Endpoints.PaymentRolloverDataUrl);
    return ClosingPaymentResponse.fromJson(response);
  }

  Future<RollerOverStatus> getRollerOverStatus() async {
    final response = await _helper.getNew(Endpoints.rollerOverStatus);
    return rollerOverStatusFromJson(response);
  }

  Future<TransferRollover> SavePaymentRolloverNew(
      ReceivePaymentReqBody reqBody) async {
    final response =
        await _helper.postNew("dashboard/transferrollover-post", reqBody);
    var resp = transferRolloverFromJson(response);
    return resp;
  }

  Future<WidthDrawStatus> withDrawPOst(WithdrawReqBody reqBody) async {
    final response = await _helper.postNew("dashboard/withdraw-post", reqBody);
    var resp = widthDrawStatusFromJson(response);
    return resp;
  }

  Future<RollerOverStatus> SavePaymentRolloverAll(
      ReceivePaymentReqBody reqBody) async {
    final response =
        await _helper.postNew("dashboard/allrollover-post", reqBody);
    var resp = rollerOverStatusFromJson(response);
    return resp;
  }

  Future<ClosingPaymentResponse> SavePaymentRollover(
      ReceivePaymentReqBody reqBody) async {
    final response =
        await _helper.post(Endpoints.SavePaymeyRolloverUrl, reqBody);
    var resp = ClosingPaymentResponse.fromJson(response);
    return resp;
  }

  Future<ClosingPaymentResponse> closingPaymentRequest(
      ReceivePaymentReqBody reqBody) async {
    final response =
        await _helper.post(Endpoints.SavePaymeyRolloverUrl, reqBody);
    var resp = ClosingPaymentResponse.fromJson(response);
    return resp;
  }

  Future<ClosingPaymentResponse> SaveRollover(
      ReceivePaymentReqBody reqBody) async {
    final response = await _helper.post(Endpoints.SaveRolloverUrl, reqBody);
    var resp = ClosingPaymentResponse.fromJson(response);
    return resp;
  }

  Future<ClosingRatioResponse> GetClosingRatioData() async {
    final response = await _helper.get(Endpoints.RatioUrl);
    return ClosingRatioResponse.fromJson(response);
  }

  Future<PaymentRolloverHistoryResponse> GetPaymentRolloveHistoryData(
      PaymentHistoryReqBody reqBody) async {
    final response =
        await _helper.post(Endpoints.PaymentRolloverHistoryUrl, reqBody);
    return PaymentRolloverHistoryResponse.fromJson(response);
  }

  // Future<CapitalHistoryResponse> GetCapitalHistoryData() async {
  //   final response = await _helper.get(Endpoints.CapitalHistoryRequestGet);
  //   return CapitalHistoryResponse.fromJson(response);
  // }

  Future<CapitalHistoryResponse> GetCapitalHistoryData(
      HistoryReqBody reqBody) async {
    final response = await _helper.post(Endpoints.CapitalHistoryUrl, reqBody);
    dp(msg: "Capital type", arg: response.runtimeType);
    dp(msg: "Capital data", arg: response);
    var resp = CapitalHistoryResponse.fromJson(response);
    dp(msg: "Capital history responce", arg: resp.toJson());
    return resp;
  }
  //GetLastAddedAmountyData

  Future<CapitalHistoryResponse> GetLastAddedAmountyData(
      HistoryReqBody reqBody) async {
    final response =
        await _helper.post(Endpoints.LastAddAmountHistoryUrl, reqBody);

    dp(msg: "Last deposit", arg: response);

    var resp = CapitalHistoryResponse.fromJson(response);
    return resp;
  }

  Future<NewCapitalHistoryResponse?> GetLastAddedAmountyDataNew(
      HistoryReqBody reqBody) async {
    final response =
        await _helper.post(Endpoints.LastAddAmountHistoryUrl, reqBody);

    dp(msg: "Last deposit", arg: response);

    var resp = NewCapitalHistoryResponse.fromJson(response);
    return resp;
  }

  Future<ReceivedAmountResponse> GetReceivedAmount(
      ReceivedAmountReqBody reqBody) async {
    final response = await _helper.post(Endpoints.ReceivedAmountUrl, reqBody);
    var resp = ReceivedAmountResponse.fromJson(response);
    return resp;
  }

  Future<SendNotificationResponse> GetNotificationData() async {
    final response = await _helper.get(Endpoints.NotificationUrl);
    return SendNotificationResponse.fromJson(response);
  }

  Future<RefrenceInResponseData> PostReferenceInData(
      HistoryReqBody reqBody, String? query) async {
    final response = await _helper.post(Endpoints.SaveReferenceInUrl, reqBody);
    var resp = RefrenceInResponseData.fromJson(response);
    return resp;
  }

  Future<MessageHistoryResponse> GetMessageHistoryData() async {
    final response = await _helper.get(Endpoints.MessageHistoryUrl);
    return MessageHistoryResponse.fromJson(response);
  }

  Future<MessageHistoryResponse> SaveMessageData(
      SaveMessageReqBody reqBody) async {
    final response = await _helper.post(Endpoints.SaveMessageUrl, reqBody);
    var resp = MessageHistoryResponse.fromJson(response);
    return resp;
  }

  Future<GalleryResponse> GetGalleryData() async {
    final response = await _helper.get(Endpoints.galleryUrl);
    return GalleryResponse.fromJson(response);
  }

//https://localhost:44321/api/dashboard/auto-rollover-post
  Future<AutoRollerOverList?> postAutoRollOver(int id) async {
    try {
      var responce =
          await _helper.postNew(Endpoints.postAutoRollover, {"Data": id});
      return autoRollerOverListFromJson(responce);
    } catch (e, s) {
      dp(msg: "Error $e", arg: s);
      return null;
    }
  }
}
