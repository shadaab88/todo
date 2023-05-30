import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/custom_container.dart';
import 'package:todo/utils/session_manager.dart';
import 'package:todo/view/login.dart';
import '../controllers/auth_controller.dart';

class SideMenu extends StatefulWidget {

  static final id = "SideMenu";
  SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  late AuthController authController;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authController = Provider.of<AuthController>(context, listen: true);
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // DrawerHeader(
                //
                //   child: drawerHeader(context),
                // ),

                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 18.0,right: 18),
                  child: drawerHeader(context),
                ),

                SizedBox(
                  height: 10,
                ),

                Divider(
                  height: 10,
                  color: Constants.backGrey,
                  thickness: 1.5,
                ),



                Padding(
                  padding: const EdgeInsets.only(top: 22.0, left: 18.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.home,
                          size: 22,
                        ),
                        // SvgPicture.asset(
                        //   "assets/svg/logout.svg",
                        //   height: 22,
                        //   width: 22,
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),



                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: CustomContainer(
                    backgroundColor: Colors.transparent,
                    // backgroundColor: Constants.imageBackground,
                    // height: MediaQuery.of(context).size.height * 0.45,
                    child: Column(
                      children: [

                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.04,
                        ),



                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.03,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Align(
              alignment: FractionalOffset.bottomCenter,
              child: drawerBottom(context)
          ),
        ],
      ),
    );
  }

  Widget drawerBottom(context){
    return Padding(
      padding: const EdgeInsets.only(left: 18.0,right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          SizedBox(
            height: 15,
          ),

          CustomContainer(
            onTap: () async {
              Navigator.pop(context);
              logoutDialog(context);

            },
            paddingEdge: EdgeInsets.zero,
            padding: 0,
            margin: EdgeInsets.zero,
            height: 40,
            width: double.infinity,
            backgroundColor: Constants.black,

            child: Center(
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Future logoutDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "TODO",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Constants.accentColor,
            ),
          ),
          content: const Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Constants.accentColor,
            ),
          ),
          actions: <Widget>[
            CustomContainer(
                padding: 10,
                margin: EdgeInsets.all(10),
                onTap: () async {
                  SessionManager.saveUserId("");
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginScreen.id,
                          (Route<dynamic> route) => false
                  );
                },
                child: const Text("Yes", style: TextStyle(color: Constants.accentColor, fontWeight: FontWeight.bold, fontSize: 15))),
            CustomContainer(
                padding: 10,
                margin: EdgeInsets.all(10),
                onTap: () => Navigator.pop(context, false),
                child: const Text(
                  "No",
                  style: TextStyle(color: Constants.accentColor, fontWeight: FontWeight.bold, fontSize: 15),
                )),
          ],
        ));
  }

  Widget drawerHeader(context) {
    return Column(children: [
      GestureDetector(
        onTap: () {

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){

              },
              child: Row(
                children: [
                  CustomContainer(
                    width: 40,
                    height: 40,
                    borderRadius: 20,
                    backgroundColor: Constants.secondaryColor,
                    child: Icon(
                      Icons.person,
                      size: 22,
                    ),
                    // child: Image.asset(
                    //   "assets/img/no_profile_image.png",
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CustomContainer(
                    onTap: () {

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${authController.userData.fullName}",
                            // "Rakesh Mishra",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Constants.black
                            )),

                        SizedBox(
                          height: 2,
                        ),

                        Text("${authController.userData.email}",
                            style: TextStyle(
                                fontSize: 14,
                                color: Constants.black
                            )),
                      ],
                    ),
                  ),


                ],
              ),
            ),
            // InkWell(
            //   onTap: () {
            //
            //   },
            //   child: SvgPicture.asset(
            //     "assets/svg/edit_icon.svg",
            //     height: 22,
            //     width: 22,
            //   ),
            // )
          ],
        ),
      ),

      // SizedBox(
      //   height: 10,
      // ),
      //
      // CustomContainer(
      //   borderRadius: 10,
      //   borderColor: Constants.grey,
      //   child: Padding(
      //     padding: const EdgeInsets.all(12.0),
      //     child: Column(
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: const [
      //             Text(
      //               "Complete your profile",
      //               style: TextStyle(
      //                   fontSize: 12,
      //                   color: Constants.black
      //               ),
      //             ),
      //
      //             Text(
      //               "30% Complete",
      //               style: TextStyle(
      //                   fontSize: 12,
      //                   color: Constants.accentColor
      //               ),
      //             )
      //           ],
      //         ),
      //
      //         const SizedBox(
      //           height: 10,
      //         ),
      //
      //         Stack(
      //           children: [
      //             CustomContainer(
      //               borderRadius: 10,
      //               padding: 0,
      //               paddingEdge: EdgeInsets.zero,
      //               margin: EdgeInsets.zero,
      //               height: 5,
      //               width: MediaQuery.of(context).size.width*0.6,
      //               backgroundColor: Constants.fourthColor,
      //             ),
      //
      //             CustomContainer(
      //               borderRadius: 10,
      //               padding: 0,
      //               paddingEdge: EdgeInsets.zero,
      //               margin: EdgeInsets.zero,
      //               height: 5,
      //               width: MediaQuery.of(context).size.width*0.6*0.3,
      //               backgroundColor: Constants.secondaryColor,
      //             )
      //           ],
      //         )
      //       ],
      //     ),
      //   ),
      // )
    ]);
  }
}
