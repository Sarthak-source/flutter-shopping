import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import '../map_screen.dart';

class AddAddressScreen extends StatelessWidget {
  static const routeName = '/add_address_screen';

  const AddAddressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(
                getProportionateScreenWidth(18),
              ),
              child: Container(
              //  color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButtonLS(),
                    Text(
                      'Add Your Address',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(17),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 15,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:ListTile(
                          title:  Text("GoFlamingo"),
                          subtitle: Column(
                            children: [
                              Text("No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001"),
                              Divider(),
                            ],
                          ),
                          leading: Icon(Icons.add),
                        ),


                      );
                    }),
              ),
            )
          ]
          ,
        ),
      ),
    );
  }
}
