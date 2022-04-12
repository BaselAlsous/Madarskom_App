import 'package:cloud_firestore/cloud_firestore.dart';

class ProblemDatabase {
  CollectionReference problemData = Firestore.instance.collection("problem");
  Future<void> uploadData(
      {
        String problemMessage,
        String email,
      }) async {
    return await problemData.document().setData({
      "problem message": problemMessage,
      "email":email
    });
  }
  Future fetchData() async {
    Firestore fireStore = Firestore.instance;
    QuerySnapshot qn = await fireStore.collection("problem").getDocuments();
    return qn.documents;
  }

  deleteData()async{
    await Firestore.instance.collection("problem").document().delete();
  }
}

class FeatureDatabase {
  CollectionReference problemData = Firestore.instance.collection("Feature");
  Future<void> uploadData(
      {
        String featureMessage,
        String email,
      }) async {
    return await problemData.document().setData({
      "Feature message": featureMessage,
      "email":email
    });
  }
  Future fetchData() async {
    var fireStore = Firestore.instance;
    QuerySnapshot qn = await fireStore.collection("Feature").getDocuments();
    return qn.documents;
  }

}
