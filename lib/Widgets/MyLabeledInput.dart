import 'package:flutter/material.dart';

class MyLabeledInput extends StatefulWidget {
  final String labelText;
  final Function(String)? onChanged;
  final double width;
  final double heigth;
  final String? initialValue; // Add this line

  MyLabeledInput(
      {required this.labelText,
      this.onChanged,
      this.width = 200,
      this.heigth = 35,
      this.initialValue});

  @override
  _MyLabeledInputState createState() => _MyLabeledInputState();
}

class _MyLabeledInputState extends State<MyLabeledInput> {

  late TextEditingController _textEditingController =
      TextEditingController(text: widget.initialValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.heigth, // Fixed width to constrain the input field
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: 'Search ${widget.labelText.toLowerCase()}...',
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search),
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
