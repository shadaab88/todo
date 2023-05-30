
import 'package:flutter/material.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/custom_container.dart';
import 'package:todo/utils/my_text_field.dart';
import 'package:todo/utils/utility.dart';
import 'package:todo/view/home_screen.dart';
import 'package:todo/view/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const id = "LoginScreen";

  late AuthController authController;
  @override
  Widget build(BuildContext context) {
    authController = Provider.of<AuthController>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants.white,

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Text ("Login", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: 20,),
                    Text("Welcome back ! Login with your credentials",style: TextStyle(
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
                  child: Form(
                      key: authController.loginFormKey,
                      child: Column(
                      children: [
                        MyTextField(
                          controller: authController.loginEmailController,
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

                        MyTextField(
                          controller: authController.loginPasswordController,
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

                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                CustomContainer(
                  onTap: () async {
                    if (authController.loginFormKey.currentState!.validate()) {
                      authController.loginFormKey.currentState!.save();
                      String check = await authController.login();

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
                    }
                  },
                  height: 60,
                  width: MediaQuery.of(context).size.width*0.8,
                  backgroundColor: Constants.buttonColor,
                  borderRadius: 50,
                  elevation: 5,
                  child: Center(
                    child: Text(
                      "Login",
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
                        "Dont have an account?",
                      style: TextStyle(
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
                            SignupScreen.id,
                                (Route<dynamic> route) => false
                        );

                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                      ),),
                    ),
                  ],
                )
              ],

            ),
          ],
        ),
      ),
    );
  }
}


