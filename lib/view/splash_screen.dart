import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/api/database.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/model/user_data_response.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/session_manager.dart';
import 'package:todo/view/home_screen.dart';
import 'package:todo/view/login.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const id = "SplashScreen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    handleStartUpLogic();


  }

  late AuthController authController;

  handleStartUpLogic() async {
    // SharedPreferences.setMockInitialValues({});
    await Future.delayed(const Duration(milliseconds: 1000), () async {

      Constants.userId = await SessionManager.getUserId() ?? "";
      print("below is userid");
      print(Constants.userId);
      if(Constants.userId == ""){
        Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.id,
                (Route<dynamic> route) => false
        );
      }else{
        await DatabaseService(uid: Constants.userId).getUserData().then((value){

          authController.userData = UserDataResponse.fromJson(
              jsonDecode(jsonEncode(value.data())));



        });
        Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.id,
                (Route<dynamic> route) => false
        );
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    authController = Provider.of<AuthController>(context, listen: true);
    return Scaffold(
      backgroundColor: Constants.white,
      body: Center(
        child: Image.asset(
            "assets/img/splash_logo.png",
            fit: BoxFit.cover
        ),
      ),
    );
  }
}
