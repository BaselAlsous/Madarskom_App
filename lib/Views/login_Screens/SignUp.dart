import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Views/App_Page.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/Shared_Preference_Login.dart';
import 'package:madarskom/Views/login_Screens/Serveces_Login/auth.dart';
import 'package:madarskom/Widget/Login_field.dart';
import 'package:madarskom/Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import 'Helper_login/Shared_Preference_Login.dart';
import 'Helper_login/authenticate.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email, password, resetPassword;
  bool isLoading = false;
  AuthService authService = new AuthService();
  TextEditingController usernameEditingController = new TextEditingController();

  void signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await authService
            .signUpWithEmailAndPassword(
            email, password, usernameEditingController.text)
            .then((result) async {
          if (result != null) {
            HelpersFunctions.saveUserLoggedInSharedPreference(true);
            HelpersFunctions.saveUserNameSharedPreference(usernameEditingController.text);
            HelpersFunctions.saveUserEmailSharedPreference(email);
            HelpersFunctions.saveResultIdInSharedPreference(resultId);
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppPage()));
          }
        });
      }catch(e){
        print(e);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return  AlertDialog(
              backgroundColor: Colors.grey[400],
              title: Text(SetLocalization.of(context)
                  .getTranslateValue("Email already in use"), style: TextStyle(color: Colors.black),),
              actions: [
                // ignore: deprecated_member_use
                FlatButton(onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Authenticate()));
                }, child: Text(SetLocalization.of(context)
                    .getTranslateValue("Exit")) )
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

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
                        height: h * 0.5,
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
                            SizedBox(height: h * 0.08),
                            Text('Welcome',
                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  fontStyle: FontStyle.italic,
                                )),
                            Image.asset(
                              'assets/images/login.ico',
                              height: h * 0.35,
                            ),
                            SizedBox(height: h * 0.001),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: h * 0.03),
                                    LoginField(
                                      labelText: SetLocalization.of(context)
                                          .getTranslateValue("username"),
                                      controller: usernameEditingController,
                                      keyboardType: TextInputType.name,
                                      validator: (val) {
                                        return val.isEmpty || val.length < 3
                                            ? "Enter Username 3+ characters"
                                            : null;
                                      },
                                    ),
                                    SizedBox(height: h * 0.01),
                                    LoginField(
                                      onChange: (value) => setState(
                                        () {
                                          email = value.trim().toLowerCase();
                                        },
                                      ),
                                      labelText: SetLocalization.of(context)
                                          .getTranslateValue(
                                              "enter your email"),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        return RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value)
                                            ? null
                                            : "Please Enter Correct Email";
                                      },
                                    ),
                                    SizedBox(height: h * 0.01),
                                    LoginField(
                                      onChange: (value) => setState(
                                        () {
                                          password = value;
                                        },
                                      ),
                                      labelText: SetLocalization.of(context)
                                          .getTranslateValue(
                                              "enter your password"),
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      validator: (value) => value.length < 8
                                          ? 'Your password must be larger than 8 characters'
                                          : null,
                                    ),
                                    SizedBox(height: h * 0.01),
                                    LoginField(
                                      onChange: (value) => setState(() {
                                        resetPassword = value;
                                      }),
                                      labelText: SetLocalization.of(context)
                                          .getTranslateValue(
                                              "confirm password"),
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      validator: (value) => value.length < 8
                                          ? 'Your password must be larger than 8 characters'
                                          : null,
                                    ),
                                    SizedBox(height: h * 0.01),
                                    Container(
                                      height: 55,
                                      width: double.infinity,
                                      // ignore: deprecated_member_use
                                      child: RaisedButton(
                                        onPressed: () => signUp(),
                                        child: Text(
                                          SetLocalization.of(context)
                                              .getTranslateValue("sign up"),
                                          style: GoogleFonts.podkova(
                                            color: Colors.white,
                                            fontSize: 18,
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
                                                "i have an account"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(fontSize: MediaQuery.of(context).size.width * 0.04),
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
