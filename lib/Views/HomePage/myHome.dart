import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/Shared_Preference_Login.dart';
import 'package:madarskom/Widget/Field_input.dart';
import 'package:path/path.dart' as Path;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../login_Screens/Helper_login/Shared_Preference_Login.dart';
import 'MyJobs.dart';
import 'MySchool.dart';


String id;
class UserEditInfoStream extends StatefulWidget {
  final Future funSchool;
  final Future funJob;
  final QuerySnapshot job;
  final QuerySnapshot school;

  UserEditInfoStream(this.funSchool, this.funJob, this.job, this.school);

  @override
  _UserEditInfoStreamState createState() => _UserEditInfoStreamState();
}

class _UserEditInfoStreamState extends State<UserEditInfoStream> {

  var size;
  double itemHeight;
  double itemWidth;
  ProgressDialog pr;
  String name = "";
  bool showSpinner = false;
  File _image;

  TextEditingController nameConroler = TextEditingController();
  TextEditingController aboutCotroler = TextEditingController();

  getUserName() {
    HelpersFunctions.getResultIdInSharedPreference()
        .then((value) => setState(() => id = value));
    print(id);
  }
  @override
  void initState() {
    getUserName();
    super.initState();
  }

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
          Firestore.instance.collection('Users').document(id);
          Map<String, String> data = {
            'photoUrl': fileURL,
          };
          Firestore.instance
              .collection('Users')
              .document(id)
              .updateData(data)
              .whenComplete(() {
            print('Document Updated');
            pr.hide();
          });
        });
      });
    } catch (e) {
      print(' erorr $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    return StreamBuilder(
      stream: Firestore.instance.collection('Users').document(id).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SpinKitCircle(
              color: Colors.white,
              size: 100.0,
            ),
          );
        }
        String url = snapshot.data['photoUrl'];
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 15,),
                url.length == 0
                    ? GestureDetector(
                        onTap: () {
                          uploadFile();
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Icon(
                            Icons.account_circle,
                            size: MediaQuery.of(context).size.width * .4,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          uploadFile();
                        },
                        child: CachedNetworkImage(
                            imageBuilder: (context, imageProvider) => Container(
                                  width: MediaQuery.of(context).size.width * .4,
                                  height:
                                      MediaQuery.of(context).size.height * .2,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                            placeholder: (context, url) => Container(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 1.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.blue)),
                                  width: MediaQuery.of(context).size.width * .4,
                                ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error, size: 150),
                            width: MediaQuery.of(context).size.width * .4,
                            fit: BoxFit.cover,
                            imageUrl: url.toString()),
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .03,
                      vertical: MediaQuery.of(context).size.width * .02),
                  child: Input2(
                    keyboardType: TextInputType.emailAddress,
                    controller: nameConroler,
                    onChanged: (val) {
                      name = val;
                    },
                    placeholder: SetLocalization.of(context)
                        .getTranslateValue("editYourName"),
                    prefixIcon: Icon(
                      Icons.drive_file_rename_outline,
                      color: ConstantColor.simpleIcon,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .008,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Material(
                  color: ConstantColor.button,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 10.0,
                  child: Builder(builder: (BuildContext context) {
                    return MaterialButton(
                      onPressed: () {
                        try {
                            if (nameConroler.text.isEmpty) {

                                  Toast.show(" Check Your Info ", context,
                                  duration: Toast.LENGTH_LONG);

                            } else {
                              Firestore.instance.collection('Users').document(id);
                              Map<String, String> data = {
                                'Name': name, // Updating Document Reference
                              };
                              Firestore.instance
                                  .collection('Users')
                                  .document(id)
                                  .updateData(data)
                                  .whenComplete(() {
                                print('Document Updated');
                                Toast.show("Updated", context,
                                    duration: Toast.LENGTH_LONG);
                                pr.hide();
                                HelpersFunctions.saveUserNameSharedPreference(nameConroler.text);
                                nameConroler.clear();
                                FocusScope.of(context).unfocus();
                              });
                            }

                        } catch (e) {
                          print(' error  $e');
                        }
                      },
                      minWidth: MediaQuery.of(context).size.height * .4,
                      child: Text(
                        SetLocalization.of(context).getTranslateValue("Update"),
                        style: GoogleFonts.robotoSlab(
                          color: ConstantColor.filling,
                          fontSize: MediaQuery.of(context).size.width * .05,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .025,
                ),
                Material(
                  color: ConstantColor.button,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 10.0,
                  child: Builder(builder: (BuildContext context) {
                    return MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MySchools(widget.funSchool, widget.school)));
                      },
                      minWidth: MediaQuery.of(context).size.height * .4,
                      child: Text(
                        SetLocalization.of(context).getTranslateValue("My School"),
                        style: GoogleFonts.robotoSlab(
                          color: ConstantColor.filling,
                          fontSize: MediaQuery.of(context).size.width * .05,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .025,
                ),
                Material(
                  color: ConstantColor.button,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 10.0,
                  child: Builder(builder: (BuildContext context) {
                    return MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyJobInfo(widget.funJob, widget.job)));
                      },
                      minWidth: MediaQuery.of(context).size.height * .4,
                      child: Text(
                        SetLocalization.of(context).getTranslateValue("My Jobs"),style:
                      GoogleFonts.robotoSlab(
                        color: ConstantColor.filling,
                        fontSize: MediaQuery.of(context).size.width * .05,
                        fontStyle: FontStyle.italic,
                      ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
