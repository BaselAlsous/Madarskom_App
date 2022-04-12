import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Database/problemAndFeatureMessage.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Widget/Field_input.dart';
import 'package:toast/toast.dart';

import '../../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';

class MyProblem extends StatefulWidget {
  @override
  _MyProblemState createState() => _MyProblemState();
}

class _MyProblemState extends State<MyProblem> {
  TextEditingController _controllerProblem = new TextEditingController();
  TextEditingController _controllerEmail = new TextEditingController();
  ProblemDatabase problemDatabase;



  void onValueChange() {
    setState(() {
      _controllerProblem.text;
    });
  }

  @override
  void initState() {
    super.initState();
    _controllerProblem.addListener(onValueChange);
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [ Stack(
            children: [
              Container(
                height: heightScreen * 0.3,
                width: widthScreen,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  color: ConstantColor.appBap,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: ConstantColor.filling,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Icon(
                          Icons.feedback,
                          color: ConstantColor.filling,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    SetLocalization.of(context)
                        .getTranslateValue("Report a problem"),
                    style: GoogleFonts.notoSerif(
                      color: ConstantColor.appBarTitle,
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: heightScreen * 0.17,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: heightScreen * 0.045,
                        vertical: widthScreen * 0.04),
                    child: Input2(
                      maxlength: 300,
                      maxline: 10,
                      keyboardType: TextInputType.emailAddress,
                      controller: _controllerProblem,
                      placeholder:
                      SetLocalization.of(context)
                          .getTranslateValue("enter your problem"),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: heightScreen * 0.045),
                    child: Input2(
                      maxlength: 50,
                      keyboardType: TextInputType.emailAddress,
                      controller: _controllerEmail,
                      placeholder: SetLocalization.of(context)
                          .getTranslateValue("Enter your e-mail"),
                      prefixIcon: Icon(
                        Icons.email,
                        color: ConstantColor.simpleIcon,
                      ),
                      validator: (value) {
                        return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)
                            ? null
                            : "Please Enter Correct Email";
                      },
                    ),
                  ),
                  Container(
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary:   ConstantColor.button,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10)),
                        onPressed: uploadToFirebase,
                        child: Text(
                          SetLocalization.of(context)
                              .getTranslateValue("Send the problem"),
                          style: GoogleFonts.notoSerif(
                            color: ConstantColor.filling,
                            fontSize: 19,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),],

        ),
      ),
    );

  }
  void uploadToFirebase(){
    if (_controllerProblem.text.isEmpty ||
        _controllerEmail.text.isEmpty
    ) {
      Toast.show( SetLocalization.of(context)
          .getTranslateValue("Please enter all Fields"),context,duration: Toast.LENGTH_LONG);
    } else {
      try {
        ProblemDatabase().uploadData(
          email: _controllerEmail.text,
          problemMessage: _controllerProblem.text,
        );
        Toast.show( SetLocalization.of(context)
            .getTranslateValue("The problem will be dealt with if it is found to be present"),context,duration: Toast.LENGTH_LONG);
        Navigator.of(context).pop();
      } catch (e) {
        Toast.show(SetLocalization.of(context)
            .getTranslateValue("Please check the entered data"),context,duration: Toast.LENGTH_LONG);
        print(e);
      }
    }
  }
}
