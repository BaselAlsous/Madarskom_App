import 'package:cloud_firestore/cloud_firestore.dart';


class JobDataBase {
  CollectionReference jobData = Firestore.instance.collection("AddJob");
  Future<void> uploadData(
      {String id,
      String name,
      String email,
      String phone,
      String address,
      String descriptions,
      String province,
      String photoUrl
      }) async {
    return await jobData.document().setData({
      "ID": id,
      "Name": name,
      "Email": email,
      "Phone": phone,
      "Address": address,
      "Description": descriptions,
      "Province": province,
      "photoUrl":photoUrl
    });
  }

  Future fetchData() async {
    var fireStore = Firestore.instance;
    QuerySnapshot qn = await fireStore.collection("AddJob").getDocuments();
    return qn.documents;
  }
}
