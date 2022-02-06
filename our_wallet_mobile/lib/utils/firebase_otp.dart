import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/pages/auth/auth_otp.dart';
import 'package:our_wallet_mobile/widgets/snackbar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

validaatePhoneNumber(String value) {
  String pattern = r'(^(?:[+0])?[0-9]{10,12}$)';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return 'Masukan nomor telpon anda dengan benar';
  }
  return null;
}

String replaceCharAt(String oldString, int index, String newChar) {
  return oldString.substring(0, index) +
      newChar +
      oldString.substring(index + 1);
}

String makePhoneNumber(String phone) {
  if (phone[0] == '0') {
    return replaceCharAt(phone, 0, '+62');
  } else if (phone[0] == '+') {
    return phone;
  } else {
    return '+62$phone';
  }
}

Future<void> sendOtp(
  String phone,
  String opsi,
  bool isResend,
  BuildContext context,
  Function onSend,
  Function onError,
) async {
  String phoneNumber = makePhoneNumber(phone);
  try {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (verificationFailed) async {
        final snackBar =
            snackBarAlert('error', '${verificationFailed.message}');
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        onError();
      },
      codeSent: (verificationId, resendingToken) async {
        if (isResend) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => AuthOTP(
              phonenumber: phone,
              option: opsi,
              verificationId: verificationId,
            ),
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AuthOTP(
              phonenumber: phone,
              option: opsi,
              verificationId: verificationId,
            ),
          ));
        }
        onSend();
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        onSend();
      },
      timeout: const Duration(seconds: 5),
    );
  } catch (e) {
    final snackBar = snackBarAlert('error', '${e.toString()}');
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    onError();
  }
}

Future verifyPin(
  String pin,
  String verId,
) async {
  PhoneAuthCredential credential =
      PhoneAuthProvider.credential(verificationId: verId, smsCode: pin);
  try {
    await FirebaseAuth.instance.signInWithCredential(credential);
    return {
      'status': true,
      'message': 'pin otp benar',
    };
  } on FirebaseAuthException catch (e) {
    return {
      'status': false,
      'message': e.message,
    };
  }
}
