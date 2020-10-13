import 'package:MissingReport/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phNumber;
  String code;
  String smssent;
  String verificationId;
  String name;

  get verifiedSuccess => null;

  Future<void> verfiyPhone() async {
    String phoneNum = '+91' + phNumber;
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      this.verificationId = verId;
      smsCodeDialoge(context).then((value) {
        print("Code Sent");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess =
        (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential);
    };
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNum,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future<bool> smsCodeDialoge(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter OTP'),
            content: TextField(
              onChanged: (value) {
                this.smssent = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  var user = FirebaseAuth.instance.currentUser;
                  {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('/loginscreen');
                    } else {
                      Navigator.of(context).pop();
                      signIn(smssent);
                    }
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Navigator.of(context).pushNamed('/homescreen');
    }).catchError((e) {
      print(e);
    });
  }

  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bg.png'),
          ),
        ),
        child: Form(
          key: _loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, left: 30),
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
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                color: Colors.grey[300],
                child: TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.text,
                    cursorColor: Theme.of(context).primaryColor,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      setState(() {
                        this.name = value;
                      });
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: 'Name',
                      border: InputBorder.none,
                      labelStyle: TextStyle(fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.all(10),
                    )),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                color: Colors.grey[300],
                child: TextFormField(
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    cursorColor: Theme.of(context).primaryColor,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      setState(() {
                        this.phNumber = value;
                      });
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(fontWeight: FontWeight.normal),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    splashColor: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.of(context).pushNamed('/homescreen');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment.center,
                      width: 200,
                      child: ListTile(
                        onTap: () {
                          verfiyPhone();
                        },
                        title: Text(
                          'Proceed',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    splashColor: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.of(context).pushNamed('/homescreen');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment.center,
                      width: 200,
                      child: ListTile(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName,
                              arguments: name);
                        },
                        title: Text(
                          'skip',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
