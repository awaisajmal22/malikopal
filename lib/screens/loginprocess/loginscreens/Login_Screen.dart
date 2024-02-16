import 'package:flutter/foundation.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:malikopal/bloc/auth_bloc.dart';
import 'package:malikopal/model/auth_model/LoginData.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/screens/loginprocess/components/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/verification_method.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/widgets/GlowSetting.dart';
import 'package:malikopal/screens/widgets/back_alert.dart';
import 'package:malikopal/screens/widgets/loading_dialog.dart';
import 'package:malikopal/utils/shared_pref.dart';
import 'package:malikopal/utils/utility.dart';

import '../../../bloc/dashboard_bloc.dart';
import '../../../model/DashboardResponse.dart';
import 'forget_pass.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static const routeName = '/homepage-screen';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  //

  late AnimationController _controller;

  late Animation _colorAnim;

  bool ticked = true;

  late TextEditingController _usernametextcontroller;
  late TextEditingController _passwordtextcontroller;

  bool obsecure = true;

  late AuthBloc _bloc;
  FocusNode focusNode = FocusNode();
  late DashboardBloc _bloc2;

  DashboardResponseData? data;

  @override
  void initState() {
    // _bloc2 = DashboardBloc();

    _usernametextcontroller = TextEditingController();
    _passwordtextcontroller = TextEditingController();
    if (!kReleaseMode) {
      // _usernametextcontroller.text = "100016";
      _usernametextcontroller.text = "198506";
      _passwordtextcontroller.text = "malik1985";
      // _usernametextcontroller.text = "100137";
      // _passwordtextcontroller.text = "pakistan";

      // _usernametextcontroller.text = "100614";
      // _passwordtextcontroller.text = "pakistan";
    }
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )
      ..forward()
      ..repeat(reverse: true);

    _colorAnim = Tween(begin: 0.3, end: 0.6).animate(_controller);

    _bloc = AuthBloc();

    _bloc.loginResponseStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        // save user session & goto home

        var session = SessionData();

        String? token = event.data?.token;

        var check = token == null ? "" : token.toString();

        session.setUserSession(check).then((value) {
          //

          DialogBuilder(context).hideLoader();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => VerificationScreen(
                      skipOtp: event.data?.skipOtp ?? false)));

          //
        });
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, event.message, true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });

    //-----------------------

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   focusNode.requestFocus();
    // });

    super.initState();
  }

  @override
  void dispose() {
    _usernametextcontroller.dispose();
    _passwordtextcontroller.dispose();
    _controller.dispose();
    focusNode.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => OnExit().ExitApp(
          ctx: context,
          title: "Confirmation Dialog",
          content: "Do you want to Close Application"),
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            reverse: true,
            child: AnimatedBuilder(
                animation: _controller.view,
                builder: (context, child) {
                  return KeyboardVisibilityBuilder(builder: (context, visible) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: visible ? 80 : 12.0.h),
                      child: rootLayout(
                          context: context, data: new LoginFormData()),
                    );
                  });
                }),
          )),
    );
  }

  Widget rootLayout(
      {required LoginFormData data, required BuildContext context}) {
    Size size = MediaQuery.of(context).size;

    //userID
    final userID = TextField(
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 18.sp),
      autofocus: true,
      focusNode: focusNode,
      controller: _usernametextcontroller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        data.email = value;
      },
      decoration: InputDecoration(
        // errorText:
        //     "User ID must be grater then ${_usernametextcontroller.text.length}",
        hintText: "User ID",
        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16.sp,
              height: 1.6,
              fontWeight: FontWeight.w400,
              // color: Theme.of(context).hintColor,
            ),
        icon: Padding(
          padding: EdgeInsets.only(
              left: isTablet() ? size.width * 0.1.w : size.width * 0.2.w),
          child: Container(
            height: 22.h,
            width: 22.w,
            child: SvgPicture.asset(
              "assets/svg/user.svg",
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        border: InputBorder.none,
      ),
    );

    final password = GestureDetector(
        onTap: () => focusNode.requestFocus(),
        child: TextField(
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18.sp),
          // focusNode: focusNode,
          controller: _passwordtextcontroller,
          obscureText: obsecure,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            data.password = value;
          },
          decoration: InputDecoration(
            // errorText: validatePassword(_passwordtextcontroller.text),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecure = !obsecure;
                    print("Visibility : $obsecure");
                  });
                },
                icon: Icon(
                  obsecure
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye,
                  size: 24,
                  color: Theme.of(context).dividerColor,
                )),
            hintText: "Password",
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16.sp,
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                  // color: Theme.of(context).hintColor,
                ),
            icon: Padding(
              padding: EdgeInsets.only(
                  left: isTablet()
                      ? size.width * 0.1.w
                      : _passwordtextcontroller.text.length > 8
                          ? size.width * 0.05
                          : size.width * 0.2.w),
              child: _passwordtextcontroller.text.length > 8
                  ? SizedBox.shrink()
                  : Container(
                      height: 24.h,
                      width: 24.w,
                      child: SvgPicture.asset(
                        "assets/svg/password.svg",
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
            ),
            border: InputBorder.none,
          ),
        ));

    return AnimatedBuilder(
        animation: _colorAnim,
        builder: (context, child) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            margin: EdgeInsets.only(top: 50.h),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70.h,
                ),
                GlowSetting(
                  color: Color(0xff1164AA).withOpacity(0.1),
                  color1: Color(0xff1164AA).withOpacity(0.7),
                  radius: size.height < 700 ? 150 : 170,
                  child: Container(
                    height: 75.h,
                    width: 75.h,
                    child: Image.asset(
                      "assets/svg/capital.png",
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1.h,
                ),
                CustomTextField(context, userID),
                SizedBox(
                  height: 35.h,
                ),
                CustomTextField(context, password),
                SizedBox(
                  height: 35.h,
                ),
                SignedIntext(
                  checkbox: Container(
                    height: 22.h,
                    width: 22.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).dividerColor, width: 2.0.w),
                    ),
                    child: Checkbox(
                        fillColor: MaterialStateProperty.all(
                            Theme.of(context).backgroundColor),
                        shape: CircleBorder(),
                        checkColor: Theme.of(context).dividerColor,
                        value: ticked,
                        onChanged: (Checked) {
                          setState(() {
                            ticked = Checked!;
                            print(
                              "keep me login checked $ticked \t ",
                            );
                          });
                        }),
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                GestureDetector(
                  onTap: () async {
                    PackageInfo packageInfo = await PackageInfo.fromPlatform();
                    data = LoginFormData(
                        email: _usernametextcontroller.text,
                        password: _passwordtextcontroller.text,
                        Version: packageInfo.buildNumber);
                    if (data.email.isEmpty) {
                      showSnackBar(context, 'Username may not be empty.', true);
                      return;
                    }
                    if (data.password.isEmpty) {
                      showSnackBar(context, 'Password may not be empty.', true);
                      return;
                    }
                    focusNode.unfocus();

                    _bloc.postLoginFormData(data);
                  },
                  child: CustomButton(
                    title: 'SIGN IN',
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgetPsswordScreen.routeName);
                  },
                  child: Text(
                    'Forgot Password?',
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat',
                        fontSize: 18.sp),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          );
        });
  }

  Widget CustomTextField(BuildContext context, Widget textfield) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 60,
      width: size.width * 0.83.w,
      child: Neumorphic(
        style: NeumorphicStyle(
          lightSource: LightSource.topLeft,
          disableDepth: false,
          shadowLightColorEmboss: Theme.of(context).cardColor,
          shadowDarkColorEmboss: Color.fromARGB(255, 182, 182, 182),
          depth: -3,
          color: Theme.of(context).cardColor,
          intensity: 0.9,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(100)),
        ),
        child: Center(
          child: textfield,
        ),
      ),
    );
  }

  String validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return "";
  }

  Widget SignedIntext({required Widget checkbox}) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            checkbox,
            SizedBox(width: 12.w),
            Text(
              'Keep me Signed',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 18.sp,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    // color: Colors.black,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
