import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sutra_ecommerce/constants/colors.dart';

class AddButton extends StatefulWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  int quantity = 0;
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return quantity == 0
        ? SizedBox(
            width: 70,
            height: 32,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                    color: kPrimaryBlue), // Specify the border color here
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the border radius as needed
                ),
              ),
              onPressed: () {
                setState(() {
                  quantity = 1;
                });
              },
              child: const Text('Add'),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(5), // Set the border radius here
              border: Border.all(
                color: kPrimaryBlue, // Specify the border color here
              ),
            ),
            width: quantity.toString().length == 1
                ? 80
                : 60 + 12.0 * quantity.toString().length,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (quantity > 0) {
                        quantity--;
                      }
                    });
                  },
                  child: Container(
                    width: 25,
                    height: 30,
                    decoration: const BoxDecoration(
                      //shape: BoxShape.circle,
                      color: kPrimaryBlue,
                    ),
                    child:
                        const Icon(Icons.remove, size: 20, color: Colors.white),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 12.0 * quantity.toString().length,
                  height: 30,
                  decoration: const BoxDecoration(
                      //shape: BoxShape.circle,
                      //border: Border.all(color: kPrimaryBlue), // Circular border color
                      ),
                  child: TextField(
                    //readOnly: true, // Make the TextField read-only
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ], // Allow only numeric input
                    keyboardType:
                        TextInputType.number, // Set keyboard type to number
                    decoration: const InputDecoration(
                      isDense: true,

                      border: InputBorder.none, // Remove default border
                      contentPadding:
                          EdgeInsets.only(top: 5), // Remove default padding
                    ),
                    onChanged: (value) {
                      quantity = int.parse(value);
                    },

                    onEditingComplete: () {
                      setState(() {});
                    },
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: kPrimaryBlue, fontSize: 16),
                    controller:
                        TextEditingController(text: quantity.toString()),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: Container(
                    width: 25,
                    height: 30,
                    decoration: const BoxDecoration(
                      //shape: BoxShape.circle,
                      color: kPrimaryBlue,
                    ),
                    child: const Icon(Icons.add, size: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
  }
}
