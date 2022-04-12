import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/Shared_Preference_Login.dart';

import 'package:path/path.dart' as Path;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Database/Database_Job.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Widget/Field_input.dart';
import 'package:toast/toast.dart';

import '../../../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';

class JobInfo extends StatefulWidget {
  @override
  _JobInfoState createState() => _JobInfoState();
}

class _JobInfoState extends State<JobInfo> {
  bool checkValue = false;
  String selectedType;
  String id;
  File _image;
  var uploadPhoto;

  TextEditingController nameController = TextEditingController()..text = '';
  TextEditingController addressController = TextEditingController()..text = '';
  TextEditingController phoneController = TextEditingController()..text = '';
  TextEditingController managerController = TextEditingController()..text = '';
  TextEditingController emailController = TextEditingController()..text = '';
  TextEditingController descController = TextEditingController()..text = '';

  @override
  void initState() {
    super.initState();
    getRegisterId();
  }

  void getRegisterId() {
    HelpersFunctions.getResultIdInSharedPreference()
        .then((value) => setState(() => id = value));
  }

  void uploadToFirebase(BuildContext ctx, File image) async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        addressController.text.isEmpty ||
        descController.text.isEmpty ||
        phoneController.text.isEmpty ||
        checkValue == false ||
        selectedType.isEmpty) {
      Toast.show("Please enter all Fields", ctx, duration: Toast.LENGTH_LONG);
    } else if (phoneController.text.length < 9) {
      Toast.show("phone number must be at least 10 digits ", ctx,
          duration: Toast.LENGTH_LONG);
    } else if (image == null) {
      Toast.show("Please select an image", ctx, duration: Toast.LENGTH_LONG);
    } else {
      try {
        JobDataBase().uploadData(
          id: id,
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          address: addressController.text,
          descriptions: descController.text,
          province: selectedType,
          photoUrl: uploadPhoto,
        );
        deleteFields();
        deleteImage(image);
        Toast.show("Job uploaded successfully", ctx,
            duration: Toast.LENGTH_LONG);
        Navigator.of(context).pop();
      } catch (e) {
        Toast.show("Please check the entered data", ctx,
            duration: Toast.LENGTH_LONG);
        print(e);
      }
    }
  }

  void deleteFields() {
    nameController = null;
    addressController = null;
    phoneController = null;
    emailController = null;
    descController = null;
    selectedType = null;
    checkValue = false;
  }

  void deleteImage(File image) {
    image = null;
  }

  @override
  Widget build(BuildContext context) {
    List province = [
      SetLocalization.of(context).getTranslateValue("Irbid"),
      SetLocalization.of(context).getTranslateValue("Amman"),
      SetLocalization.of(context).getTranslateValue("Zarqa"),
      SetLocalization.of(context).getTranslateValue("alSalt"),
      SetLocalization.of(context).getTranslateValue("Mafraq"),
      SetLocalization.of(context).getTranslateValue("Karak"),
      SetLocalization.of(context).getTranslateValue("Madaba"),
      SetLocalization.of(context).getTranslateValue("Jerash"),
      SetLocalization.of(context).getTranslateValue("Ajloun"),
      SetLocalization.of(context).getTranslateValue("Aqaba"),
      SetLocalization.of(context).getTranslateValue("Tafila"),
      SetLocalization.of(context).getTranslateValue("Ma'an"),
    ];

    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: Stack(
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
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: ConstantColor.filling,
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).pop();
                      },
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Icon(
                        Icons.work_outlined,
                        color: ConstantColor.filling,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(

                    SetLocalization.of(context)
                        .getTranslateValue("Job Register"),
                      style: GoogleFonts.notoSerif(
                      color: Colors.white,
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 24.0, right: 24.0, bottom: 32),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    child: Column(
                      children: [
                        Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, top: 5.0),
                                  child: Container(
                                    child: Text(
                                      SetLocalization.of(context)
                                          .getTranslateValue("enter the job information"),

                                      style: GoogleFonts.notoSerif(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: ConstantColor.cardColor,
                          ),
                          height: MediaQuery.of(context).size.height * 0.63,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Input(
                                    keyboardType: TextInputType.name,
                                    controller: nameController,
                                    placeholder: SetLocalization.of(context)
                                        .getTranslateValue("School name"),
                                    prefixIcon: Icon(
                                      Icons.school,
                                      color: ConstantColor.simpleIcon,
                                    ),
                                  ),
                                  Input(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    placeholder: SetLocalization.of(context)
                                        .getTranslateValue("Email of school"),
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
                                  Input(
                                    keyboardType: TextInputType.number,
                                    controller: phoneController,
                                    placeholder: SetLocalization.of(context)
                                        .getTranslateValue("Phone"),
                                    prefixIcon:
                                        Icon(Icons.phone, color : ConstantColor.simpleIcon,),
                                    validator: (value) => value.length < 10
                                        ? 'Check phone number'
                                        : null,
                                  ),
                                  Input(
                                    keyboardType: TextInputType.streetAddress,
                                    controller: addressController,
                                    placeholder: SetLocalization.of(context)
                                        .getTranslateValue("School address"),
                                    prefixIcon: Icon(Icons.location_on,
                                      color : ConstantColor.simpleIcon,),
                                  ),
                                  Input(
                                    keyboardType: TextInputType.text,
                                    controller: descController,
                                    maxline: 5,
                                    placeholder: SetLocalization.of(context)
                                        .getTranslateValue(
                                            "Description for job"),
                                    prefixIcon: Icon(
                                      Icons.description,
                                      color : ConstantColor.simpleIcon,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      //color: Colors.grey,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      child: Row(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.location_city,
                                            color : ConstantColor.simpleIcon,
                                          ),
                                        ),
                                        DropdownButton(
                                          dropdownColor: Colors.white,
                                          items: province
                                              .map((value) => DropdownMenuItem(
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            136, 152, 170, 1.0),
                                                      ),
                                                    ),
                                                    value: value,
                                                  ))
                                              .toList(),
                                          onChanged: (selectedAccountType) {
                                            setState(() {
                                              selectedType = selectedAccountType;
                                            });
                                          },
                                          value: selectedType,
                                          isExpanded: false,
                                          hint: Text(
                                            SetLocalization.of(context)
                                                .getTranslateValue("province"),
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  91, 101, 110,
                                                  0.9686274509803922),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 0.5,
                                    child: Container(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        SetLocalization.of(context)
                                            .getTranslateValue(
                                                "Add school photos"),
                                        style: TextStyle(
                                            color: ConstantColor.textProfileColor,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          primary: ConstantColor.button,
                                        ),
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color : ConstantColor.filling,                                        ),
                                        onPressed: uploadFile,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 0, bottom: 16),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: checkValue,
                                          onChanged: (newValue) => setState(
                                            () => checkValue = newValue,
                                          ),
                                        ),
                                        Text(
                                            SetLocalization.of(context)
                                                .getTranslateValue(
                                                    "I agree with the"),
                                            style: TextStyle(color:Colors.black , fontSize:17)),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('/privacy');
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              SetLocalization.of(context)
                                                  .getTranslateValue(
                                                      "Privacy Policy"),
                                              style: TextStyle(
                                                  color: Colors.black, fontSize: 17),
                                            ),
                                          ),
                                        ),
                                      ],
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
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 16.0,
                                              right: 16.0,
                                              top: 12,
                                              bottom: 12),
                                          child: Text(
                                            SetLocalization.of(context)
                                                .getTranslateValue("REGISTER"),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        onPressed: () =>
                                            uploadToFirebase(context, _image),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  ProgressDialog pr;

  Future uploadFile() async {
    try {
      pr = new ProgressDialog(context);
      // ignore: deprecated_member_use
      await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
        setState(() {
          _image = image;
        });
      });
      await pr.show();

      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('${"$id"}/UserProfille/${Path.basename(_image.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          uploadPhoto = fileURL;
        });
        pr.hide();
      });
    } catch (e) {
      print('erorr $e');
    }
  }
}
