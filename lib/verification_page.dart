import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:tournami/phone_login.dart';
import 'package:tournami/primary_button.dart';
import 'package:tournami/secondary_button.dart';
import 'package:tournami/text_controller.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({
    Key? key,
  }) : super(key: key);
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController otpController = TextEditingController();

  final loginForm = GlobalKey<FormState>();
  bool isClickedVerify = false;
  bool isValidate = false;
  String verificationID = '';
  String myriadReg = 'Myriad-Regular';
  String myriadSemiBold = 'Myriad-Semi-Bold';
  String myriadBold = 'Myriad-Bold';

  bool isStatusShowing = false;
  bool showErrorOTP = false;

  @override
  void initState() {
    PhoneAuthen().registerUser(TextController.loginCon.phone, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var paddingLeft = screenWidth * 0.154;
    var paddingRight = screenWidth * 0.154;

    var spaceBetweenHeader = screenHeight * 0.115;
    var spaceBetweenButton = screenHeight * 0.106;
    var spaceBetweenResend = screenHeight * 0.041;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop(context);
              //Navigator.of(context).pushNamedAndRemoveUntil("/welcome", (route) => false);
            }),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.only(bottom: 10),
          child: Form(
            key: loginForm,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildHeader(paddingLeft, screenHeight, context),
                SizedBox(
                  height: spaceBetweenHeader,
                ),
                buildOTPCode(paddingLeft, paddingRight, context),
                SizedBox(
                  height: spaceBetweenButton,
                ),
                buildVerifyButton(
                    isValidate,
                    screenHeight,
                    paddingLeft,
                    paddingRight,
                    screenWidth,
                    context,
                    verificationID,
                    myriadBold),
                SizedBox(
                  height: spaceBetweenResend,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildVerifyButton(
      bool isValidate,
      double screenHeight,
      double paddingLeft,
      double paddingRight,
      double screenWidth,
      BuildContext context,
      String verificationID,
      String fonts) {
    return isValidate
        ? Padding(
            padding: EdgeInsets.only(
              left: paddingLeft,
              right: paddingRight,
            ),
            child: PrimaryButton(
                height: 50,
                child: Text(
                  "Verify",
                  style: TextStyle(
                      fontFamily: fonts, color: Colors.white, fontSize: 16),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.green, Colors.greenAccent],
                ),
                onPressed: () async {
                  setState(() {
                    isClickedVerify = true;
                  });

                  if (loginForm.currentState!.validate()) {
                    loginForm.currentState!.save();
                    FirebaseAuth _auth = FirebaseAuth.instance;
                    var credential = PhoneAuthProvider.credential(
                      verificationId: TextController().verifications,
                      smsCode: otpController.text.trim(),
                    );

                    _auth
                        .signInWithCredential(credential)
                        .then((UserCredential result) async {
                      await result.user!.getIdToken().then((id) {
                        // TextController().setUserData(result.user.uid, id.token);
                        print("token is: " + id);
                      });

                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/home", (route) => false);
                    }).catchError((onError) {
                      print(onError);
                      if (!isStatusShowing) {
                        showStatusBar(context);
                      }
                    });
                  }
                }),
          )
        : Padding(
            padding: EdgeInsets.only(
              left: paddingLeft,
              right: paddingRight,
            ),
            child: SecondaryButton(
              height: 50,
              child: Text(
                "Verify",
                style: TextStyle(
                    fontFamily: fonts, color: Colors.black, fontSize: 16),
              ),
              bgColor: Colors.transparent,
              borderColor: Colors.black,
              onPressed: () {
                if (!isStatusShowing) {
                  showStatusBar(context);
                }
              },
            ),
          );
  }

  Flushbar showStatusBar(BuildContext context) {
    return Flushbar(
      isDismissible: false,
      backgroundColor: Colors.red,
      onStatusChanged: (FlushbarStatus? status) {
        if (status == FlushbarStatus.IS_APPEARING) {
          setState(() {
            isStatusShowing = true;
            showErrorOTP = true;
          });
        } else if (status == FlushbarStatus.IS_HIDING) {
          setState(() {
            isStatusShowing = false;
          });
        }
      },
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      animationDuration: Duration(milliseconds: 500),
      flushbarStyle: FlushbarStyle.GROUNDED,
      messageText: const Text(
        "OTP Error",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Myriad-regular',
          fontWeight: FontWeight.w700,
        ),
      ),
    )..show(context);
  }

  Widget buildHeader(
      double paddingLeft, double screenHeight, BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: paddingLeft,
            top: screenHeight * (180 / 812),
          ),
          child: Text(
            "Verification",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: myriadReg),
          ),
        ),
      ],
    );
  }

  Widget buildOTPCode(
      double paddingLeft, double paddingRight, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: paddingLeft,
        right: paddingRight,
      ),
      child: PinCodeTextField(
        onTap: () {
          if (otpController.text.isNotEmpty) {
            otpController.clear();
            if (showErrorOTP) {
              setState(() {
                showErrorOTP = false;
              });
            }
          }
        },
        length: 6,
        obscureText: false,
        animationType: AnimationType.none,
        keyboardType: TextInputType.number,
        textStyle: TextStyle(
            fontSize: 38,
            color: showErrorOTP ? Colors.red : Colors.black,
            fontWeight: FontWeight.w600),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          selectedColor: Colors.orange,
          inactiveColor: Colors.orange,
          activeColor: Colors.orange,
          // borderRadius: BorderRadius.circular(5),
          //fieldHeight: 50,
          // fieldWidth: 30,
          activeFillColor: Colors.transparent,
          inactiveFillColor: Colors.transparent,
          selectedFillColor: Colors.transparent,
        ),
        //animationDuration: Duration(milliseconds: 100),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        controller: otpController,
        onCompleted: (v) {},
        onChanged: (value) {
          setState(() {
            if (value.length < 6) {
              isValidate = false;
            } else {
              isValidate = true;
              showErrorOTP = false;
            }
          });
        },

        appContext: context,
      ),
    );
  }
}
