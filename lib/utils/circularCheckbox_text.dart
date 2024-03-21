import 'package:flutter/material.dart';

class CircularCheckBoxWithText extends StatefulWidget {
  final String text;
  final bool initialValue;
  final Function(bool)? onChanged;

  const CircularCheckBoxWithText({
    Key? key,
    required this.text,
    this.initialValue = false,
    this.onChanged,
  }) : super(key: key);

  @override
  _CircularCheckBoxWithTextState createState() =>
      _CircularCheckBoxWithTextState();
}

class _CircularCheckBoxWithTextState extends State<CircularCheckBoxWithText> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant CircularCheckBoxWithText oldWidget) {
    super.didUpdateWidget(oldWidget);

    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isChecked = !_isChecked;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(_isChecked);
            }
          },
          child: Container(

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: _isChecked
                  ? Icon(
                Icons.check,
                size: 15.0,
                color: Colors.black,
              )
                  :Icon(
                Icons.check,
                size: 15.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 14),
        Text(widget.text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ],
    );
  }
}
