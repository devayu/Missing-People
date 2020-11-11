import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginscreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNumber, verificationId;
  String otp, authStatus = "";
  String userName;

  Future<void> verifyPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {
        setState(() {
          authStatus = "Your account is successfully verified";
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        print(authException);
        setState(() {
          authStatus = "Authentication failed";
        });
      },
      codeSent: (String verId, [int forceCodeResent]) {
        verificationId = verId;
        setState(() {
          authStatus = "OTP has been successfully send";
        });
        otpDialogBox(context).then((value) {});
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
      },
    );
  }

  otpDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Enter your OTP'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300]),
                child: TextFormField(
                  obscureText: true,
                  maxLength: 6,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20, right: 20)),
                  onChanged: (value) {
                    otp = value;
                  },
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel', style: TextStyle(color: Colors.red)),
              ),
              FlatButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                  signIn(otp);
                },
                child: Text(
                  'Submit',
                ),
              ),
            ],
          );
        });
  }

  Future<void> signIn(String otp) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    ));
    User user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushNamed(context, HomeScreen.routeName, arguments: userName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(1), BlendMode.dstATop),
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bg.png'),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 30,
                  ),
                  child: Text(
                    'WELCOME',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Hexcolor('#0677BD')),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 35),
                  child: Text(
                    'SIGN IN TO CONTINUE',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          hintStyle: new TextStyle(color: Colors.white24),
                          hintText: "Enter Your Name",
                          fillColor: Colors.white70),
                      onChanged: (value) {
                        this.userName = value;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.phone_iphone,
                            color: Colors.white,
                          ),
                          hintStyle: new TextStyle(color: Colors.white24),
                          hintText: "Enter Your Phone Number",
                          fillColor: Colors.white),
                      onChanged: (value) {
                        phoneNumber = "+91" + value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      phoneNumber == null ? null : verifyPhoneNumber(context);
                    },
                    child: Text(
                      "Generate OTP",
                      style: TextStyle(color: Colors.white),
                    ),
                    elevation: 7.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                // Align(
                //   alignment: Alignment.center,
                //   child: RaisedButton(
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(30)),
                //     onPressed: () {
                //       if (userName == null) {
                //         AlertDialog(
                //           title: Text('Name cannot be empty'),
                //         );
                //       } else {
                //         Navigator.pushNamed(context, HomeScreen.routeName,
                //             arguments: userName);
                //       }
                //     },
                //     child: Text(
                //       "Skip",
                //       style: TextStyle(color: Colors.white),
                //     ),
                //     elevation: 7.0,
                //     color: Theme.of(context).primaryColor,
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    authStatus == "" ? "" : authStatus,
                    style: TextStyle(
                        color: authStatus.contains("fail") ||
                                authStatus.contains("TIMEOUT")
                            ? Colors.red
                            : Colors.green),
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
