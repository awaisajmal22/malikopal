import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:malikopal/bloc/dashboard_bloc.dart';
import 'package:malikopal/model/PaymentDetailResponse.dart';
import 'package:malikopal/model/requestbody/PaymentHistoryReqBody.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/widgets/loading_dialog.dart';
import 'package:malikopal/utils/Const.dart';
import 'package:malikopal/utils/utility.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key, this.profileId}) : super(key: key);
  final int? profileId;
  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  late DashboardBloc _bloc;
  List<PaymentRolloverHistoryResponseData>? data;
  // double totalRollover = 0;
  // double totalTransfer = 0;
  @override
  void initState() {
    _bloc = DashboardBloc();
    _bloc.PaymentRolloverHistoryStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();
        setState(() {
          data = event.data;
          print(data);
          // totalRollover = 0;
          // totalTransfer = 0;
          // data?.forEach((element) {
          //   totalRollover += (element.Rollover ?? 0);
          //   totalTransfer += (element.Transfer ?? 0);
          // });
        });
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, "Error ! please try again", true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });
    _bloc.GetPaymentRolloveHistoryData(PaymentHistoryReqData(
        Month: "", Year: "0", Pno: 0, profileId: widget.profileId));
    super.initState();
  }

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(children: [
          Flexible(
              flex: 02, child: CustomTopBar(topbartitle: 'Payment History')),
          SizedBox(
            height: 12.h,
          ),
          Flexible(
              flex: 02,
              child: FilterDropDown(bloc: _bloc, profileId: widget.profileId)),
          Flexible(
            flex: 16,
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<
                    ApiResponse<List<PaymentRolloverHistoryResponseData>>>(
                  stream: _bloc.PaymentRolloverHistoryStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch ((snapshot.data?.status ?? "")) {
                        case Status.LOADING:
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            //child: Loading(loadingMessage: snapshot.data.message),
                          );
                        //break;
                        case Status.COMPLETED:
                          {
                            if (snapshot.data?.data?.isNotEmpty ?? false)
                              return ListBuilder(snapshot.data?.data ?? []);
                            else {
                              return Center(
                                child: Text("Empty History data"),
                              );
                            }
                          }
                          break;
                        case Status.ERROR:
                          return SizedBox.shrink();
                        //break;
                      }
                    }
                    return SizedBox.shrink();
                  },
                )),
          ),
        ]),
      ),
    );
  }

  tileTextStyle({double? size}) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
          fontSize: size ?? 14.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        );
  }
}

class ListBuilder extends StatelessWidget {
  final List<PaymentRolloverHistoryResponseData> data;
  ListBuilder(this.data);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      physics: ClampingScrollPhysics(),
      itemBuilder: ((context, index) {
        if (index >= data.length) return Container();

        //return Text("Text " + index.toString());
        return ShowUpAnimation(
          delayStart: Duration(milliseconds: 0),
          animationDuration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          direction: Direction.horizontal,
          offset: 0..h,
          child: Column(
            children: [
              PaymentHistoryCard(
                amount: "Rs. " +
                    Const.currencyFormatWithoutDecimal
                        .format(data[index].Amount ?? 0),
                type: '', //data[index].Type,
                date: data[index].DateStr,
                color: data[index].Type == "TR"
                    ? Color(0xff254180)
                    //  Color(0xff92298D)
                    : Color(0xFFF6921E),
                imagePath: data[index].Type == "TR"
                    ? "assets/svg/total_transfer.svg"
                    : "assets/svg/rollover.svg", //"assets/svg/closing_payment_history.svg", //
                expandable: CustomBriefCard(
                    title_v1: "Roll Over",
                    subtitle_v1: Const.currencyFormatWithoutDecimal
                        .format(data[index].Rollover ?? 0),
                    amount_size: 12.0,
                    trailing_v1: Container(
                      width: 95.w,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Closing month",
                            textAlign: TextAlign.start,
                            softWrap: true,
                            style: tileTextStyle(
                              context: context,
                              size: 10.sp,
                            ),
                          ),
                          // SizedBox(
                          //   height: 06.h,
                          // ),
                          Text(data[index].ClosingMonth.toString(),
                              textAlign: TextAlign.start,
                              softWrap: true,
                              style:
                                  tileTextStyle(context: context, size: 10.sp)),
                        ],
                      ),
                    ),
                    icon_v1: Center(
                      child: Container(
                        height: 20.h,
                        width: 20.w,
                        child: SvgPicture.asset('assets/svg/rollover.svg'),
                      ),
                    ),
                    color_v1: Color(0XFFF6921E),
                    title_v2: "Transfer",
                    subtitle_v2: Const.currencyFormatWithoutDecimal
                        .format(data[index].Transfer ?? 0),
                    trailing_v2: Container(
                      width: 95.w,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Status",
                              textAlign: TextAlign.start,
                              softWrap: true,
                              style:
                                  tileTextStyle(context: context, size: 10.sp)),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(data[index].Status.toString(),
                              textAlign: TextAlign.start,
                              softWrap: true,
                              style:
                                  tileTextStyle(context: context, size: 9.sp)),
                        ],
                      ),
                    ),
                    icon_v2: Center(
                      child: Container(
                        height: 20.h,
                        width: 20.w,
                        child:
                            SvgPicture.asset('assets/svg/total_transfer.svg'),
                      ),
                    ),
                    color_v2: Color(0xff254180)
                    //  Color(0xFF92298D),
                    ),
              ),
              if (index == data.length - 1) Container(height: 60)
            ],
          ),
        );
      }),
    );
  }

  tileTextStyle({required BuildContext context, double? size}) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
          fontSize: size ?? 14.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        );
  }
}
