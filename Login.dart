import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/Event.dart';
import 'CourseBloc.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController phoneNo = TextEditingController();
  TextEditingController code = TextEditingController();
  bool otp = false, loader = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  late String  verificationId;

  test() {
    print("////////////////");
    final queryParameters = {
      'page': "1",
      'limit': "5",
    };
    Firebase.initializeApp().whenComplete(() async {
      final tokenResult = await FirebaseAuth.instance.currentUser!;
      final idToken = await tokenResult.getIdToken();
       http.get(
          Uri.http("192.168.1.3:4000", "/courses", queryParameters),
          headers: {"Authorization" : "Bearer ${idToken.characters}"}
      ).then((response) {
       print(response.body);
       }
       );
    }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    Bloc<dynamic, dynamic> bloc = BlocProvider.of<Bloc>(context);
    bloc.add(FetchEvent());
    super.initState();
  }

  void signIn(var phoneAuthCredential) async {
    setState(() {
      loader = true;
    });
    try {
      final authCredential =  await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      setState(() {
        loader = false;
      });
      if(authCredential.user != null){
        final tokenResult = await FirebaseAuth.instance.currentUser!;
        final idToken = await tokenResult.getIdToken();
        final token = idToken.characters;
        print(token);
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        await http.post(
            Uri.parse("http://192.168.1.8:4000/users/register"),
            headers: {"Authorization": "Bearer $token"},
            body: {"deviceId": "${androidInfo.androidId}"}
        ).then((response) {
          print(response.statusCode);
          if(response.statusCode == 200){
            SharedPreferences.getInstance().then((prefs) {
              prefs.setString("userid","User");
            });
          }
        });
      }
    } on Exception catch (e) {
      setState(() {
        loader = false;
      });
      SnackBar(content: Text(e.toString()));
    }
  }

  login() async{
    await  FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${phoneNo.text}",
        timeout: Duration(seconds: 100),
        verificationCompleted: (AuthCredential cred) async{
          setState(() {loader = false;});
          signIn(cred);
        },
        verificationFailed: (Exception error) async{
          setState(() {
            loader = false;
          });
          SnackBar(content: Text(error.toString()));
        },
        codeSent: (verificationId, [forceResendingToken]) async{
          this.verificationId = verificationId;
          otp ? Container() : setState(() {
            loader = false;
            otp = true;
          });
        },
        codeAutoRetrievalTimeout: (error) async{
          SnackBar(content: Text(error));
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
        children: [
          WillPopScope(
            onWillPop: () async{
              if(otp){
                setState(() {
                  otp = false;
                });
              }
              return false;
            },
            child: Scaffold( // add Will pop Scope
              body: Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      width: width,
                      height: height * 284/896,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xff64a73a),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome to",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 36, fontFamily: "Quicksand"),
                          ),
                          SizedBox(height: height * 20/896,),
                          Text(
                            "Yog Sutra",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 48, fontFamily: "Quicksand"),
                          )
                        ],
                      )
                  ),
                  SizedBox(height: 34,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(otp ? "Enter OTP" : "Enter Phone Number",
                        style:TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w400,
                          fontSize: 20/411 * width,
                          color: Colors.black,),),
                      Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Color(0xffF5F3F3),
                              ),
                              width: 326/411 * width,
                              height: 59/411 * width,
                              alignment: Alignment.bottomCenter,
                            ),
                            Container(
                              color: Colors.transparent,
                              width: 326/411 * width,
                              height: 110/411 * width,
                              alignment: Alignment.bottomCenter,
                              child: TextField(
                                maxLength: otp ? 6 : 10,
                                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                controller: otp ? code : phoneNo,
                                autofocus: false,
                                textInputAction: TextInputAction.go,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: 20/411 * width,
                                  fontFamily: "Quicksand",
                                  color: otp ? Colors.black : phoneNo.text.length != 10 ? Colors.grey : Colors.black,
                                  decoration: TextDecoration.none,
                                ),
                                decoration: InputDecoration(
                                  prefix: otp ? Text("") :  Text("+ 91 ", style: TextStyle(color: Colors.black),),
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onChanged: (number){
                                  setState(() {});
                                },
                                onSubmitted: (number){
                                  setState(() {
                                    loader = true;
                                  });
                                  if(otp){
                                    var cred = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code.text);
                                    signIn(cred) ;
                                  }
                                  else login();
                                },
                              ),
                            ),
                          ]
                      ),
                    ],
                  ),
                  Expanded(flex: 1, child: Container(),),
                  Center(
                    child: GestureDetector(
                      onTap: () async{
                        setState(() {
                          loader = true;
                        });
                        if(otp){
                          var cred = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code.text);
                          signIn(cred) ;
                        }
                        else  login();
                      },
                      child: Container(
                        width: 342/411 * width,
                        height: 67/411 * width,
                        decoration: BoxDecoration(
                            color: Color(0xff64A73A),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Center(
                          child: Text(otp ? "Verify" : "Proceed",
                              style: TextStyle(fontSize: 36/411 * width, fontWeight: FontWeight.w500,
                                  color: Colors.white, fontFamily: "Quicksand")),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: width * 0.1,),
                ],
              ),
            ),
          ),
          loader ? Center(child: CircularProgressIndicator(strokeWidth: 10,)) : Container(),
        ]
    );
  }
}
