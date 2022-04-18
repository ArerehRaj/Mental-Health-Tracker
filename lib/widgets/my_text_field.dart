import 'package:flutter/material.dart';

import '../constants.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.inputValue,
  }) : super(key: key);
  final String hintText;
  final TextInputType inputType;
  var inputValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: kBodyText.copyWith(color: Colors.white),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a valid input';
          }
          return null;
        },
        onSaved: (value) {
          inputValue = value.toString();
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
