import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';
import 'package:sutra_ecommerce/widgets/back_button_ls.dart';

class SelectTime extends StatefulWidget {
  static const routeName = '/select_time_screen';

  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  DateTime _selectedDate = DateTime.now(); // Step 1
  int selectedIndex = -1;
  final UserController userCtlr = Get.put(UserController());
  final MyCartController createOrderCtlr = Get.put(MyCartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getProportionateScreenWidth(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const BackButtonLS(),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Add your time of delivery',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(17),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: kPrimaryBlue,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedDate = date;
                });
              },
              height: 100,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: iconList.length,
                  itemBuilder: (BuildContext context, int position) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = position;
                        });
                      },
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: Card(
                          shape: (selectedIndex == position)
                              ? RoundedRectangleBorder(
                                  side: const BorderSide(color: kPrimaryBlue),
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust border radius as needed
                                )
                              : RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust border radius as needed
                                ),
                          elevation: 0,
                          color: (selectedIndex == position)
                              ? kPrimaryBlue
                              : null, // Set background color
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                iconList[position].iconName,
                                color: (selectedIndex == position)
                                    ? Colors.white
                                    : null, // Set icon color
                              ),
                              Text(
                                iconList[position].titleIcon,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: (selectedIndex == position)
                                      ? Colors.white
                                      : null, // Set text color
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              onPressed: () {
                //Get.toNamed(AddAddressScreen.routeName);
                Map storedUserData = box!.get('userData');
               // print('userdata in select time ${storedUserData['party']['address']['id'].toString()}');
                String address = "${storedUserData['party']['address'] != null?storedUserData['party']['address']['id'].toString():""}";
                log('selected address: ${userCtlr.user}');
                log('selected address: $address');
                log('selectedIndex ${(selectedIndex+1).toString()}');
                if(address == null|| address ==""){
                  Fluttertoast.showToast(
                    msg: 'Enter Address',
                    backgroundColor: Colors.red,
                  );
                }else{
                  createOrderCtlr.createOrderApi(
                      "1", (selectedIndex+2).toString(), _selectedDate.toString(), address);
                }

                //_selectDate(context); // Step 2
              },
              child: Column(
                children: [
                  const Text(
                    'Submit',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    selectedIndex == 1
                        ? 'Evening of ${_selectedDate.month}-${_selectedDate.day}-${_selectedDate.year}'
                        : 'Morning of ${_selectedDate.month}-${_selectedDate.day}-${_selectedDate.year}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}

class IconMenu {
  final IconData iconName;
  final String titleIcon;
  IconMenu({required this.iconName, required this.titleIcon});
}

List<IconMenu> iconList = [
  IconMenu(iconName: Icons.sunny, titleIcon: "Morning"),
  IconMenu(iconName: Icons.nightlight, titleIcon: "Evening"),
];
