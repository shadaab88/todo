import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/utils/route_generator.dart';
import 'package:todo/view/splash_screen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthController(),
        ),

        ChangeNotifierProvider.value(
          value: TaskController(),
        ),


      ],
      child: GetMaterialApp(
        title: 'TODO',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreen.id,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}


