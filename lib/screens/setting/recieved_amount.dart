import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:malikopal/bloc/dashboard_bloc.dart';
import 'package:malikopal/model/ReceivedAmountResponse.dart';
import 'package:malikopal/model/requestbody/ReceivedAmountReqBody.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/widgets/loading_dialog.dart';
import 'package:malikopal/utils/Const.dart';
import 'package:malikopal/utils/shared_pref.dart';
import 'package:malikopal/utils/utility.dart';

class RecievedAmount extends StatefulWidget {
  const RecievedAmount({Key? key, this.profileId}) : super(key: key);
  final int? profileId;

  @override
  State<RecievedAmount> createState() => _RecievedAmountState();
}

class _RecievedAmountState extends State<RecievedAmount> {
  int selected = 0;
  late DashboardBloc _bloc;
  ReceivedAmountResponseData? data;
  String Filter = "ALL";
  String DateStr = "";
  @override
  void initState() {
    _bloc = DashboardBloc();

    _bloc.ReceivedAmountStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();
        setState(() {
          data = event.data;
        });
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, event.message, true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });

    _bloc.GetReceivedAmountData(ReceivedAmountReqData(
        Filter: Filter, DateStr: DateStr, profileId: widget.profileId));

    super.initState();
  }

  DateTime selectedDate = DateTime.now();

  var myFormat = DateFormat('dd-MM-yyyy');

  Future<void> showDateTimePicker() async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2501),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.dark(
              primary: Color(0xff254180),
              //  Colors.purple,
              surface: Colors.grey.withOpacity(0.3),
              onPrimary: Colors.white,
              onSurface: Colors.black.withOpacity(0.5),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? Container(),
        );
      },
    );
    if (datePicked != null) {
      setState(() {
        selectedDate = datePicked;
      });
    }
  }

  bool darkTheme = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    SessionData().isDarkTheme().then((value) {
      setState(() {
        darkTheme = value;
        //print("Theme State : $darkTheme");
      });
    });

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: CustomTopBar(topbartitle: 'Recieved Amount'),
          ),
          Container(
            height: size.height / 20.h,
            width: size.width.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: isTablet() ? 3.w : 7.w,
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Member Since',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        SmallRadiusButton(
                          width: isTablet() ? 240 : 130,
                          text: DateFormat('d-MMM-y').format(DateTime.parse(
                              data?.MemberSince ?? DateTime.now().toString())),
                          textcolor: Colors.white,
                          //  darkTheme == true ? Colors.white : Colors.white,
                          color: darkTheme == false
                              ? [
                                  Color(0xff254180),
                                  Color(0xff254180)
                                  // Color(0xff92298D),
                                  // Color(0xff92298D)
                                  // Colors.black.withOpacity(0.4),
                                  // Colors.black.withOpacity(0.4),
                                ]
                              : [
                                  Color(0xff254180)
                                  // Color(0xff92298D)
                                  // Color(0xFF4D5050),
                                  // Color(0xFF4D5050),
                                ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              CustomTabBar(
                OnDateChanged: (DateTime? dt, String formatedDate) {
                  if (dt != null)
                    _bloc.GetReceivedAmountData(
                      ReceivedAmountReqData(
                          DateStr: DateFormat("dd-MM-yyyy").format(dt),
                          profileId: widget.profileId,
                          Filter: ""),
                    );
                },
                tab_length: 3,
                function: (int index) {
                  DateStr = '';
                  if (index == 0) {
                    Filter = "ALL";
                    setState(() {});
                  } else if (index == 1) {
                    DateTime dateTime = DateTime.now();

                    DateStr = "01-01-${dateTime.year}";
                    Filter = "1Y";
                    setState(() {});
                  } else if (index == 2) {
                    Filter = "2Y";
                    setState(() {});
                  }

                  _bloc.GetReceivedAmountData(ReceivedAmountReqData(
                      Filter: Filter,
                      DateStr: DateStr,
                      profileId: widget.profileId));
                },
                tabs: ["ALL", "1Y", "2Y"],
                child: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 6,
                    itemBuilder: ((context, index) {
                      // String Title = "Total Received";
                      String Amount = "0";
                      Widget child = Container();
                      Widget text = Text("");
                      if (index == 0) {
                        text = Text(
                          "Total Received",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF254180)
                                  //  Color(0xff92298D),
                                  ),
                        );
                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.TotalReceived ?? 0);
                        child = CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Color(0xff254180),
                          //  Colors.purple,
                          child: Center(
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              child: SvgPicture.asset(
                                "assets/svg/coins.svg",
                              ),
                            ),
                          ),
                        );
                      } else if (index == 1) {
                        text = Text(
                          "Withdraw capital",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange,
                                  ),
                        );
                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.WithdrawCapital ?? 0);
                        child = CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Colors.orange,
                          child: Center(
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              child: SvgPicture.asset(
                                "assets/svg/withdraw.svg",
                              ),
                            ),
                          ),
                        );
                      } else if (index == 2) {
                        text = Text(
                          "Transfer",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff254180),
                                    // Colors.purple,
                                  ),
                        );

                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.Transfer ?? 0);
                        child = CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Color(0xff254180),
                          // Colors.purple,
                          child: Center(
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              child: SvgPicture.asset(
                                "assets/svg/total_transfer.svg",
                              ),
                            ),
                          ),
                        );
                      } else if (index == 3) {
                        text = Text(
                          "Rollover",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange,
                                  ),
                        );

                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.Rollover ?? 0);
                        child = CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Colors.orange,
                          child: Center(
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              child: SvgPicture.asset(
                                "assets/svg/rollover.svg",
                              ),
                            ),
                          ),
                        );
                      } else if (index == 4) {
                        text = Text(
                          "F & F",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff254180),
                                    //  Color(0xff92298D),
                                  ),
                        );

                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.FandF ?? 0);
                        child = CircleAvatar(
                          backgroundColor: Colors.red, //Color(0xff92298D),
                          backgroundImage:
                              AssetImage("assets/images/FandF.png"),
                          child: Center(
                            child: Container(
                              height: 20,
                              width: 20,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 100,
                        );
                      }
                      return CustomSingleTile(
                          title: text,
                          subtitle: "Rs. " + Amount,
                          leading: child);
                    }),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: 6,
                    itemBuilder: ((context, index) {
                      // String Title = "Total Received";
                      String Amount = "0";
                      Widget child = Container();
                      Widget text = Text("");
                      if (index == 0) {
                        text = Text(
                          "Total Received",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff254180),
                                    //  Color(0xff92298D),
                                  ),
                        );
                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.TotalReceived ?? 0);
                        child = CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Color(0xff254180),
                          //  Colors.purple,
                          child: Center(
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              child: SvgPicture.asset(
                                "assets/svg/coins.svg",
                              ),
                            ),
                          ),
                        );
                      } else if (index == 1) {
                        text = Text(
                          "Withdraw capital",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange,
                                  ),
                        );
                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.WithdrawCapital ?? 0);
                        child = CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Colors.orange,
                          child: Center(
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              child: SvgPicture.asset(
                                "assets/svg/withdraw.svg",
                              ),
                            ),
                          ),
                        );
                      } else if (index == 2) {
                        text = Text(
                          "Transfer",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff254180),
                                    //  Colors.purple,
                                  ),
                        );

                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.Transfer ?? 0);
                        child = CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Color(0xff254180),
                          //  Colors.purple,
                          child: Center(
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              child: SvgPicture.asset(
                                "assets/svg/total_transfer.svg",
                              ),
                            ),
                          ),
                        );
                      } else if (index == 3) {
                        text = Text(
                          "Rollover",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange,
                                  ),
                        );

                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.Rollover ?? 0);
                        child = CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Colors.orange,
                          child: Center(
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              child: SvgPicture.asset(
                                "assets/svg/rollover.svg",
                              ),
                            ),
                          ),
                        );
                      } else if (index == 4) {
                        text = Text(
                          "F & F",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff254180),
                                    //  Color(0xff92298D),
                                  ),
                        );

                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.FandF ?? 0);
                        child = CircleAvatar(
                          backgroundColor: Colors.red, //Color(0xff92298D),
                          backgroundImage: AssetImage(
                            "assets/images/FandF.png",
                          ),
                          child: Center(
                            child: Container(
                              height: 20,
                              width: 20,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 100,
                        );
                      }
                      return CustomSingleTile(
                        title: text,
                        subtitle: "Rs. " + Amount,
                        leading: child,
                      );
                    }),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: 6,
                    itemBuilder: ((context, index) {
                      // String Title = "Total Received";
                      String Amount = "0";
                      Widget child = Container();
                      Widget text = Text("");
                      if (index == 0) {
                        text = Text(
                          "Total Received",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff254180),
                                    //  Color(0xff92298D),
                                  ),
                        );
                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.TotalReceived ?? 0);
                        child = CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Color(0xff254180),
                          // Color(0xff92298D),
                          child: Center(
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              child: SvgPicture.asset(
                                "assets/svg/coins.svg",
                              ),
                            ),
                          ),
                        );
                      } else if (index == 1) {
                        text = Text(
                          "Withdraw capital",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange,
                                  ),
                        );
                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.WithdrawCapital ?? 0);
                        child = CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Colors.orange,
                          child: Center(
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              child: SvgPicture.asset(
                                "assets/svg/withdraw.svg",
                              ),
                            ),
                          ),
                        );
                      } else if (index == 2) {
                        text = Text(
                          "Transfer",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff254180),
                                    //  Color(0xff92298D),
                                  ),
                        );

                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.Transfer ?? 0);
                        child = CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Color(0xff254180),
                          //  Color(0xff92298D),
                          child: Center(
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              child: SvgPicture.asset(
                                "assets/svg/total_transfer.svg",
                              ),
                            ),
                          ),
                        );
                      } else if (index == 3) {
                        text = Text(
                          "Rollover",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange,
                                  ),
                        );

                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.Rollover ?? 0);
                        child = CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Colors.orange,
                          child: Center(
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              child: SvgPicture.asset(
                                "assets/svg/rollover.svg",
                              ),
                            ),
                          ),
                        );
                      } else if (index == 4) {
                        text = Text(
                          "F & F",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff254180),
                                    //  Color(0xff92298D),
                                  ),
                        );

                        Amount = Const.currencyFormatWithoutDecimal
                            .format(data?.FandF ?? 0);
                        child = CircleAvatar(
                          backgroundColor: Colors.red, //Color(0xff92298D),
                          backgroundImage:
                              AssetImage("assets/images/FandF.png"),
                          child: Center(
                            child: Container(
                              height: 20,
                              width: 20,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 100,
                        );
                      }
                      return CustomSingleTile(
                          title: text,
                          subtitle: "Rs. " + Amount,
                          leading: child);
                    }),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
