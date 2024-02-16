import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../ScopedModelWrapper.dart';
import '../../../model/DashboardResponse.dart';
import '../../../utils/shared_pref.dart';
import '../../setting/components/setting.widgets.dart';
import '../custom.widgets/custom_widgets.dart';
import 'closingPayment.dart';

class Transectiondetailwidget extends StatefulWidget {
  Transectiondetailwidget(
      {Key? key,
      // this.userID,
      // required this.date,
      this.description2,
      this.isClosingSheet = false,
      this.urduDescription4,
      this.description3,
      this.amountTitle,
      this.daterich,
      this.description1,
      this.paymentTypekey,
      this.paymentTypevalue,
      this.amountTypevalue,
      // this.rolloveramount,
      required this.onPressed,
      required this.color1,
      required this.Title,
      this.urduDescription1,
      this.urduDescription2,
      this.urduDescription3,
      required this.DateStr,
      this.description4,
      required this.color2})
      : super(key: key);
  // final String? userID;
  // final String date;
  final String? paymentTypekey;
  final String? daterich;
  final String? amountTitle;
  final String? description1;
  final String? description4;
  final String? description2;
  final String? description3;
  final String? urduDescription1;
  final String? urduDescription2;
  final String? urduDescription3;
  final String? urduDescription4;
  final Color color1;
  final bool isClosingSheet;
  final Color color2;
  final amountTypevalue;
  // final String? rolloveramount;

  final paymentTypevalue;
  final VoidCallback onPressed;
  final String Title;
  final String DateStr;

  @override
  State<Transectiondetailwidget> createState() =>
      _TransectiondetailwidgetState();
}

class _TransectiondetailwidgetState extends State<Transectiondetailwidget> {
  late DashboardResponseData Userdata = DashboardResponseData(
      isClosingDays: false,
      IsRefrenceInAllowed: false,
      IsShowDataAllowed: false,
      IsShowListAllowed: false,
      IsSubReferenceAllowed: false);

  @override
  void initState() {
    // Userdata = DashboardResponseData();
    super.initState();
    SessionData().getUserProfile().then(
          (value) => setState(() {
            print(value.toJson());
            Userdata = value;
          }),
        );
  }

  // var Date = DateTime.now().toString().substring(0, 10);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant<AppModel>(builder: (context, _, dataModel) {
        return Scaffold(
          backgroundColor: dataModel.isDarkTheme ? Color(0xFF2A2D2E) : Color(0xFFF1F1F2),
            body: WillPopScope(
          onWillPop: () async {
            widget.onPressed();
            return true;
          },
          child: ScopedModelDescendant<AppModel>(builder: (context, _, model) {
            return SafeArea(
              
              child: Container(
                // color: Color(0xFFF1F1F2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      // color: Color(0xFF7F3F97),
                      padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                      child: Text(
                        "",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Color(0xFFFFF100)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(08),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dialogBackgroundColor,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 66.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color:Color(0xff1164AA),
                                //  Color(0xff92298D),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(28),
                                    topRight: Radius.circular(28))),
                            child: Center(
                              child: Text(
                                widget
                                    .Title, //"Rollover Request has been Processed",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Color(0xFFFFF100),
                                        fontFamily: "Montserrat",
                                        fontSize: 17.6.sp,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          // ),
                          // ),
                          Padding(
                            padding: EdgeInsets.all(19.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.amountTypevalue != null)
                                  Column(children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 07,
                                          child: Container(
                                            width: size.width * 0.4,
                                            child: Text(
                                              widget.amountTitle!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: model.isDarkTheme
                                                          ? Colors.white
                                                          : Color(0xff254180),
                                                          // Color(0xFF92298D),
                                                      fontSize: 14.8.sp,
                                                      fontFamily: "Montserrat",
                                                      fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        // Flexible(
                                        //   flex: 03,
                                        //   child: Container(
                                        //       width: size.width * 0.4,
                                        //       child: Text(
                                        //         Userdata.UserName.toString(),
                                        //         textAlign: TextAlign.start,
                                        //         style: Theme.of(context)
                                        //             .textTheme
                                        //             .bodySmall!
                                        //             .copyWith(
                                        //                 fontSize: 14.sp,
                                        //                 fontFamily: "Montserrat",
                                        //                 fontWeight: FontWeight.w500),
                                        //       )),
                                        // )
                                      ],
                                    ),
                                    SizedBox(height: 18.sp),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 2.5.h),
                                          child: Text(
                                            "Rs.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  height: 1.8,
                                                  fontSize: 16.sp,
                                                  // height: 2.0.h,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Montserrat",
                                                  color: model.isDarkTheme
                                                      ? Colors.white
                                                      : Color(0xFF606060),
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.h,
                                        ),
                                        Text(
                                          widget.amountTypevalue ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                fontSize: 33.4.sp,
                                                fontFamily: "Montserrat",
                                                fontWeight:
                                                    widget.isClosingSheet == true
                                                        ? FontWeight.w400
                                                        : FontWeight.w500,
                                                color: model.isDarkTheme
                                                    ? Colors.white
                                                    : Color(0xFF606060),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 18.5.h,
                                    bottom: 18.5.h,
                                    left: 9.5.h,
                                    right: 9.5.h,
                                  ),
                                  child: RichText(
                                      // textAlign: TextAlign.justify,
                                      text: TextSpan(
                                          // style: Theme.of(context)
                                          //     .textTheme
                                          //     .bodyMedium
                                          //     ?.copyWith(
                                          //         fontFamily: "Montserrat",
                                          //         fontSize: 13.sp,
                                          //         // wordSpacing: 1.h,
                                          //         fontWeight: FontWeight.w400,
                                          //         color: Color(0xFF606060)),
                                          // text: widget.description1 ?? '',
                                          children: [
                                        TextSpan(
                                          text: widget.description1 ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13.6.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: model.isDarkTheme
                                                      ? Colors.white
                                                      : Color(0xFF606060)),
                                        ),
                                        TextSpan(
                                          text: widget.description2 ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13.6.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: model.isDarkTheme
                                                      ? Colors.white
                                                      : Color(0xff254180)),
                                                      // Color(0xFF92298D)),
                                        ),
                                        TextSpan(
                                          text: widget.description3 ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13.6.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: model.isDarkTheme
                                                      ? Colors.white
                                                      : Color(0xFF606060)),
                                        ),
                                        if (widget.daterich != "")
                                          TextSpan(
                                            text: widget.daterich ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                  fontSize: 13.6
                                                      .sp, // Adjust the font size of the superscript
                                                  fontWeight: FontWeight.w400,
                                                  color: model.isDarkTheme
                                                      ? Colors.white
                                                      : Color(0xFF606060),
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                ),
                                          ),
                                        TextSpan(
                                          text: widget.description4 ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: model.isDarkTheme
                                                      ? Colors.white
                                                      : Color(0xFF606060)),
                                        )
                                      ])),
                                ),
                                Center(
                                  child: widget.isClosingSheet == true
                                      ? SvgPicture.asset(
                                          widget.urduDescription1 ?? '',
                                          height: 66.h,
                                          color: model.isDarkTheme
                                              ? Colors.white
                                              : Color(0xff254180),
                                              // Color(0xFF92298D),
                                        )
                                      : SvgPicture.asset(
                                          widget.urduDescription1 ?? '',
                                          color: model.isDarkTheme
                                              ? Colors.white
                                              : Color(0xff254180),
                                              //  Color(0xFF92298D),
                                        ),
                                ),

                                widget.paymentTypevalue == null
                                    ? SizedBox.shrink()
                                    : Container(
                                        height: 28.h,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: model.isDarkTheme
                                                  ? Colors.white
                                                  : Color(0xFFA6A8AB),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                if (widget.paymentTypevalue != null)
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 23.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FittedBox(
                                            // flex: 03,
                                            // fit: FlexFit.tight,
                                            child: Text(
                                              widget.paymentTypekey.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 16.sp,
                                                      color: model.isDarkTheme
                                                          ? Colors.white
                                                          : Color(0xff254180),
                                                          //  Color(0xFF92298D),
                                                      fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 05,
                                            child: Text(
                                              widget.paymentTypevalue ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 24.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color: model.isDarkTheme
                                                          ? Colors.white
                                                          : Color(0xFF606060)
                                                      // height: 1.8
                                                      ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),

                                // if (widget.amountTypevalue != null)
                                //   Container(
                                //     height: 28.h,
                                //     decoration: BoxDecoration(
                                //       border: Border(
                                //         bottom: BorderSide(
                                //           color: Color(0xFFA6A8AB),
                                //           width: 1,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // if (widget.amountTypevalue != null)
                                //   Column(
                                //     children: [
                                //       SizedBox(
                                //         height: 23.h,
                                //       ),
                                //       Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           FittedBox(
                                //             // flex: 03,
                                //             // fit: FlexFit.tight,
                                //             child: Text(
                                //               "Rollover",
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .bodySmall!
                                //                   .copyWith(
                                //                       fontFamily: "Montserrat",
                                //                       fontSize: 16.sp,
                                //                       color: Color(0xff92298D),
                                //                       fontWeight: FontWeight.w400),
                                //             ),
                                //           ),
                                //           Flexible(
                                //             flex: 05,
                                //             child: Text(
                                //               widget.amountTypevalue ?? '',
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .bodySmall!
                                //                   .copyWith(
                                //                     fontFamily: "Montserrat",
                                //                     fontSize: 24.sp,
                                //                     fontWeight: FontWeight.w400,
                                //                     // height: 1.8
                                //                   ),
                                //             ),
                                //           )
                                //         ],
                                //       ),
                                //     ],
                                //   ),
                                Container(
                                  height: 28.h,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: model.isDarkTheme
                                            ? Colors.white
                                            : Color(0xFFA6A8AB),
                                        width: 1, // Set the border width
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 18.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      // flex: 6,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        width: size.width * 0.4,
                                        child: Text(
                                          "Date ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: model.isDarkTheme
                                                      ? Colors.white
                                                      : Color(0xFF606060),
                                                  fontFamily: "Montserrat",
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      // flex: 03,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        width: size.width * 0.4,
                                        child: Text(
                                          // '',
                                          DateFormat('d-MMM-y').format(
                                              DateTime.parse(widget.DateStr)),
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontFamily: "Montserrat",
                                                fontSize: 17.h,
                                                color: model.isDarkTheme
                                                    ? Colors.white
                                                    : Color(0xFF606060),
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 18.h,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: model.isDarkTheme
                                            ? Colors.white
                                            : Color(
                                                0xFFA6A8AB), // Set your desired border color
                                        width: 1, // Set the border width
                                      ),
                                    ),
                                  ),
                                ),

                                // Padding(
                                //   padding: EdgeInsets.symmetric(
                                //       horizontal: 28.0.w, vertical: 12.h),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text(
                                //         '',
                                //         // widget.amountTitle.toString(),
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .bodyText1!
                                //             .copyWith(
                                //                 fontFamily: "Montserrat",
                                //                 fontSize: 16.sp,
                                //                 fontWeight: FontWeight.w500),
                                //       ),
                                //       SizedBox(
                                //         height: 10.sp,
                                //       )
                                //     ],
                                //   ),
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Text(
                                //       "Rs. ",
                                //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                //             fontFamily: "Montserrat",
                                //             fontSize: 18.sp,
                                //             height: 2,
                                //             fontWeight: FontWeight.w500,
                                //           ),
                                //     ),
                                //     Text(
                                //       '',
                                //       // widget.amountTypevalue.toString(),
                                //       style: Theme.of(context).textTheme.headline5!.copyWith(
                                //             fontSize: 28.sp,
                                //             fontFamily: "Montserrat",
                                //             fontWeight: FontWeight.w500,
                                //           ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(height: 37.h),
                                Center(
                                  child: AnimatedLongButton(
                                    height: isTablet() ? 100.h : 56.6.h,
                                    onPressed: () => widget.onPressed(),
                                    text: "CLOSE",
                                    textColor: Colors.white,
                                    topPadding: 5,
                                    bottomPadding: 5,
                                    rightPadding: 0,
                                    leftPadding: 0,
                                    fontsize: 16.3.sp,
                                    borderRadius: 13,
                                    color: [widget.color1, widget.color2],
                                    isBgColorWhite: false,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 20.h,
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
      }
    );
  }

  Divider divider() {
    return Divider(
      indent: 25,
      endIndent: 25,
      color: Colors.grey.withOpacity(0.5),
      thickness: 2,
      height: 1,
    );
  }
}
