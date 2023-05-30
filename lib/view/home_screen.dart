import 'package:flutter/material.dart';
import 'package:todo/api/database.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/main.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/custom_container.dart';
import 'package:todo/utils/customer_bottom_sheet.dart';
import 'package:todo/view/create_edit_task.dart';
import 'package:todo/view/drawer.dart';
import 'package:provider/provider.dart';
import 'package:todo/view/task_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  static const id = "HomeScreen";

  late TaskController taskController;
  @override
  Widget build(BuildContext context) {
    taskController = Provider.of<TaskController>(context, listen: true);
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "TODO",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Constants.black
          ),
        ),
        leading: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            FloatingActionButton(
              elevation: 0,
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();

              },
              child: const Icon(
                Icons.menu,
                size: 20,
                color: Constants.black,
              ),
              backgroundColor: Constants.white,
              mini: true,
              heroTag: "CurrentLocation",
            ),
          ],
        ),
      ),

      body: StreamBuilder<dynamic>(
          stream:
          DatabaseService(uid: Constants.userId).getTaskDataStream(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done ||
                snapshot.connectionState == ConnectionState.active) {
              // if(orderController.orderDataList.length == 0){
              taskController.convertToModelAndTaskData(snapshot.data);
              // }

            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                (taskController.taskList.isNotEmpty)?ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8),
                        child: CustomContainer(
                          onTap: (){
                            taskController.selectedTask = taskController.taskList[index];
                            CustomBottomSheets
                                .showBottomSheetWithHeight(
                                TaskBottomSheet(),
                                context,
                                height: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.3);
                          },
                          borderColor: Constants.grey,
                          child: ListTile(

                            trailing: InkWell(
                              onTap: () {
                                taskController.whichPage = "Edit";
                                taskController.taskNameController.text = taskController.taskList[index].taskName ?? "";
                                taskController.taskDescriptionController.text = taskController.taskList[index].taskDescription ?? "";
                                taskController.taskDate = taskController.taskList[index].taskDate ?? "";
                                taskController.taskTime = taskController.taskList[index].taskTime ?? "";
                                taskController.selectedTask = taskController.taskList[index];
                                Navigator.pushNamed(
                                  context,
                                  CreateEditTask.id,
                                );
                              },
                              child: Icon(
                                Icons.edit,
                                color: Constants.secondaryColor,
                              ),
                            ),

                            title: Text(
                              "${taskController.taskList[index].taskName}"
                            ),
                            subtitle: Text(
                                "${taskController.taskList[index].taskDescription}"
                            ),
                          ),
                        ),
                      );

                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: taskController.taskList.length
                ) :Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "No Task Available",
                          style: TextStyle(
                            fontSize: 25
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Add Task by clicking on add button",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskController.whichPage = "Create";
          Navigator.pushNamed(
            context,
            CreateEditTask.id,
          );
        },
        backgroundColor: Constants.secondaryColor,

        child: Icon(
          Icons.add,
          size: 30,
          color: Constants.white,
        ),
      ),
    );
  }
}
