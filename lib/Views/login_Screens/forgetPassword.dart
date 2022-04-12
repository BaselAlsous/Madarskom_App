import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Database/database.dart';

import '../../Services/ConvertLanguage/SetLanguage.dart';
import '../../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import '../../Widget/Login_field.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  String email, resetPassword = "";
  List  listUserdata =[];

  fetchDatabaseList(String pass) async {
    dynamic resultant = await DatabaseMethods().getPassWord(pass);

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        listUserdata = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery
            .of(context)
            .size
            .height - MediaQuery
            .of(context)
            .padding
            .top;
    return Scaffold(
      body: SingleChildScrollView(
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
                                onChange: (value) =>
                                    setState(() {
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
                               labelText: resetPassword,
                               readOnly: true,
                              ),
                              SizedBox(height: height * 0.03),
                              Container(
                                height: height * 0.08,
                                width: double.infinity,
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  onPressed: () {
                                    fetchDatabaseList(email);
                                    resetPassword = listUserdata[0]["Password"];
                                  },
                                  child: Text(SetLocalization.of(context)
                                      .getTranslateValue(
                                      "Send"),
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
                                child: Text(SetLocalization.of(context)
                                    .getTranslateValue(
                                    "Back to Sign In"),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                        fontSize:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            .04)),
                                onPressed: () => Navigator.of(context).pop()
                              ),
                              //forgetPass==false? Text("") :pass()
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
