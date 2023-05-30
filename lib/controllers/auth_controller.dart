import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/api/database.dart';
import 'package:todo/model/user_data_response.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/session_manager.dart';

import '../utils/utility.dart';

class AuthController extends ChangeNotifier {

  String _selectedDateOfBirth = "";

  String get selectedDateOfBirth => _selectedDateOfBirth;

  set selectedDateOfBirth(String value) {
    _selectedDateOfBirth = value;
    notifyListeners();
  }

  String _selectedGender = "";

  String get selectedGender => _selectedGender;

  set selectedGender(String value) {
    _selectedGender = value;
    notifyListeners();
  }

  final registerFormKey = GlobalKey<FormState>();

  TextEditingController _registerNameController = TextEditingController();


  TextEditingController get registerNameController => _registerNameController;

  set registerNameController(TextEditingController value) {
    _registerNameController = value;
    notifyListeners();
  }

  TextEditingController _registerEmailController = TextEditingController();

  TextEditingController get registerEmailController => _registerEmailController;

  set registerEmailController(TextEditingController value) {
    _registerEmailController = value;
    notifyListeners();
  }

  TextEditingController _registerPasswordController = TextEditingController();

  TextEditingController get registerPasswordController =>
      _registerPasswordController;

  set registerPasswordController(TextEditingController value) {
    _registerPasswordController = value;
    notifyListeners();
  }

  TextEditingController _registerConfirmPasswordController = TextEditingController();

  TextEditingController get registerConfirmPasswordController =>
      _registerConfirmPasswordController;

  set registerConfirmPasswordController(TextEditingController value) {
    _registerConfirmPasswordController = value;
    notifyListeners();
  }

  final loginFormKey = GlobalKey<FormState>();

  TextEditingController _loginEmailController = TextEditingController();

  TextEditingController get loginEmailController => _loginEmailController;

  set loginEmailController(TextEditingController value) {
    _loginEmailController = value;
    notifyListeners();
  }

  TextEditingController _loginPasswordController = TextEditingController();

  TextEditingController get loginPasswordController => _loginPasswordController;

  set loginPasswordController(TextEditingController value) {
    _loginPasswordController = value;
    notifyListeners();
  }

  UserDataResponse _userData = UserDataResponse();

  UserDataResponse get userData => _userData;

  set userData(UserDataResponse value) {
    _userData = value;
    notifyListeners();
  }

  Future<String> registerProfile() async {
    Utility.showLoadingDialog();

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerEmailController.text,
          password: registerPasswordController.text
      ).catchError((onError){
        Utility.hideLoadingDialog();
        return onError.toString();
      });

      UserDataResponse user = UserDataResponse();
      user.id = userCredential.user!.uid;
      user.fullName = registerNameController.text;
      user.email = registerEmailController.text;
      user.dateOfBirth = selectedDateOfBirth;
      user.gender = selectedGender;
      user.password = registerPasswordController.text;

      print("below user credential");
      print(userCredential.user!.uid);

      await DatabaseService(uid: userCredential.user!.uid).uploadUserData(user).then((value){


        SessionManager.saveUserId(userCredential.user!.uid);
        Constants.userId = userCredential.user!.uid;
        userData = user;

      });


      Utility.hideLoadingDialog();
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utility.hideLoadingDialog();
        print('The password provided is too weak.');
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        Utility.hideLoadingDialog();
        print('The account already exists for that email.');
        return 'The account already exists for that email.';
      }
    } catch (e) {
      Utility.hideLoadingDialog();
      print(e);
      return e.toString();
    }

    return 'something went wrong';
  }

  Future<String> login() async {

    Utility.showLoadingDialog();

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginEmailController.text,
          password: loginPasswordController.text
      ).catchError((onError){
        Utility.hideLoadingDialog();
        return onError.toString();
      });



      print("below user credential");
      print(userCredential.user!.uid);

      await DatabaseService(uid: userCredential.user!.uid).getUserData().then((value){
        userData = UserDataResponse.fromJson(
            jsonDecode(jsonEncode(value.data())));

        SessionManager.saveUserId(userCredential.user!.uid);
        Constants.userId = userCredential.user!.uid;

      });


      Utility.hideLoadingDialog();
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utility.hideLoadingDialog();
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        Utility.hideLoadingDialog();
        return 'Wrong password provided for the user.';
      }

    } catch (e) {
      Utility.hideLoadingDialog();
      print("error from");
      print(e);
      // return e.toString();
      return "email or password is wrong";
    }
    return 'something went wrong';
  }
}