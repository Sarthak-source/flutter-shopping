import 'package:flutter/material.dart';

class BackButtonText extends StatelessWidget {
  final Function()? navBack; // Callback function to navigate back

  const BackButtonText({Key? key, this.navBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (navBack != null) {
          navBack!(); // Execute the callback function if provided
        } else {
          Navigator.pop(context, true); // Navigate back if callback is not provided
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          Text(
            '',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}
