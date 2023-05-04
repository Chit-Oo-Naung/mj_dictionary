import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final bool disable;
  final bool iconDisalbe;
  final String? Function(String?)? validator;
  

  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    required this.controller,
    this.disable = false,
    this.iconDisalbe = false,
    this.validator,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(color: Colors.black),
    );
    return AbsorbPointer(
      absorbing: disable,
      // child: TextFieldContainer(
      child: Container(
        color: Colors.white,
        // margin: EdgeInsets.only(top: 15),
        child: 
        TextFormField(          
          controller: controller,
          onChanged: onChanged,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(28, 20, 12, 12),
            labelText: hintText,
            hintStyle: TextStyle(color: Color.fromARGB(255, 63, 63, 63)),
            focusedBorder: border,
            enabledBorder: border,
            errorBorder: border,
            border: border,
            disabledBorder: border,
            focusedErrorBorder: border,
          ),
          validator: validator,
          // onFieldSubmitted: onfieldsubmit,
          // decoration: iconDisalbe
          //     ? InputDecoration(
          //         hintText: hintText,
          //         border: InputBorder.none,
          //       )
          //     : InputDecoration(
          //         icon: Icon(
          //           icon,
          //           color: Colors.black,
          //         ),
          //         hintText: hintText,
          //         border: InputBorder.none,
          //       ),
        ),
      ),
      // ),
    );
  }
}
