import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tournami/phone_login.dart';
import 'package:tournami/primary_button.dart';
import 'package:tournami/text_controller.dart';

import 'error_dialog.dart';

class LoginPage extends StatefulWidget {
  final bool canPop;
  LoginPage({this.canPop = true});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String myriadReg = 'Myriad-Regular';
  String myriadSemiBold = 'Myriad-Semi-Bold';
  String myriadBold = 'Myriad-Bold';

  String tempPhone = '';

  final loginForm = GlobalKey<FormState>();
  bool isClickedSignIn = false;
  bool isValidate = false;
  bool isFormatted = false;
  TextController con = TextController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    phoneController.text.replaceAll('-', '').length == 10
        ? isValidate = true
        : isValidate = false;
    //con.phoneController.addListener(changesOnField);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double paddingLeft = screenWidth * 0.154;
    double paddingRight = screenWidth * 0.154;

    double spaceBetweenForm = screenHeight * 0.106;
    double spaceBetweenButton = screenHeight * 0.031;

    double buttonHeight = 50.0;
    double spaceBetweenHeader = screenHeight * 0.076;
    double spaceHeader = screenHeight * 0.221;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          //print(con.phoneController.text);
          phoneController.text =
              PhoneAuthen.formatPhoneNumber(phoneController.text);
        },
        child: SingleChildScrollView(
          reverse: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 10),
          child: Form(
            onChanged: () {
              if (phoneController.text.replaceAll('-', '').length == 10) {
                //con.phoneController.removeListener(changesOnField);
                setState(() {
                  isValidate = true;
                  phoneController.text =
                      PhoneAuthen.formatPhoneNumber(phoneController.text);
                });
              }
              if (phoneController.text.replaceAll('-', '').length <= 9) {
                setState(() {
                  isValidate = false;
                  isClickedSignIn = true;
                  //loginForm.currentState.validate();
                });
              }

              //tempPhone = con.phoneController.text.replaceAll('-', '');
            },
            key: loginForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildHeader(paddingLeft, spaceHeader, context),
                buildPhoneForm(paddingLeft, spaceBetweenHeader, paddingRight,
                    context, FocusNode()),
                SizedBox(
                  height: spaceBetweenForm,
                ),
                buildSignInButton(buttonHeight, paddingLeft, paddingRight,
                    context, myriadBold),
                SizedBox(
                  height: spaceBetweenButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildSignInButton(double buttonHeight, double paddingLeft,
      double paddingRight, BuildContext context, String fonts) {
    return Padding(
      padding: EdgeInsets.only(
        left: paddingLeft,
        right: paddingRight,
      ),
      child: PrimaryButton(
          height: buttonHeight,
          child: Text(
            "Request OTP",
            style:
                TextStyle(fontFamily: fonts, color: Colors.white, fontSize: 16),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.green,
              Colors.greenAccent,
            ],
          ),
          onPressed: () {
            print(phoneController.text);
            // isClickedSignIn = true;
            if (loginForm.currentState!.validate() &&
                phoneController.text.replaceAll('-', '').length == 10) {
              loginForm.currentState!.save();

              con.setPhone(phoneController.text.replaceAll('-', ''));
              // con.phoneController.clear();
              // AppSingleton.hideKeyboard(context);
              Navigator.of(context).pushNamed(
                "/verification",
              );
            } else {
              showDialog(
                context: context,
                builder: (_) => new ErrorDialog(
                  title: "Check your phone number",
                  detail: "Format not correct",
                ),
              );
            }
          }),
    );
  }

  Widget buildPhoneForm(double paddingLeft, double spaceBetweenHeader,
      double paddingRight, BuildContext context, FocusNode focus) {
    return Container(
      padding: EdgeInsets.only(
        left: paddingLeft,
        top: spaceBetweenHeader,
        right: paddingRight,
      ),
      child: TextField(
        decoration: const InputDecoration(
            labelText: "Phone number",
            labelStyle: TextStyle(color: Colors.green)),
        controller: phoneController,
        keyboardType: TextInputType.number,
        focusNode: focus,
      ),
    );
  }

  Widget buildHeader(
      double paddingLeft, double spaceHeader, BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: paddingLeft,
            top: spaceHeader,
          ),
          child: Text(
            "Login",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: myriadBold),
          ),
        ),
      ],
    );
  }
}
