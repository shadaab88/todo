
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/my_text_field.dart';
import 'package:todo/view/home_screen.dart';
import 'package:todo/view/login.dart';
import 'package:flutter/cupertino.dart';
import '../utils/custom_container.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/utility.dart';

class SignupScreen extends StatelessWidget {
  static const id = "SignupScreen";

  late AuthController authController;
  @override
  Widget build(BuildContext context) {

    authController = Provider.of<AuthController>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Form(
                  key: authController.registerFormKey,
                  child: Column(

                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text ("Sign up", style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 20,),
                          Text("Create an Account,Its free",style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),),
                          SizedBox(height: 30,)
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40
                        ),
                        child: Column(
                          children: [

                            MyTextField(
                              controller: authController.registerNameController,
                              borderRadius: 50,
                              focusedBorderColor: Constants.secondaryColor,
                              borderColor: Constants.black,
                              labelText: "Full Name",
                              onChanged: (value) {

                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Full Name";
                                }
                                return null;
                              },
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            MyTextField(
                              controller: authController.registerEmailController,
                              borderRadius: 50,
                                focusedBorderColor: Constants.secondaryColor,
                                borderColor: Constants.black,
                                labelText: "Email",
                                onChanged: (value) {

                                },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Email";
                                }
                                const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                                    r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                                    r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                                    r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                                    r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                                    r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                                    r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                                final regex = RegExp(pattern);
                                if(!regex.hasMatch(value)){
                                  return "Enter valid Email";
                                }
                                return null;
                              },
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            CustomContainer(
                              onTap: () async {
                                DateTime tempDate = await _selectDate(context);
                                authController.selectedDateOfBirth =
                                    DateFormat('yyyy-MM-dd').format(tempDate);

                              },
                              padding: 0,
                              margin: EdgeInsets.zero,
                              borderColor: Constants.black,
                              height: 50.0,
                              borderWidth: 1.5,
                              borderRadius: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    (authController.selectedDateOfBirth != "")
                                        ? Text(
                                      "   ${authController.selectedDateOfBirth}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Constants.black,
                                      )
                                    )
                                        : Text(
                                      "   Select Date Of Birth",
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
                            SizedBox(
                              height: 10,
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height*0.02,
                                  child: FittedBox(
                                    child: const Text(
                                      "Gender",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Constants.black,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomContainer(
                                      borderRadius: 50,
                                      borderWidth: 1.5,
                                      onTap: () {
                                        authController.selectedGender = "Male";
                                      },
                                      borderColor: (authController.selectedGender == "Male")
                                          ? Constants.secondaryColor
                                          : Constants.black,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25, top: 10, bottom: 10),
                                        child: Text(
                                          "Male",
                                          style:
                                          TextStyle(fontSize: 16, color: Constants.black),
                                        ),
                                      ),
                                    ),
                                    CustomContainer(
                                      borderRadius: 50,
                                      borderWidth: 1.5,
                                      onTap: () {
                                        authController.selectedGender = "Female";
                                      },
                                      borderColor: (authController.selectedGender == "Female")
                                          ? Constants.secondaryColor
                                          : Constants.black,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25, top: 10, bottom: 10),
                                        child: Text(
                                          "Female",
                                          style:
                                          TextStyle(fontSize: 16, color: Constants.black),
                                        ),
                                      ),
                                    ),
                                    CustomContainer(
                                      borderRadius: 50,
                                      borderWidth: 1.5,
                                      onTap: () {
                                        authController.selectedGender = "Other";
                                      },
                                      borderColor: (authController.selectedGender == "Other")
                                          ? Constants.secondaryColor
                                          : Constants.black,
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25, top: 10, bottom: 10),
                                        child: Text(
                                          "Other",
                                          style:
                                          TextStyle(fontSize: 16, color: Constants.black),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),



                            SizedBox(
                              height: 10,
                            ),
                            MyTextField(
                              controller: authController.registerPasswordController,
                              borderRadius: 50,
                                isPasswordField: true,
                                focusedBorderColor: Constants.secondaryColor,

                                borderColor: Constants.black,
                                labelText: "Password",
                                onChanged: (value) {

                                },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Password";
                                }
                                return null;
                              },
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            MyTextField(
                              controller: authController.registerConfirmPasswordController,
                              borderRadius: 50,
                                isPasswordField: true,
                                focusedBorderColor: Constants.secondaryColor,

                                borderColor: Constants.black,
                                labelText: "Confirm Password",
                                onChanged: (value) {

                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                  return "Enter Password";
                                  }
                                  return null;
                                  },
                            ),


                          ],
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      CustomContainer(
                        onTap: () async {

                          if (authController.registerFormKey.currentState!
                              .validate()) {
                            authController.registerFormKey.currentState!
                                .save();
                            if(authController.registerPasswordController.text != authController.registerConfirmPasswordController.text){
                              Utility().showErrorMessage("Password Does not Match");
                            }else{
                              if(authController.selectedDateOfBirth == ""){
                                Utility().showErrorMessage("Select Date Of Birth");

                              }else{
                                if (authController.selectedGender != "") {
                                  // bool check = 'true';
                                  String check = await authController.registerProfile();
                                  if (check == 'success') {
                                    Utility().showSuccessMessage(
                                        "Profile Register successfully",
                                        msg: "Your profile data is securely saved");

                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        HomeScreen.id,
                                            (Route<dynamic> route) => false
                                    );

                                  } else {
                                    Utility().showErrorMessage("Error",
                                        msg: check);
                                  }
                                } else {
                                  Utility().showErrorMessage("Select Gender");
                                }
                              }
                            }


                          }
                        },
                        height: 60,
                        width: MediaQuery.of(context).size.width*0.8,
                        backgroundColor: Constants.buttonColor,
                        borderRadius: 50,
                        elevation: 5,
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Constants.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "Already have an account? ",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18
                            ),
                          ),

                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  LoginScreen.id,
                                      (Route<dynamic> route) => false
                              );

                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      )
                    ],

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now().subtract(const Duration(days: 2920));
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(const Duration(days: 21900)),
        lastDate: DateTime.now().subtract(const Duration(days: 2920)));
    if (picked != null) {
      return picked;
    } else {
      return DateTime.now().subtract(const Duration(days: 2920));
    }
  }
}


