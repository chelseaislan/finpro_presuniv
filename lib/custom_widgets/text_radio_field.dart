// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:flutter/material.dart';

class LoginTextFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String text;
  final Widget prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final Color color;
  final String Function(String) textValidator;
  final TextInputAction textAction;
  final String initialValue;
  final String hintText;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final int maxLength;

  const LoginTextFieldWidget({
    @required this.text,
    this.controller,
    @required this.color,
    @required this.obscureText,
    this.prefixIcon,
    @required this.textInputType,
    this.textValidator,
    @required this.textAction,
    this.initialValue,
    this.hintText,
    this.textCapitalization,
    this.maxLines,
    this.maxLength,
  });

  @override
  _LoginTextFieldWidgetState createState() => _LoginTextFieldWidgetState();
}

class _LoginTextFieldWidgetState extends State<LoginTextFieldWidget> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: primary1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderFourText(
            text: widget.text,
            color: widget.color,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: TextFormField(
              textCapitalization: widget.textCapitalization,
              initialValue: widget.initialValue,
              textInputAction: widget.textAction,
              controller: widget.controller,
              autovalidateMode: AutovalidateMode.always,
              validator: widget.textValidator,
              cursorColor: primary1,
              obscureText: widget.obscureText,
              keyboardType: widget.textInputType,
              style: TextStyle(
                color: secondBlack,
                fontSize: 18,
              ),
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                counterStyle: TextStyle(color: white),
                prefixIcon: widget.prefixIcon,
                hintText: widget.text,
                fillColor: white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 3, color: lightGrey2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 3, color: lightGrey3),
                ),
                hintStyle: TextStyle(
                  color: thirdBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.normal,
                ),
                contentPadding: EdgeInsets.only(
                    top: 12,
                    bottom: bottomPaddingToError,
                    left: 8.0,
                    right: 8.0),
                isDense: true,
                errorStyle: TextStyle(
                  color: white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 3, color: primary2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 3, color: primary2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  return required;
}

String requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

Column dropdownField(
    header, prefixIcon, descText, value, items, onChanged, headerColor) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 1
      HeaderFourText(
        text: header,
        color: headerColor,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              isDense: true,
              // 2
              prefixIcon: prefixIcon,
              fillColor: white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 3, color: lightGrey2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 3, color: lightGrey3),
              ),
            ),
            // 3
            hint: DescText(
              text: descText,
              color: secondBlack,
            ),
            // 4
            value: value,
            // 5
            items: items,
            // 6
            onChanged: onChanged),
      ),
    ],
  );
}
