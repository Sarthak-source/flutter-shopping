import 'package:flutter/material.dart';
import 'package:sutra_ecommerce/constants/colors.dart';

class AddButton extends StatefulWidget {
  const AddButton({Key? key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return quantity == 0
        ? SizedBox(
            width: 110,
            height: 30,
            child: OutlinedButton(
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
              border: Border.all(
                color: kPrimaryBlue, // Specify the border color here
              ),
            ),
            width: 100,
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
                  child: const Icon(Icons.remove),
                ),
                SizedBox(
                    width: 45,
                    height: 30,
                    child: TextField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: kPrimaryBlue, // Background color
                        hintStyle:
                            TextStyle(color: Colors.white), // Hint text color
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white,), // Text color
                      controller:
                          TextEditingController(text: quantity.toString()),
                    )),
                InkWell(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          );
  }
}
