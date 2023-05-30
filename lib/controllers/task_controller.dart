import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/api/database.dart';
import 'package:todo/model/task_data_response.dart';
import 'package:todo/utils/session_manager.dart';
import 'package:todo/utils/utility.dart';
import 'package:uuid/uuid.dart';

import '../utils/constants.dart';

class TaskController extends ChangeNotifier {

  var uuid = Uuid();

  String _whichPage = "create";

  String get whichPage => _whichPage;

  set whichPage(String value) {
    _whichPage = value;
    notifyListeners();
  }

  final taskDetailsFormKey = GlobalKey<FormState>();

  TextEditingController _taskNameController = TextEditingController();

  TextEditingController get taskNameController => _taskNameController;

  set taskNameController(TextEditingController value) {
    _taskNameController = value;
    notifyListeners();
  }

  TextEditingController _taskDescriptionController = TextEditingController();

  TextEditingController get taskDescriptionController =>
      _taskDescriptionController;

  set taskDescriptionController(TextEditingController value) {
    _taskDescriptionController = value;
    notifyListeners();
  }

  String _taskDate = "";

  String get taskDate => _taskDate;

  set taskDate(String value) {
    _taskDate = value;
    notifyListeners();
  }

  String _taskTime = "";

  String get taskTime => _taskTime;

  set taskTime(String value) {
    _taskTime = value;
    notifyListeners();
  }

  List<TaskDataResponse> _taskList = [];

  List<TaskDataResponse> get taskList => _taskList;

  set taskList(List<TaskDataResponse> value) {
    _taskList = value;
    notifyListeners();
  }

  List<TaskDataResponse> _tempTaskDataList = [];

  List<TaskDataResponse> get tempTaskDataList => _tempTaskDataList;

  set tempTaskDataList(List<TaskDataResponse> value) {
    _tempTaskDataList = value;
    notifyListeners();
  }

  TaskDataResponse _selectedTask = TaskDataResponse();

  TaskDataResponse get selectedTask => _selectedTask;

  set selectedTask(TaskDataResponse value) {
    _selectedTask = value;
    notifyListeners();
  }

  Future<bool> saveTaskDetails() async{
    Utility.showLoadingDialog();
    String? taskId = uuid.v4();
    TaskDataResponse body = TaskDataResponse();
    body.id = taskId;
    body.userId = Constants.userId;
    body.taskName = taskNameController.text;
    body.taskDescription = taskDescriptionController.text;
    body.taskDate = taskDate;
    body.taskTime = taskTime;

    try{
      await DatabaseService(uid: await SessionManager.getUserId()).uploadTaskDetails(body,taskId).then((value){
      });
      Get.back();
      return true;
    }catch (error){
      print("error");
      print(error);
      Get.back();
      return false;
    }
  }

  Future<bool> updateTaskDetails(TaskDataResponse taskData) async{
    Utility.showLoadingDialog();
    String? taskId = taskData.id;
    TaskDataResponse body = TaskDataResponse();
    body.id = taskId;
    body.userId = Constants.userId;
    body.taskName = taskNameController.text;
    body.taskDescription = taskDescriptionController.text;
    body.taskDate = taskDate;
    body.taskTime = taskTime;

    try{
      await DatabaseService(uid: await SessionManager.getUserId()).updateTaskDetails(body,taskId).then((value){
      });
      Get.back();
      return true;
    }catch (error){
      print("error");
      print(error);
      Get.back();
      return false;
    }
  }

  convertToModelAndTaskData(dynamic taskData) async {

    taskList.clear();

    List<TaskDataResponse>? allTaskData = [];
    allTaskData.clear();
    for (int i = 0; i < taskData.docs.length; i++) {
      TaskDataResponse temp =
      TaskDataResponse.fromJson(taskData.docs[i].data());
      allTaskData.add(temp);
    }
    tempTaskDataList = allTaskData;

    for (int i = 0; i < tempTaskDataList.length; i++) {
      taskList.add(tempTaskDataList[i]);

    }
  }
}