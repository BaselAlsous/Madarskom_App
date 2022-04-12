import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/Shared_Preference_Login.dart';
import 'package:path/path.dart' as Path;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Widget/Field_input.dart';
import 'package:toast/toast.dart';
import 'package:madarskom/Database/Database_School.dart';

import '../../../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';

class InfoSchool extends StatefulWidget {
  @override
  _InfoSchoolState createState() => _InfoSchoolState();
}

class _InfoSchoolState extends State<InfoSchool> {
  bool _value = false;
  bool _val = false;
  String selectedType;
  String _selectedClasses;
  String _selectedClasses1;
  String id;
  File _image;
  var uploadPhoto;
  TextEditingController schoolNameController = TextEditingController()
    ..text = '';
  TextEditingController supervisingController = TextEditingController()
    ..text = '';
  TextEditingController numStuController = TextEditingController()..text = '';
  TextEditingController numClsController = TextEditingController()..text = '';
  TextEditingController emailController = TextEditingController()..text = '';
  TextEditingController descController = TextEditingController()..text = '';
  TextEditingController addressController = TextEditingController()..text = '';
  TextEditingController phoneController = TextEditingController()..text = '';

  @override
  void initState() {
    super.initState();
    getRegisterId();
  }

  void getRegisterId() {
    HelpersFunctions.getResultIdInSharedPreference()
        .then((value) => setState(() => id = value));
  }

  void uploadToFirebase(BuildContext ctx, File image) {
    if (schoolNameController.text == "" ||
        emailController.text == "" ||
        addressController.text == "" ||
        descController.text == "" ||
        phoneController.text == "" ||
        supervisingController.text == "" ||
        numClsController.text == "" ||
        numStuController.text == "" ||
        selectedType == "" ||
        _selectedClasses == "" ||
        _selectedClasses1 == "" ||
        _val == false) {
      Toast.show("Please enter all Fields", ctx, duration: Toast.LENGTH_LONG);
    } else {
      if (phoneController.text.length < 9) {
        Toast.show("phone number must be at least 10 digits ", ctx,
            duration: Toast.LENGTH_LONG);
      } else if (image == null) {
        Toast.show("Please select an image", ctx, duration: Toast.LENGTH_LONG);
      } else {
        try {
          SchoolDataBase().uploadData(
            id: id,
            name: schoolNameController.text,
            supwevising: supervisingController.text,
            numberStudent: numStuController.text,
            numberClass: numClsController.text,
            email: emailController.text,
            phone: phoneController.text,
            address: addressController.text,
            descriptions: descController.text,
            province: selectedType,
            lowestClass: _selectedClasses1,
            heightClass: _selectedClasses,
            mexid: _value,
            photoUrl: uploadPhoto,
          );
          deleteFields();
          deleteImage(image);
          Toast.show("School uploaded successfully", ctx,
              duration: Toast.LENGTH_LONG);
          Navigator.of(context).pop();
        } catch (e) {
          Toast.show("Please check the entered data", ctx,
              duration: Toast.LENGTH_LONG);
          print(e);
        }
      }
    }
  }

  void deleteImage(File image) {
    image = null;
  }

  void deleteFields() {
    schoolNameController = null;
    supervisingController = null;
    numStuController = null;
    numClsController = null;
    emailController = null;
    descController = null;
    addressController = null;
    phoneController = null;
    selectedType = null;
    _selectedClasses1 = null;
    _selectedClasses1 = null;
    _val = false;
  }

  Future getImage(ImageSource src) async {
    final pickedFile = await ImagePicker().getImage(source: src);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print('Image selected.');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;

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
    List clasees = [
      "KG-1",
      "KG-2",
      SetLocalization.of(context).getTranslateValue("First grade"),
      SetLocalization.of(context).getTranslateValue("Second grade"),
      SetLocalization.of(context).getTranslateValue("Third grade"),
      SetLocalization.of(context).getTranslateValue("fourth grade"),
      SetLocalization.of(context).getTranslateValue("fifth grade"),
      SetLocalization.of(context).getTranslateValue("Sixth grade"),
      SetLocalization.of(context).getTranslateValue("Seventh grade"),
      SetLocalization.of(context).getTranslateValue("Eighth grade"),
      SetLocalization.of(context).getTranslateValue("Ninth grade"),
      SetLocalization.of(context).getTranslateValue("Tenth grade"),
      SetLocalization.of(context).getTranslateValue("First grade secondary"),
      SetLocalization.of(context).getTranslateValue("Second secondary"),
    ];

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
                          Icons.school,
                          color: ConstantColor.filling,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      SetLocalization.of(context)
                          .getTranslateValue("School Register"),


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
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    SetLocalization.of(context)
                                        .getTranslateValue("enter the school information"),
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.63,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: ConstantColor.cardColor,
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Input(
                                            keyboardType: TextInputType.name,
                                            controller: schoolNameController,
                                            placeholder:
                                                SetLocalization.of(context)
                                                    .getTranslateValue(
                                                        "School name"),
                                            prefixIcon: Icon(
                                              Icons.school,
                                              color: ConstantColor.simpleIcon,
                                            ),
                                          ),
                                          Input(
                                            keyboardType: TextInputType.name,
                                            controller: supervisingController,
                                            placeholder: SetLocalization.of(
                                                    context)
                                                .getTranslateValue(
                                                    "Supervising authority"),
                                            prefixIcon: Icon(
                                              Icons.person,
                                              color: ConstantColor.simpleIcon,
                                            ),
                                          ),
                                          Input(
                                            keyboardType: TextInputType.number,
                                            controller: numStuController,
                                            placeholder:
                                                SetLocalization.of(context)
                                                    .getTranslateValue(
                                                        "Number of students"),
                                            prefixIcon: Icon(
                                              Icons.people,
                                              color: ConstantColor.simpleIcon,
                                            ),
                                          ),
                                          Input(
                                            keyboardType: TextInputType.number,
                                            controller: numClsController,
                                            placeholder:
                                                SetLocalization.of(context)
                                                    .getTranslateValue(
                                                        "Number of classes"),
                                            prefixIcon: Icon(
                                              Icons.class__rounded,
                                              color: ConstantColor.simpleIcon,
                                            ),
                                          ),
                                          Input(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller: emailController,
                                            placeholder:
                                                SetLocalization.of(context)
                                                    .getTranslateValue(
                                                        "Email of school"),
                                            prefixIcon: Icon(
                                              Icons.email,
                                              color: ConstantColor.simpleIcon,
                                            ),
                                          ),
                                          Input(
                                            keyboardType:
                                                TextInputType.streetAddress,
                                            controller: addressController,
                                            placeholder:
                                                SetLocalization.of(context)
                                                    .getTranslateValue(
                                                        "School address"),
                                            prefixIcon: Icon(
                                              Icons.location_on,
                                              color: ConstantColor.simpleIcon,
                                            ),
                                          ),
                                          Input(
                                            keyboardType: TextInputType.phone,
                                            controller: phoneController,
                                            placeholder:
                                                SetLocalization.of(context)
                                                    .getTranslateValue("Phone"),
                                            prefixIcon: Icon(
                                              Icons.phone,
                                              color: ConstantColor.simpleIcon,
                                            ),
                                          ),
                                          Input(
                                            keyboardType: TextInputType.text,
                                            maxline: 5,
                                            controller: descController,
                                            placeholder: SetLocalization.of(
                                                    context)
                                                .getTranslateValue(
                                                    "Description for school"),
                                            prefixIcon: Icon(
                                              Icons.description,
                                              color: ConstantColor.simpleIcon,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      ConstantColor.simpleIcon,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.location_city,
                                                      color: ConstantColor
                                                          .simpleIcon,
                                                    ),
                                                  ),
                                                  DropdownButton(
                                                    dropdownColor: Colors.white,
                                                    items: province
                                                        .map(
                                                          (value) =>
                                                              DropdownMenuItem(
                                                            child: Text(
                                                              value,
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        136,
                                                                        152,
                                                                        170,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            value: value,
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged:
                                                        (selectedAccountType) {
                                                      setState(
                                                        () {
                                                          selectedType =
                                                              selectedAccountType;
                                                        },
                                                      );
                                                    },
                                                    value: selectedType,
                                                    isExpanded: false,
                                                    hint: Text(
                                                      SetLocalization.of(context)
                                                          .getTranslateValue(
                                                          "province"),
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            136, 152, 170, 1.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.5,
                                            child:
                                                Container(color: Colors.grey),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                SetLocalization.of(context)
                                                    .getTranslateValue(
                                                        "minimum_upper_limits"),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                          ),
                                          dropdownButtonCreatior1(
                                              clasees,
                                              "The lowest class",
                                              Icon(
                                                Icons.call_received ,
                                                color: ConstantColor.simpleIcon,
                                              )),
                                          dropdownButtonCreatior(
                                              clasees,
                                              "The highest class",
                                              Icon(
                                                Icons.call_made,
                                                color: ConstantColor.simpleIcon,
                                              )),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height*.01,
                                          ),
                                          SizedBox(
                                              height: 0.5,
                                              child: Container(
                                                color: Colors.grey,
                                              )),
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
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w300))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Center(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  primary: ConstantColor.button,
                                                ),
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: ConstantColor.filling,
                                                ),
                                                onPressed: uploadFile,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                      SetLocalization.of(
                                                              context)
                                                          .getTranslateValue(
                                                              "Type: mixed ?"),
                                                      style: TextStyle(color:Colors.black , fontSize:17)),
                                                ),
                                                Container(
                                                  child: Switch(
                                                    value: _value,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        _value = val;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3.0, top: 0, bottom: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Checkbox(
                                                  value: _val,
                                                  onChanged: (value) =>
                                                      setState(
                                                          () => _val = value),
                                                ),
                                                Text(
                                                    SetLocalization.of(context)
                                                        .getTranslateValue(
                                                            "I agree with the"),
                                                    style:TextStyle(color:Colors.black , fontSize:17)),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              '/privacy');
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 2),
                                                      child: Text(
                                                          SetLocalization.of(
                                                                  context)
                                                              .getTranslateValue(
                                                                  "Privacy Policy"),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black , fontSize: 17)),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: Center(
                                              // ignore: deprecated_member_use
                                              child: FlatButton(
                                                color: ConstantColor.button,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 16.0,
                                                      right: 16.0,
                                                      top: 12,
                                                      bottom: 12),
                                                  child: Text(
                                                      SetLocalization.of(
                                                              context)
                                                          .getTranslateValue(
                                                              "REGISTER"),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16.0)),
                                                ),
                                                onPressed: () =>
                                                    uploadToFirebase(
                                                        context, _image),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }

  Widget inputCrateior(Color borderColor, String placeholder, Icon prefixIcon,
      {TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Input(
        placeholder: SetLocalization.of(context).getTranslateValue(placeholder),
        prefixIcon: prefixIcon,
        controller: controller,
      ),
    );
  }

  Widget dropdownButtonCreatior(List list, String hint, Icon icon) {
    return Center(
      child: DropdownButton(
        value: _selectedClasses,
        icon: icon,
        dropdownColor: Colors.white,
        hint: Text(
          SetLocalization.of(context).getTranslateValue(hint),
          style: TextStyle(color:Colors.black , fontSize:17),
        ),
        items: list.map((item) {
          return DropdownMenuItem(
            child: Text(
              item,
              style: TextStyle(color: Colors.black),
            ),
            value: item,
          );
        }).toList(),
        onChanged: (newvalue) {
          setState(() {
            _selectedClasses = newvalue;
          });
        },
      ),
    );
  }

  Widget dropdownButtonCreatior1(List list, String hint, Icon icon) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.003 , vertical: MediaQuery.of(context).size.height*.005),
        child: DropdownButton(
          value: _selectedClasses1,
          icon: icon,
          dropdownColor: Colors.white,
          hint: Text(
            SetLocalization.of(context).getTranslateValue(hint),
            style: TextStyle(color:Colors.black , fontSize:17),
          ),
          items: list.map((item) {
            return DropdownMenuItem(
              child: Text(
                item,
                style: TextStyle(color: Colors.black ,  ),
              ),
              value: item,
            );
          }).toList(),
          onChanged: (newvalue) {
            setState(() {
              _selectedClasses1 = newvalue;
            });
          },
        ),
      ),
    );
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
      print('bego erorr $e');
    }
  }
}
