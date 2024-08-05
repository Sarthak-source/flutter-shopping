import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';
import 'package:sutra_ecommerce/screens/landing_screen.dart';
import 'package:sutra_ecommerce/screens/notification/notification.dart'
    as notificationpage;

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/image_container.dart';
import '../my_profile_screen.dart';
import '../myorders_screen.dart';

class UserScreen extends StatelessWidget {
  final UserController? userController = Get.put(UserController());

  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(userController?.user.toString() ?? "sss");
    }
    return Obx(() {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16.0),
          ),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              const ImageContainer(),
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              // const AddButton(),
              // ...

// ...

              //  CustomPaint(
              //     size: const Size(100, 100),
              //     painter: EveningPainter(),
              //   ),
              Text(
                userController?.user != null &&
                        userController?.user.toString() != "{}"
                    ? userController!.user['party']['party_name'] != null
                        ? userController!.user['party']['party_name'].toString()
                        : ""
                    : "",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                userController?.user != null &&
                        userController?.user.toString() != "{}"
                    ? userController!.user['party']['email'].toString()
                    : "",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kTextColorAccent,
                    ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(40.0),
              ),
              ProfileCard(
                image: 'assets/images/profile_user.png',
                color: kPrimaryBlue.withOpacity(0.2),
                title: 'My Profile',
                tapHandler: () {
                  Get.toNamed(MyProfileScreen.routeName);
                },
              ),
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              // ProfileCard(
              //   image: 'assets/images/profile_user.png',
              //   color: kAccentGreen,
              //   title: 'Select time',
              //   tapHandler: () {
              //     Get.toNamed(SelectTime.routeName);
              //   },
              // ),
              // SizedBox(
              //   height: getProportionateScreenHeight(8.0),
              // ),
              // ProfileCard(
              //   image: 'assets/images/map_user.png',
              //   color: kAccentTosca,
              //   title: 'My Address',
              //   tapHandler: () {
              //     Get.toNamed(AddAddressScreen.routeName);
              //   },
              // ),
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              ProfileCard(
                image: 'assets/images/noti_user.png',
                color: kPrimaryBlue.withOpacity(0.2),
                title: 'Notification',
                tapHandler: () {
                  // Navigator.of(context).pushNamed(MyOrders.routeName);
                  Get.toNamed(notificationpage.Notification.routeName);
                },
              ),
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              // ProfileCard(
              //   image: 'assets/images/check_user.png',
              //   color: kPrimaryBlue.withOpacity(0.2),
              //   title: 'Help Center',
              // ),
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              ProfileCard(
                image: 'assets/images/arrow_user.png',
                color: kPrimaryBlue.withOpacity(0.2),
                title: 'My Orders',
                tapHandler: () {
                  // Navigator.of(context).pushNamed(MyOrders.routeName);
                  Get.toNamed(MyOrders.routeName);
                },
              ),
              /*    SizedBox(
                  height: getProportionateScreenHeight(8.0),
                ),
                ProfileCard(
                    image: 'assets/images/arrow_user.png',
                    color: kPrimaryBlue.withOpacity(0.2),
                    title: 'Payment',
                    tapHandler: () {
                      Get.toNamed(PaymentScreen.routeName);
                    }),*/
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              ProfileCard(
                  image: 'assets/images/arrow_user.png',
                  color: kPrimaryBlue.withOpacity(0.2),
                  title: 'Delete Account',
                  tapHandler: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete Account"),
                          content: const Text("Are you sure?"),
                          actions: [
                            TextButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text("Ok"),
                              onPressed: () async {
                                log(box!.get('userData').toString());
                                //userController!.update();
                                log(box!.get('userData').toString());

                                box!.deleteFromDisk();
                                
                                log(box!.get('userData').toString());

                                SystemNavigator.pop();

                                if (context.mounted) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LandingScreen()));
                                }


                                //Get.toNamed(IntroScreen.routeName);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const PendingPayment()));
                  }),

              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              ProfileCard(
                  image: 'assets/images/arrow_user.png',
                  color: kPrimaryBlue.withOpacity(0.2),
                  title: 'Log Out',
                  tapHandler: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Log out"),
                          content: const Text("Are you sure?"),
                          actions: [
                            TextButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text("Ok"),
                              onPressed: () async {
                                log(box!.get('userData').toString());
                                userController!.update();
                                log(box!.get('userData').toString());
                                box = await Hive.openBox('Box');
                                await Hive.deleteBoxFromDisk('Box');

                                if (!context.mounted) return;
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const LandingScreen()),
                                    ModalRoute.withName('/'));

                                /*   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LandingScreen()));*/

                                //Get.toNamed(IntroScreen.routeName);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }),
              const Spacer(),
              Text(
                'ver 1.01',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: kTextColorAccent,
                    ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              )
            ],
          ),
        ),
      );
    });
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.image,
    required this.title,
    this.tapHandler,
    required this.color,
  });

  final String image;
  final String title;
  final Function()? tapHandler;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapHandler,
      child: Container(
        padding: EdgeInsets.all(
          getProportionateScreenWidth(8.0),
        ),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(8.0),
                ),
                decoration: ShapeDecoration(
                  color: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(8.0),
                    ),
                  ),
                ),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    kPrimaryBlue, // Adjust opacity as needed
                    BlendMode
                        .srcIn, // Choose blend mode according to your requirement
                  ),
                  child: Image.asset(image),
                )),
            SizedBox(
              width: getProportionateScreenWidth(8.0),
            ),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
