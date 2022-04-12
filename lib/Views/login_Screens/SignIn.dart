import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import 'package:madarskom/Views/Admain/AdmainHome.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/Shared_Preference_Login.dart';
import 'package:madarskom/Views/login_Screens/Serveces_Login/auth.dart';
import 'package:madarskom/Views/login_Screens/forgetPassword.dart';
import 'package:madarskom/Widget/Login_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:madarskom/Views/App_Page.dart';
import 'package:madarskom/Database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Helper_login/authenticate.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool forgetPass = false;
  String email, password, resetPassword;
  AuthService authService = new AuthService();
  QuerySnapshot searchResultSnapshot;

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await authService.signInWithEmailAndPassword(email, password).then(
          (result) async {
            if (result != null) {
              QuerySnapshot userInfoSnapshot =
                  await DatabaseMethods().getUserInfo(email);
              String admin = "admin@gmail.com";
              if (email != admin) {
                HelpersFunctions.saveUserLoggedInSharedPreference(true);
                HelpersFunctions.saveUserNameSharedPreference(
                    userInfoSnapshot.documents[0].data["Name"]);
                HelpersFunctions.saveUserEmailSharedPreference(
                    userInfoSnapshot.documents[0].data['Email']);
                HelpersFunctions.saveResultIdInSharedPreference(resultId);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyAppPage()));
              } else {
                HelpersFunctions.saveAdmainIsLoggedIn(true);
                HelpersFunctions.saveUserNameSharedPreference(
                    userInfoSnapshot.documents[0].data["Name"]);
                HelpersFunctions.saveUserEmailSharedPreference(
                    userInfoSnapshot.documents[0].data['Email']);
                HelpersFunctions.saveResultIdInSharedPreference(resultId);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AdmainHome()));
              }
            }
          },
        );
      } catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.grey[400],
              title: Text(
                SetLocalization.of(context)
                    .getTranslateValue("invalid email or password"),
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Authenticate()));
                    },
                    child: Text(
                        SetLocalization.of(context).getTranslateValue("Exit")))
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: height * 0.5,
                        decoration: BoxDecoration(
                          color: ConstantColor.appBap,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: height * 0.08),
                            Text('Welcome',
                                style: GoogleFonts.playfairDisplay(
                                  color: ConstantColor.appBarTitle,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                )),
                            Image.asset(
                              'assets/images/login.ico',
                              height: height * 0.35,
                            ),
                            SizedBox(
                              height: height * 0.001,
                            ),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: height * 0.03),
                                    LoginField(
                                      labelText: SetLocalization.of(context)
                                          .getTranslateValue(
                                              "enter your email"),
                                      keyboardType: TextInputType.emailAddress,
                                      onChange: (value) => setState(() {
                                        email = value.toLowerCase().trim();
                                        print(email);
                                      }),
                                      validator: (value) {
                                        return RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value)
                                            ? null
                                            : "Please Enter Correct Email";
                                      },
                                    ),
                                    SizedBox(height: height * 0.01),
                                    LoginField(
                                        onChange: (value) => setState(() {
                                              password = value;
                                            }),
                                        labelText: SetLocalization.of(context)
                                            .getTranslateValue(
                                                "enter your password"),
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        validator: (value) => value.length < 8
                                            ? 'Your password must be larger than 8 characters'
                                            : null),
                                    SizedBox(height: height * 0.02),
                                    Container(
                                      height: height * 0.08,
                                      width: double.infinity,
                                      // ignore: deprecated_member_use
                                      child: RaisedButton(
                                        onPressed: () => signIn(),
                                        child: Text(
                                          SetLocalization.of(context)
                                              .getTranslateValue("sign in"),
                                          style: GoogleFonts.podkova(
                                            color: ConstantColor.filling,
                                            fontSize: 22,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        color: ConstantColor.button,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => widget.toggleView(),
                                      child: Text(
                                          SetLocalization.of(context)
                                              .getTranslateValue(
                                                  "don't have an account?"),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(fontSize:
                                          MediaQuery.of(context).size.width * 0.04),
                                      ),
                                    ),
                                    TextButton(
                                      child: Text(
                                        SetLocalization.of(context)
                                            .getTranslateValue(
                                                "forgot password"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(fontSize: MediaQuery.of(context).size.width * 0.04),
                                      ),
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ForgetPassword(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
