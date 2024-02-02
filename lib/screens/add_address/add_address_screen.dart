import 'package:flutter/material.dart';

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
          children: [
            const BackButtonLS(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Add New Address',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(MapScreen.routeName);
                          },
                          child: Image.asset('assets/images/map.png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Row(
                      children: [
                        FittedBox(
                          child: Text(
                            'We will find a grocery near your home address',
                            style: TextStyle(
                              color: kTextColorAccent,
                              fontSize: getProportionateScreenWidth(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    //SearchBar('Enter Address'),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    const Divider(),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Expanded(
                      child: ListTile(
                        leading: Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(8),
                              ),
                            ),
                            color: kPrimaryBlue,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              getProportionateScreenWidth(8),
                            ),
                            child: Icon(
                              Icons.location_on_outlined,
                              size: getProportionateScreenWidth(28),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text(
                          'Current Location',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(20),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: const Text(
                          'Planet Namex Street 989',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
