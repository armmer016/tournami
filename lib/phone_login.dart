import 'package:firebase_auth/firebase_auth.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tournami/text_controller.dart';


class PhoneAuthen {
  static String formatPhoneNumber(String phone) {
    // print('format');
    int length = phone.length;
    String format = '';
    if (!phone.contains('-') && length == 10) {
      // print('10');
      if (phone.substring(1, 2) == '6') {
        // print('6');
        format = phone.substring(0, 2) + '-' + phone.substring(2, 6) + '-' + phone.substring(6, 10);
      } else {
        format = phone.substring(0, 3) + '-' + phone.substring(3, 6) + '-' + phone.substring(6, 10);
      }
      return format;
    } else {
      return phone;
    }
  }

  Future registerUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    print(phone);
    phone = '+66' + phone.substring(1);
    phone = phone.replaceAll('-', '');
    print(phone);
    _auth
        .verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 35),
      verificationCompleted: (AuthCredential authCredential) {
        print('verification complete');
      },
      verificationFailed: (FirebaseAuthException authException) {
        print("ERRORRR!!!" + authException.message! );
      },
      codeSent: (String verificationID, int? forceResendingToken) {
        print("-- verification --");
        TextController().setVeri(verificationID);
        print("code sent");
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        print(verificationID);
        print('Time OUT');
      },

    )
        .catchError((e) {
      print('error: ' + e);
    });
  }

  // Future verify(TextEditingController controller, String verificationID, BuildContext context, String state) async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;

  //   var smsCode = controller.text.trim();
  //   var credential = PhoneAuthProvider.getCredential(
  //     verificationId: verificationID,
  //     smsCode: smsCode,
  //   );

  //   _auth.signInWithCredential(credential).then((AuthResult result) async {
  //     await result.user.getIdToken().then((id) {
  //       TextController().setUserData(result.user.uid, id.token);
  //       print("token: " + id.token);
  //     });
  //     if (state == "First time to join") {
  //       Navigator.of(context).pushNamedAndRemoveUntil("/pdpa", (route) => false);
  //     } else if (state == "Login") {
  //       Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
  //     }
  //   }).catchError((onError) {
  //     print('onError: ' + onError);
  //   });
  // }
}
