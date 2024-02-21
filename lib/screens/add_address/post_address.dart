import 'package:flutter/material.dart';

import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import '../../widgets/common_textfield_withicon.dart';

class PostAddressPage extends StatefulWidget {
  const PostAddressPage({super.key});

  @override
  State<PostAddressPage> createState() => _PostAddressPageState();
}

class _PostAddressPageState extends State<PostAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BackButtonLS(),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Add Your Address',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(17),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Address Line 1"),
              SizedBox(
                height: 50,
                child: CustomTextFieldicon(
                    textInputType: TextInputType.name,
                    txtalign: TextAlign.left,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter current address';
                      }
                      return null;
                    },
                    labelicon: Icons.home_outlined,
                    hintText: 'Current Address',
                    controller: TextEditingController()),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                child: CustomTextFieldicon(
                    textInputType: TextInputType.name,
                    txtalign: TextAlign.left,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter current address';
                      }
                      return null;
                    },
                    labelicon: Icons.home_outlined,
                    hintText: 'Current Address',
                    controller: TextEditingController()),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                child: CustomTextFieldicon(
                    textInputType: TextInputType.name,
                    txtalign: TextAlign.left,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter current address';
                      }
                      return null;
                    },
                    labelicon: Icons.home_outlined,
                    hintText: 'Current Address',
                    controller: TextEditingController()),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                child: CustomTextFieldicon(
                    textInputType: TextInputType.name,
                    txtalign: TextAlign.left,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter current address';
                      }
                      return null;
                    },
                    labelicon: Icons.home_outlined,
                    hintText: 'Current Address',
                    controller: TextEditingController()),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                child: CustomTextFieldicon(
                    textInputType: TextInputType.name,
                    txtalign: TextAlign.left,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter current address';
                      }
                      return null;
                    },
                    labelicon: Icons.home_outlined,
                    hintText: 'Current Address',
                    controller: TextEditingController()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
