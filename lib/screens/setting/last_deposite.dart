import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malikopal/model/requestbody/HistoryReqBody.dart';
import 'package:malikopal/repositories/DashboardRepository.dart';
import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/widgets/GlowSetting.dart';
import 'package:malikopal/utils/Const.dart';

import '../../model/last_deposit_data.dart';

class LastDepositeScreen extends StatefulWidget {
  const LastDepositeScreen({Key? key}) : super(key: key);

  @override
  State<LastDepositeScreen> createState() => _LastDepositeScreenState();
}

class _LastDepositeScreenState extends State<LastDepositeScreen> {
  //late TextEditingController _searchtextcontroller;

  int pno = 0;
  // late DashboardBloc _bloc;
  List<Datum>? data;
  String Filter = "ALL";
  int totalCredit = 0;
  String LastDate = "";
  DashboardRepository repository = DashboardRepository();
  @override
  void initState() {
    getLastData(HistoryReqData(duration: Filter, pno: pno));
    // _bloc = DashboardBloc();
    // _bloc.CapitalHistoryStream.listen((event) {
    //   if (event.status == Status.COMPLETED) {
    //     DialogBuilder(context).hideLoader();
    //     setState(() {
    //       // data = event.data;
    //       // LastDate = data?.history?.first.dateStr ?? "";
    //       // totalCredit = data?.history?.first.credit?.toDouble() ?? 0;
    //       // data?.forEach((element) {
    //       //   totalCredit += (element.Credit ?? 0);
    //       // });
    //     });
    //   } else if (event.status == Status.ERROR) {
    //     DialogBuilder(context).hideLoader();
    //     showSnackBar(context, event.message, true);
    //   } else if (event.status == Status.LOADING) {
    //     DialogBuilder(context).showLoader();
    //   }
    // });

    // _bloc.GetLastAddedAmountyData(HistoryReqData(duration: Filter, pno: pno));

    super.initState();
  }

  getLastData(HistoryReqData data1) async {
    HistoryReqBody reqBody = HistoryReqBody(data: data1);

    repository.GetLastAddedAmountyDataNew(reqBody).then((event) {
      if (event?.data != null) {
        setState(() {
          data = event?.data;

          if (data != null && data!.length > 0) {
            LastDate = data?.first.dateStr ?? "";
            totalCredit = data?.first.credit?.toInt() ?? 0;
          }

          // data?.forEach((element) {
          //   totalCredit += (element.Credit ?? 0);
          // });
        });
      }
    });

    setState(() {});
  }

  @override
  void dispose() {
    //_searchtextcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: AnimatedBottomBar(),
        body: SafeArea(
          child: Container(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 01,
                  child: CustomTopBar(topbartitle: "Last Deposit"),
                ),
                Flexible(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.all(12.0.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(
                          flex: 3,
                        ),
                        GlowSetting(
                          color: Color.fromARGB(255, 90, 152, 190)
                              .withOpacity(0.1),
                          color1: Color.fromARGB(255, 68, 182, 223)
                              .withOpacity(0.7),
                          radius: size.height < 700 ? 155 : 180,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Rs.  ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: Const.currencyFormatWithoutDecimal
                                      .format(totalCredit),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Center(
                          child: Text(
                            LastDate.isNotEmpty ? LastDate : "---",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
