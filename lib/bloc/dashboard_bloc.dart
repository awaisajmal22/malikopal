import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:malikopal/bloc/base_bloc.dart';
import 'package:malikopal/model/CapitalHistoryResponse.dart';
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
import 'package:malikopal/model/requestbody/ProfilePicReqBody.dart';
import 'package:malikopal/model/requestbody/ReceivePaymentReqBody.dart';
import 'package:malikopal/model/requestbody/ReceivedAmountReqBody.dart';
import 'package:malikopal/model/requestbody/SaveMessageReqBody.dart';
import 'package:malikopal/model/requestbody/UpdateBankReqBody.dart';
import 'package:malikopal/model/requestbody/UpdateProfileReqBody.dart';
import 'package:malikopal/model/requestbody/WithdrawReqBody.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/repositories/DashboardRepository.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/utils/Const.dart';

import '../model/capital_history_responce.dart';
import '../model/widthfrawdata.dart';

class DashboardBloc implements BaseBloc {
  DashboardRepository _repository = DashboardRepository();

  late StreamController<ApiResponse<DashboardResponseData>> _scDashboarData;

  StreamSink<ApiResponse<DashboardResponseData>> get dashboardResponseSink =>
      _scDashboarData.sink;
  Stream<ApiResponse<DashboardResponseData>> get dashboardResponseStream =>
      _scDashboarData.stream;

//   -----withdraw
  late StreamController<ApiResponse<WidthDrawStatus>> _scWithdrawgetData;

  StreamSink<ApiResponse<WidthDrawStatus>> get WithdrawResponsegetSink =>
      _scWithdrawgetData.sink;
  Stream<ApiResponse<WidthDrawStatus>> get WithdrawResponsegetStream =>
      _scWithdrawgetData.stream;

  late StreamController<ApiResponse<WidthDrawStatus>> _scWithdrawpostData;

  StreamSink<ApiResponse<WidthDrawStatus>> get WithdrawResponsepostSink =>
      _scWithdrawpostData.sink;
  Stream<ApiResponse<WidthDrawStatus>> get WithdrawResponsepostStream =>
      _scWithdrawpostData.stream;

//   ------ Update Profile

  late StreamController<ApiResponse<UpdateProfileResponseData>>
      _scProfilegetData;

  StreamSink<ApiResponse<UpdateProfileResponseData>>
      get UpdateProfileResponsegetSink => _scProfilegetData.sink;
  Stream<ApiResponse<UpdateProfileResponseData>>
      get UpdateProfileResponsegetStream => _scProfilegetData.stream;

  late StreamController<ApiResponse<UpdateProfileResponseData>>
      _scUpdateProfilepostData;

  StreamSink<ApiResponse<UpdateProfileResponseData>>
      get UpdateProfileResponsepostSink => _scUpdateProfilepostData.sink;
  Stream<ApiResponse<UpdateProfileResponseData>>
      get UpdateProfileResponsepostStream => _scUpdateProfilepostData.stream;

//  -----Update Bank Controllers

  late StreamController<ApiResponse<UpdateBankResponseData>> _scBankgetData;

  StreamSink<ApiResponse<UpdateBankResponseData>> get GetBankDataSink =>
      _scBankgetData.sink;
  Stream<ApiResponse<UpdateBankResponseData>> get GetBankDataStream =>
      _scBankgetData.stream;

  late StreamController<ApiResponse<UpdateBankResponseData>> _scSaveBankData;

  StreamSink<ApiResponse<UpdateBankResponseData>> get SaveBankDataSink =>
      _scSaveBankData.sink;
  Stream<ApiResponse<UpdateBankResponseData>> get SaveBankDataStream =>
      _scSaveBankData.stream;

  //  -----send Payment Controllers

  late StreamController<ApiResponse<ClosingPaymentResponseData>>
      _scGetPaymentRolloverData;

  StreamSink<ApiResponse<ClosingPaymentResponseData>>
      get GetPaymentRolloverSink => _scGetPaymentRolloverData.sink;
  Stream<ApiResponse<ClosingPaymentResponseData>>
      get GetPaymentRolloverStream => _scGetPaymentRolloverData.stream;

  late StreamController<ApiResponse<ClosingPaymentResponseData>>
      _scSavePaymentRolloverData;

  StreamSink<ApiResponse<ClosingPaymentResponseData>>
      get SavePaymentRolloverSink => _scSavePaymentRolloverData.sink;
  Stream<ApiResponse<ClosingPaymentResponseData>>
      get SavePaymentRolloverStream => _scSavePaymentRolloverData.stream;

  //  -----Closing Ratio Controllers
  late StreamController<ApiResponse<ClosingRatioResponseData>>
      _scClosingRatiogetData;

  StreamSink<ApiResponse<ClosingRatioResponseData>> get GetClosingRatioSink =>
      _scClosingRatiogetData.sink;
  Stream<ApiResponse<ClosingRatioResponseData>> get GetClosingRatioStream =>
      _scClosingRatiogetData.stream;

  //------------- Payment Detail Controller

  late StreamController<ApiResponse<List<PaymentRolloverHistoryResponseData>>>
      _scPaymentRolloverHistoryData;

  StreamSink<ApiResponse<List<PaymentRolloverHistoryResponseData>>>
      get PaymentRolloverHistorySink => _scPaymentRolloverHistoryData.sink;
  Stream<ApiResponse<List<PaymentRolloverHistoryResponseData>>>
      get PaymentRolloverHistoryStream => _scPaymentRolloverHistoryData.stream;

  //------------- Send Notification Detail Controller

  late StreamController<ApiResponse<List<SendNotificationResponseData>>>
      _scNotificationtData;

  StreamSink<ApiResponse<List<SendNotificationResponseData>>>
      get GetNotificationSink => _scNotificationtData.sink;
  Stream<ApiResponse<List<SendNotificationResponseData>>>
      get GetNotificationStream => _scNotificationtData.stream;

  //------------- History Data Post Controller

  late StreamController<ApiResponse<CapitalHistoryResponseData>>
      _scCapitalHistoryData;

  StreamSink<ApiResponse<CapitalHistoryResponseData>> get CapitalHistorySink =>
      _scCapitalHistoryData.sink;
  Stream<ApiResponse<CapitalHistoryResponseData>> get CapitalHistoryStream =>
      _scCapitalHistoryData.stream;

  //  ----------------Capital History  Controller

  late StreamController<ApiResponse<ReceivedAmountResponseData>>
      _scReceivedAmountData;

  StreamSink<ApiResponse<ReceivedAmountResponseData>> get ReceivedAmountSink =>
      _scReceivedAmountData.sink;
  Stream<ApiResponse<ReceivedAmountResponseData>> get ReceivedAmountStream =>
      _scReceivedAmountData.stream;

  //------------Reference in

  late StreamController<ApiResponse<RefrenceInResponseData>> _scReferenceInData;

  StreamSink<ApiResponse<RefrenceInResponseData>> get GetReferenceInSink =>
      _scReferenceInData.sink;
  Stream<ApiResponse<RefrenceInResponseData>> get GetReferenceInStream =>
      _scReferenceInData.stream;

  //------------ Message History Load

  late StreamController<ApiResponse<List<MessageHistoryResponseData>>>
      _scMessageHistoryData;

  StreamSink<ApiResponse<List<MessageHistoryResponseData>>>
      get GetMessageHistorySink => _scMessageHistoryData.sink;
  Stream<ApiResponse<List<MessageHistoryResponseData>>>
      get GetMessageHistoryStream => _scMessageHistoryData.stream;

  //------------Save Message

  late StreamController<ApiResponse<List<MessageHistoryResponseData>>>
      _scSaveMessageData;

  StreamSink<ApiResponse<List<MessageHistoryResponseData>>>
      get SaveMessageSink => _scSaveMessageData.sink;
  Stream<ApiResponse<List<MessageHistoryResponseData>>> get SaveMessageStream =>
      _scSaveMessageData.stream;

  //------------Save Profile Pic

  late StreamController<ApiResponse<dynamic>> _scSavePicData;

  StreamSink<ApiResponse<dynamic>> get SavePicSink => _scSavePicData.sink;
  Stream<ApiResponse<dynamic>> get SavePicStream => _scSavePicData.stream;

  late StreamController<ApiResponse<List<GalleryResponseData>>> _scGalleryData;

  StreamSink<ApiResponse<List<GalleryResponseData>>> get GallerySink =>
      _scGalleryData.sink;
  Stream<ApiResponse<List<GalleryResponseData>>> get GalleryStream =>
      _scGalleryData.stream;
  //---------------------------------Initialization End

  DashboardBloc() {
    _scDashboarData = StreamController<ApiResponse<DashboardResponseData>>();
    _scWithdrawgetData = StreamController<ApiResponse<WidthDrawStatus>>();
    _scWithdrawpostData = StreamController<ApiResponse<WidthDrawStatus>>();
    _scProfilegetData =
        StreamController<ApiResponse<UpdateProfileResponseData>>();
    _scUpdateProfilepostData =
        StreamController<ApiResponse<UpdateProfileResponseData>>();
    _scBankgetData = StreamController<ApiResponse<UpdateBankResponseData>>();
    _scSaveBankData = StreamController<ApiResponse<UpdateBankResponseData>>();
    _scGetPaymentRolloverData =
        StreamController<ApiResponse<ClosingPaymentResponseData>>();
    _scSavePaymentRolloverData =
        StreamController<ApiResponse<ClosingPaymentResponseData>>();
    _scClosingRatiogetData =
        StreamController<ApiResponse<ClosingRatioResponseData>>();
    _scPaymentRolloverHistoryData = StreamController<
        ApiResponse<List<PaymentRolloverHistoryResponseData>>>.broadcast();
    _scNotificationtData =
        StreamController<ApiResponse<List<SendNotificationResponseData>>>();
    _scCapitalHistoryData =
        StreamController<ApiResponse<CapitalHistoryResponseData>>.broadcast();
    _scReceivedAmountData =
        StreamController<ApiResponse<ReceivedAmountResponseData>>();
    _scReferenceInData =
        StreamController<ApiResponse<RefrenceInResponseData>>.broadcast();
    _scMessageHistoryData = StreamController<
        ApiResponse<List<MessageHistoryResponseData>>>.broadcast();
    _scSaveMessageData = StreamController<
        ApiResponse<List<MessageHistoryResponseData>>>.broadcast();
    _scGalleryData =
        StreamController<ApiResponse<List<GalleryResponseData>>>.broadcast();
    _repository = DashboardRepository();

    _scSavePicData = StreamController<ApiResponse<dynamic>>();
  }

  getDashboardData() async {
    dashboardResponseSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));

    try {
      DashboardResponse response = await _repository.GetDashboardData();
      dashboardResponseSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      dashboardResponseSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  getWithdrawData() async {
    WithdrawResponsegetSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      // WidthDrawStatus response = await _repository.getWidrawStatus();

      // dp(msg: "Widgth draw data", arg: response.toJson());
      // WithdrawResponsegetSink.add(ApiResponse.completed(response));
    } catch (e) {
      WithdrawResponsegetSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  getWithDrawData() async {
    WithdrawResponsepostSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    // var response = await _repository.SaveWithdrawalData( );
  }

  SaveWithdrawalData(WithdrawReqData data) async {
    WithdrawResponsepostSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    WithdrawReqBody reqBody = WithdrawReqBody(data: data);
    try {
      WithdrawResponse response = await _repository.SaveWithdrawalData(reqBody);
      // WithdrawResponsepostSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      WithdrawResponsepostSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------ update Profile methods

  GetProfileData() async {
    UpdateProfileResponsegetSink.add(
        ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      UpdateProfileResponse response = await _repository.GetProfileData();
      UpdateProfileResponsegetSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      UpdateProfileResponsegetSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  GetProfileViewData(int profileid) async {
    UpdateProfileResponsegetSink.add(
        ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      UpdateProfileResponse response =
          await _repository.GetProfileViewData(profileid);
      UpdateProfileResponsegetSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      UpdateProfileResponsegetSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  ProfilePicReqData? GetImageData(String filePath) {
    if (filePath == "") return null;
    final publicKey = '';
    final imageType = lookupMimeType(filePath).toString();
    final fileName = filePath.split('/').last;
    final base64Image = base64Encode(File(filePath).readAsBytesSync());
    ProfilePicReqData req = ProfilePicReqData(
        publicKey: publicKey,
        imageType: imageType,
        fileName: fileName,
        base64Image: base64Image);
    return req;
  }

  SaveProfileData(UpdateProfileReqData data, String? image) async {
    UpdateProfileResponsepostSink.add(
        ApiResponse.loading(Const.COMMON_PLEASE_WAIT));

    UpdateProfileReqBody reqBody = UpdateProfileReqBody(
        data: data, uploadPicture: GetImageData(image ?? ""));
    try {
      UpdateProfileResponse response =
          await _repository.SaveProfileData(reqBody);
      UpdateProfileResponsepostSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      UpdateProfileResponsepostSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------ update Bank get methods

  GetBankData() async {
    GetBankDataSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      UpdateBankResponse response = await _repository.GetBankData();
      GetBankDataSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      GetBankDataSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }
  //  ------ update Bank POst methods

  SaveBankData(UpdateBankReqData data) async {
    SaveBankDataSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    UpdateBankReqBody reqBody = UpdateBankReqBody(data: data);
    try {
      UpdateBankResponse response = await _repository.SaveBankData(reqBody);
      SaveBankDataSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      SaveBankDataSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------Send Payment get methods

  GetPaymentRolloverData() async {
    GetPaymentRolloverSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      ClosingPaymentResponse response =
          await _repository.GetPaymentRolloverData();
      GetPaymentRolloverSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      GetPaymentRolloverSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------Receive Payment Post methods
  SavePaymentRollover(ReceivePaymentReqData data) async {
    SavePaymentRolloverSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));

    ReceivePaymentReqBody reqBody = ReceivePaymentReqBody(data: data);

    try {
      ClosingPaymentResponse response =
          await _repository.SavePaymentRollover(reqBody);
      SavePaymentRolloverSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      SavePaymentRolloverSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------Receive Payment Post methods
  SaveRollover(ReceivePaymentReqData data) async {
    SavePaymentRolloverSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    ReceivePaymentReqBody reqBody = ReceivePaymentReqBody(data: data);
    try {
      ClosingPaymentResponse response =
          await _repository.SavePaymentRollover(reqBody);
      SavePaymentRolloverSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      SavePaymentRolloverSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }
  //  ------Send Closing Ratio get methods

  GetClosingRatioData() async {
    GetClosingRatioSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      ClosingRatioResponse response = await _repository.GetClosingRatioData();
      GetClosingRatioSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      GetClosingRatioSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------Payment Detail get methods

  GetPaymentRolloveHistoryData(PaymentHistoryReqData data) async {
    PaymentRolloverHistorySink.add(
        ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    PaymentHistoryReqBody reqBody = new PaymentHistoryReqBody(data: data);
    try {
      PaymentRolloverHistoryResponse response =
          await _repository.GetPaymentRolloveHistoryData(reqBody);
      PaymentRolloverHistorySink.add(ApiResponse.completed(response.data));
    } catch (e) {
      PaymentRolloverHistorySink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------ Notification get methods
  GetNotificationData() async {
    GetNotificationSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      SendNotificationResponse response =
          await _repository.GetNotificationData();
      GetNotificationSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      GetNotificationSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------ History Post methods
  GetCapitalHistoryData(HistoryReqData data) async {
    CapitalHistorySink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    HistoryReqBody reqBody = HistoryReqBody(data: data);
    try {
      CapitalHistoryResponse response =
          await _repository.GetCapitalHistoryData(reqBody);

      CapitalHistorySink.add(ApiResponse.completed(response.data));
    } catch (e) {
      CapitalHistorySink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  GetLastAddedAmountyData(HistoryReqData data) async {
    CapitalHistorySink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    HistoryReqBody reqBody = HistoryReqBody(data: data);
    try {
      CapitalHistoryResponse response =
          await _repository.GetLastAddedAmountyData(reqBody);
      CapitalHistorySink.add(ApiResponse.completed(response.data));
    } catch (e) {
      CapitalHistorySink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------ History Post methods
  GetReceivedAmountData(ReceivedAmountReqData data) async {
    ReceivedAmountSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    ReceivedAmountReqBody reqBody = ReceivedAmountReqBody(data: data);
    try {
      ReceivedAmountResponse response =
          await _repository.GetReceivedAmount(reqBody);
      ReceivedAmountSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      ReceivedAmountSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //Reference In Methods
  //  ------Reference In  Post methods
  GetReferenceIn(HistoryReqData data) async {
    GetReferenceInSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    HistoryReqBody reqBody = HistoryReqBody(data: data);
    try {
      RefrenceInResponseData response =
          await _repository.PostReferenceInData(reqBody, "");
      GetReferenceInSink.add(ApiResponse.completed(response));
    } catch (e) {
      GetReferenceInSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------Profile Pic  Post methods
  SaveProfilePic(String path) async {
    SavePicSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      dynamic response = await _repository.SaveProfilePicture(path);
      SavePicSink.add(ApiResponse.completed(response));
    } catch (e) {
      SavePicSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------ Notification get methods
  GetMessageHistoryData() async {
    GetMessageHistorySink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      MessageHistoryResponse response =
          await _repository.GetMessageHistoryData();
      GetMessageHistorySink.add(ApiResponse.completed(response.data));
    } catch (e) {
      GetMessageHistorySink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------Receive Payment Post methods
  SaveMessageData(SaveMessageReqBodyData data) async {
    SaveMessageSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    SaveMessageReqBody reqBody = SaveMessageReqBody(data: data);
    try {
      MessageHistoryResponse response =
          await _repository.SaveMessageData(reqBody);
      SaveMessageSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      SaveMessageSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  getGalleryData() async {
    GallerySink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));
    try {
      GalleryResponse response = await _repository.GetGalleryData();
      GallerySink.add(ApiResponse.completed(response.data));
    } catch (e) {
      GallerySink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _scDashboarData.close();
  }
}
