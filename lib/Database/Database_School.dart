import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolDataBase {
  CollectionReference schoolData = Firestore.instance.collection("AddSchool");

  Future<void> uploadData(
      {
        String id,
      String name,
      bool confirmation,
      String supwevising,
      String numberStudent,
      String numberClass,
      String email,
      String phone,
      String address,
      String descriptions,
      String province,
      String lowestClass,
      String heightClass,
      bool mexid,
      String photoUrl}) async {
    return await schoolData.document().setData({
      "ID": id,
      "Name": name,
      "Supwevising": supwevising,
      "Number Student": numberStudent,
      "Number Class": numberClass,
      "Email": email,
      "Phone": phone,
      "Address": address,
      "Description": descriptions,
      "Province": province,
      "Lowest Class": lowestClass,
      "Height Class": heightClass,
      "Mexid": mexid,
      "photoUrl": photoUrl,
      "confirmation":"confirmation",
    });
  }

  Future fetchData() async {
    var fireStore = Firestore.instance;
    QuerySnapshot qn = await fireStore.collection("AddSchool").getDocuments();
    return qn.documents;
  }
}
