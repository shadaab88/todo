import 'package:flutter/material.dart';
import 'package:todo/view/create_edit_task.dart';
import 'package:todo/view/home_screen.dart';
import 'package:todo/view/login.dart';
import 'package:todo/view/signup.dart';

import '../view/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings? settings) {
    final args = settings!.arguments;
    print("PUSHED ${settings.name} WITH ARGS: ${settings.arguments}");
    switch (settings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );

      case LoginScreen.id:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );

      case SignupScreen.id:
        return MaterialPageRoute(
          builder: (context) => SignupScreen(),
        );

      case HomeScreen.id:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );

      case CreateEditTask.id:
        return MaterialPageRoute(
          builder: (context) => CreateEditTask(),
        );

      default:
        return _errorRoute(settings.name!);
    }
  }

  static Route<dynamic> _errorRoute(String name) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ROUTE \n\n$name\n\nNOT FOUND'),
        ),
      );
    });
  }
}