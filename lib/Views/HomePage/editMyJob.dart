import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Widget/Field_input.dart';
import 'package:toast/toast.dart';

class EditMyJob extends StatefulWidget {
  final DocumentSnapshot items;

  EditMyJob(this.items);

  @override
  _EditMyJobState createState() => _EditMyJobState();
}

class _EditMyJobState extends State<EditMyJob> {
  @override
  Widget build(BuildContext context) {
    TextEditingController editNameController = TextEditingController()
      ..text = widget.items['Name'];
    TextEditingController editAddressController = TextEditingController()
      ..text = widget.items['Address'];
    TextEditingController editPhoneController = TextEditingController()
      ..text = widget.items['Phone'];
    TextEditingController editEmailController = TextEditingController()
      ..text = widget.items['Email'];
    TextEditingController editDescController = TextEditingController()
      ..text = widget.items['Description'];

    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/profil/profile.png"),
                    fit: BoxFit.fill)),
          ),
          ListView(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(25),
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: ConstantColor.back,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            elevation: 7),
                        child: Icon(
                          Icons.arrow_back,
                          color: ConstantColor.filling,
                        ),
                        onPressed: () => Navigator.of(context).pop()),
                  ),
                  Container(
                    child: Text(
                      "Edit Info Jobs",
                      style: GoogleFonts.robotoSlab(
                        color: ConstantColor.filling,
                        fontSize: MediaQuery.of(context).size.width * .05,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Input3(
                  keyboardType: TextInputType.name,
                  controller: editNameController,
                  placeholder: widget.items['Name'],
                  prefixIcon: Icon(
                    Icons.school,
                    color: Colors.indigo[100],
                  ),
                ),
                Input3(
                  keyboardType: TextInputType.emailAddress,
                  controller: editEmailController,
                  placeholder: SetLocalization.of(context)
                      .getTranslateValue("Email of school"),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  validator: (value) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)
                        ? null
                        : "Please Enter Correct Email";
                  },
                ),
                Input3(
                  keyboardType: TextInputType.number,
                  controller: editPhoneController,
                  placeholder:
                      SetLocalization.of(context).getTranslateValue("Phone"),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                  validator: (value) =>
                      value.length < 10 ? 'Check phone number' : null,
                ),
                Input3(
                  keyboardType: TextInputType.streetAddress,
                  controller: editAddressController,
                  placeholder: SetLocalization.of(context)
                      .getTranslateValue("School address"),
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.brown,
                  ),
                ),
                Input3(
                  keyboardType: TextInputType.text,
                  controller: editDescController,
                  placeholder: SetLocalization.of(context)
                      .getTranslateValue("Description for job"),
                  prefixIcon: Icon(
                    Icons.description,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          primary: ConstantColor.filling,
                          backgroundColor: ConstantColor.button,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, right: 14.0, top: 11, bottom: 11),
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Toast.show(
                              SetLocalization.of(context)
                                  .getTranslateValue("Update successfully"),
                              context,
                              duration: Toast.LENGTH_LONG);
                          widget.items.reference.updateData({
                            "Name": editNameController.text,
                            "Email": editEmailController.text,
                            "Phone": editPhoneController.text,
                            "Address": editAddressController.text,
                            "Description": editDescController.text
                          }).whenComplete(() => Navigator.of(context).pop());
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          primary: ConstantColor.filling,
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          widget.items.reference
                              .delete()
                              .whenComplete(() => Navigator.of(context).pop());
                        }),
                  ),
                ),
              ]),
            ],
          )
        ]),
      ),
    );
  }
}
