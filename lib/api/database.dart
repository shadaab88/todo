import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/task_data_response.dart';
import 'package:todo/model/user_data_response.dart';

class DatabaseService {

  final String? uid;

  DatabaseService({this.uid});

  //collection reference

  final CollectionReference customerCollection = FirebaseFirestore.instance
      .collection('customers');

  final CollectionReference taskCollection = FirebaseFirestore.instance
      .collection('task');

  Future uploadUserData(UserDataResponse userData) async {

    return await customerCollection.doc(uid).set(
        userData.toJson()
    );
  }

  Future<dynamic> getUserData() async {
    return await customerCollection.doc(uid)
        .get();
  }

  Future uploadTaskDetails(TaskDataResponse data, String? taskId) async {

    return await taskCollection.doc(taskId).set(
        data.toJson()
    );
  }

  Future updateTaskDetails(TaskDataResponse data, String? taskId) async {

    return await taskCollection.doc(taskId).update(
        data.toJson()
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTaskDataStream() {
    return FirebaseFirestore.instance
        .collection('task')
        .where('user_id', isEqualTo: uid)
        .snapshots();
  }



}