
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

import '../constants/colors.dart';
import '../models/stateResponseModel.dart';



class StateDropdown extends StatefulWidget {
  final Map<String,dynamic>? selectedValue;
  final double devicewidth;
  final RxList options;
  final ValueChanged<dynamic?> onChanged;

  const StateDropdown({
    Key? key,
    required this.selectedValue,
    required this.devicewidth,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<StateDropdown> createState() => _StateDropdownState();
}

class _StateDropdownState extends State<StateDropdown> {


  @override
  void initState() {
    super.initState();

  }
  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
    // color: Colors.green,
    height: 60,
    decoration: BoxDecoration(
        border: Border.all(color: kGreyShade3),
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(15),)
    ),
    child: ListView(

        children: [
          DropdownButton<dynamic?>(

            //menuMaxHeight: 300,
            isDense: true,
            isExpanded: true,
            //icon: SvgPicture.asset(dropdwnicon ?? LocalSVGImages.dropdwn),
            value: widget.selectedValue,
            iconSize: 35,
            hint: Text('Select State', style: Theme
                .of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(
              color: kGreyShade3,
            ),),

            //dropdownColor: Colors.grey[200],
            underline: Container(height: 1, color: Colors.white,),
            padding: const EdgeInsets.all(8.0),
            selectedItemBuilder: (BuildContext context) {
              return widget.options.map((dynamic? value) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      height: 60,
                      width: widget.devicewidth,
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectedValue?["name"] ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList();
            },


            items: widget.options.map((dynamic? value) {
              return DropdownMenuItem<dynamic?>(

                value: value,
                child: Container(

                    width: widget.devicewidth,
                    child: Text(value?["name"] ?? "")),
              );
            }).toList(),
            onChanged: widget.onChanged,
          ),
        ]
    ),
        );
  }

}