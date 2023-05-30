import 'package:flutter/material.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/utils/constants.dart';

import '../../api/database.dart';
import 'package:provider/provider.dart';

import '../../utils/utility.dart';

class TaskBottomSheet extends StatelessWidget {

  late TaskController taskController;

  @override
  Widget build(BuildContext context) {
    taskController = Provider.of<TaskController>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "${taskController.selectedTask.taskName}",
              // "AGRAS MG-1S SERIES",
              style: TextStyle(
                  fontSize: 20,
                  color: Constants.black,
                  fontWeight: FontWeight.w600
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Description : ",
                    // "Rs. ${orderController.selectedOrderData.paymentAmount}",
                    style: TextStyle(
                        fontSize: 15,
                        color: Constants.black,
                        // fontWeight: FontWeight.w600
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "${taskController.selectedTask.taskDescription}",
                      style: TextStyle(
                          fontSize: 15,
                          color: Constants.black,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),


                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date : ",
                    // "Rs. ${orderController.selectedOrderData.paymentAmount}",
                    style: TextStyle(
                        fontSize: 15,
                        color: Constants.black,
                        // fontWeight: FontWeight.w600
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "${taskController.selectedTask.taskDate}",
                      style: TextStyle(
                          fontSize: 15,
                          color: Constants.black,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),


                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Time : ",
                    // "Rs. ${orderController.selectedOrderData.paymentAmount}",
                    style: TextStyle(
                        fontSize: 15,
                        color: Constants.black,
                        // fontWeight: FontWeight.w600
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "${taskController.selectedTask.taskTime}",
                      style: TextStyle(
                          fontSize: 15,
                          color: Constants.black,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),


                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }


}
