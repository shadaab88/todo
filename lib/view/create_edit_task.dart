import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/custom_container.dart';
import 'package:todo/utils/my_text_field.dart';
import 'package:todo/utils/utility.dart';

class CreateEditTask extends StatelessWidget {
  static const id = "CreateEditTask";

  late TaskController taskController;
  @override
  Widget build(BuildContext context) {
    taskController = Provider.of<TaskController>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "${taskController.whichPage} Task",
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


              },
              child: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Constants.black,
              ),
              backgroundColor: Constants.white,
              mini: true,

            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: taskController.taskDetailsFormKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      "Task Name",
                      style: TextStyle(
                          fontSize: 15,
                          color: Constants.black,
                          fontWeight: FontWeight.w600
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    MyTextField(
                      // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      controller: taskController.taskNameController,
                      borderRadius: 5,
                      isFilled: true,
                      // elevation: 0,
                      fillColor: Constants.primary,
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      onChanged: (value) {},
                      // labelStyle: const TextStyle(
                      //     fontSize: 15,
                      //     color: Constants.accentColor
                      // ),
                      hintTextStyle: const TextStyle(
                          fontSize: 15,
                          color: Constants.black,
                          fontWeight: FontWeight.w400
                      ),
                      borderColor: Constants.grey,
                      labelText: 'Task Name',
                      hintText: "Task Name",
                      // isLabelEnabled: false,
                      overrideHintText: true,
                      // hintTextStyle: TextStyles.hintStyle,
                      focusedBorderColor: Constants.secondaryColor,
                      isPasswordField: false,
                      borderWidth: 1,
                      // leading: const Icon(
                      //   Icons.subject,
                      //   color: Constant.textColorDescription,
                      //   size: 25,
                      // ),
                      isEnabled: true,
                      // showLeadingWidget: true,
                      textStyle: const TextStyle(
                          fontSize: 15,
                          color: Constants.black
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Task name";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "Task Description",
                      style: TextStyle(
                          fontSize: 15,
                          color: Constants.black,
                          fontWeight: FontWeight.w600
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    MyTextField(
                      // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      controller: taskController.taskDescriptionController,
                      borderRadius: 5,
                      isFilled: true,
                      maxLength: 200,
                      // elevation: 0,
                      fillColor: Constants.primary,
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      onChanged: (value) {},
                      // labelStyle: const TextStyle(
                      //     fontSize: 15,
                      //     color: Constants.accentColor
                      // ),
                      borderColor: Constants.grey,
                      labelText: 'Enter Task Description',
                      hintText: "Enter Task Description",
                      // isLabelEnabled: false,
                      overrideHintText: true,
                      hintTextStyle: const TextStyle(
                          fontSize: 15,
                          color: Constants.black,
                          fontWeight: FontWeight.w400
                      ),
                      // hintTextStyle: TextStyles.hintStyle,
                      focusedBorderColor: Constants.secondaryColor,
                      isPasswordField: false,
                      borderWidth: 1,
                      // leading: const Icon(
                      //   Icons.subject,
                      //   color: Constant.textColorDescription,
                      //   size: 25,
                      // ),
                      isEnabled: true,
                      // showLeadingWidget: true,
                      textStyle: const TextStyle(
                          fontSize: 15,
                          color: Constants.black
                      ),
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Task Description";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "Task Date",
                      style: TextStyle(
                          fontSize: 15,
                          color: Constants.black,
                          fontWeight: FontWeight.w600
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    CustomContainer(
                      onTap: () async {
                        DateTime tempDate = await _selectDate(context);
                        taskController.taskDate =
                            DateFormat('yyyy-MM-dd').format(tempDate);

                      },
                      padding: 0,
                      margin: EdgeInsets.zero,
                      borderColor: Constants.grey,
                      height: 50.0,
                      borderWidth: 1,

                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (taskController.taskDate != "")
                                ? Text(
                                "   ${taskController.taskDate}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Constants.black,
                                )
                            )
                                : Text(
                                "   Select Task Date",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Constants.black,
                                )
                            ),
                            SvgPicture.asset("assets/svg/calendar_icon.svg")
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "Task Time",
                      style: TextStyle(
                          fontSize: 15,
                          color: Constants.black,
                          fontWeight: FontWeight.w600
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    CustomContainer(
                      onTap: () async {
                        TimeOfDay tempTime = await _selectTime(context);
                        taskController.taskTime =
                            MaterialLocalizations.of(context)
                                .formatTimeOfDay(tempTime);


                      },
                      padding: 0,
                      margin: EdgeInsets.zero,
                      borderColor: Constants.grey,
                      height: 50.0,
                      borderWidth: 1,

                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (taskController.taskTime != "")
                                ? Text(
                                "   ${taskController.taskTime}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Constants.black,
                                )
                            )
                                : Text(
                                "   Select Task Time",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Constants.black,
                                )
                            ),
                            SvgPicture.asset("assets/svg/clock_icon.svg")
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: Constants.white,
        height: 100,
        child: Center(
          child: CustomContainer(
            onTap: () async {
              if (taskController.taskDetailsFormKey.currentState!.validate()) {
                taskController.taskDetailsFormKey.currentState!.save();
                if(taskController.taskDate == ""){
                  Utility.showSingleTextToast("Please enter task date");

                }else{
                  if(taskController.taskTime == ""){
                    Utility.showSingleTextToast("Please enter task time");
                  }else{
                    // bool check = true;
                    if(taskController.whichPage == "Create"){
                      bool check = await taskController.saveTaskDetails();
                      if(check == true){
                        Navigator.pop(context);
                        Utility().showSuccessMessage("Saved Successfully",msg:
                        "Your Task Saved Successfully");
                      }
                    }else{
                      bool check = await taskController.updateTaskDetails(taskController.selectedTask);
                      if(check == true){
                        Navigator.pop(context);
                        Utility().showSuccessMessage("Update Successfully",msg:
                        "Your Task Updated Successfully");
                      }
                    }

                  }


                }

              }
            },
            backgroundColor: Constants.black,
            borderRadius: 5,
            height: 50,
            width: MediaQuery.of(context).size.width*0.9,
            child: const Center(
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Constants.primary,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (picked != null) {
      return picked;
    } else {
      return DateTime.now();
    }
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,

      // initialDate: selectedDate,
      // firstDate: DateTime(2015, 8),
      // lastDate: DateTime(2101)
    );
    if (picked != null && picked != selectedTime) {
      return picked;
    } else {
      return TimeOfDay.now();
    }
  }
}
