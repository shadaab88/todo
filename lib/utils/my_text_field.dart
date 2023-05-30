import 'package:flutter/material.dart';
import 'package:todo/utils/constants.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  final String labelText;
  final void Function(String) onChanged;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? trailingFunction;
  final String? defaultValue;
  final bool showTrailingWidget;
  final Widget? trailing;
  final bool autofocus;
  final TextEditingController? controller;

  //final FormValidator? validator;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPasswordField;
  Color? borderColor;
  Color? focusedBorderColor;
  final double borderWidth;
  final double focusedBorderWidth;
  final double borderRadius;
  final String? hintText;
  final bool overrideHintText;
  final bool isFilled;
  final bool isEnabled;
  final Color? fillColor;
  final double? width;
  final double? height;

  final int? minLine;
  final int? maxLine;

  final EdgeInsets? margin;
  final EdgeInsets contentPadding;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final Widget? prefixWidget;
  final Widget? leading;
  final bool showLeadingWidget;
  final int maxLength;
  AutovalidateMode? autoValidate = AutovalidateMode.disabled;

  MyTextField(
      {required this.labelText,
        required this.onChanged,
        this.onFieldSubmitted,
        this.hintText,
        this.trailingFunction,
        this.defaultValue,
        this.keyboardType,
        this.controller,
        this.validator,
        this.trailing,
        this.maxLine,
        this.minLine,
        this.width,
        this.height,
        this.margin,
        this.overrideHintText = false,
        this.showTrailingWidget = true,
        this.autofocus = false,
        this.isPasswordField = false,
        this.borderColor,
        this.focusedBorderColor,
        this.borderWidth = 1,
        this.focusedBorderWidth = 2,
        this.borderRadius = 20,
        this.contentPadding = const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        this.fillColor = Colors.white,
        this.isFilled = false,
        this.isEnabled = true,
        this.hintTextStyle,
        this.textStyle,
        this.prefixWidget,
        this.leading,
        this.showLeadingWidget = false,
        this.maxLength = 50,
        this.autoValidate = AutovalidateMode.disabled,
      });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _showPassword;

  @override
  void initState() {
    _showPassword = !widget.isPasswordField;
    super.initState();
  }

  void toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    this.widget.borderColor ??= Theme.of(context).accentColor;
    this.widget.focusedBorderColor ??= Theme.of(context).accentColor;
    return Container(
      width: this.widget.width,

      // padding: const EdgeInsets.all(5.0),
      margin: this.widget.margin,
      child: TextFormField(

        autovalidateMode: this.widget.autoValidate,
        onFieldSubmitted: this.widget.onFieldSubmitted,
        controller: this.widget.controller,
        validator: this.widget.validator,
        initialValue: this.widget.defaultValue,
        textAlignVertical: TextAlignVertical.center,
        autofocus: this.widget.autofocus,
        keyboardType: this.widget.keyboardType,
        onChanged: this.widget.onChanged,
        enabled: this.widget.isEnabled,
        obscureText: this.widget.isPasswordField ? !this._showPassword : false,
        maxLength: widget.maxLength,

        style: this.widget.textStyle != null
            ? this.widget.textStyle
            : TextStyle(color: Constants.black),
        cursorColor: Constants.secondaryColor,
        // minLines: this.widget.minLine,
        // maxLines: this.widget.maxLine,
        decoration: InputDecoration(
          counterStyle: TextStyle(height: double.minPositive,),
          counterText: "",
          filled: this.widget.isFilled,
          fillColor: this.widget.fillColor,
          hintText: 'Enter Value',
          prefix: this.widget.prefixWidget,
          labelStyle: this.widget.textStyle != null
              ? this.widget.textStyle
              : TextStyle(color: Constants.black),
          contentPadding: this.widget.contentPadding,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(this.widget.borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: this.widget.borderColor!,
              width: this.widget.borderWidth,
            ),
            borderRadius: BorderRadius.circular(this.widget.borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: this.widget.focusedBorderColor!,
              width: this.widget.focusedBorderWidth,
            ),
            borderRadius: BorderRadius.circular(this.widget.borderRadius),
          ),
        )
            .copyWith(
          hintText: this.widget.overrideHintText
              ? this.widget.hintText
              : "Enter ${this.widget.labelText}",
          labelStyle: this.widget.textStyle != null
              ? this.widget.textStyle
              : TextStyle(color: Constants.black),
          hintStyle: this.widget.hintTextStyle != null
              ? this.widget.hintTextStyle
              : TextStyle(color: Constants.black),
          // labelText: this.widget.labelText,
          prefixIcon:
          this.widget.showLeadingWidget ? this.widget.leading : null,
          suffixIcon: this.widget.showTrailingWidget
              ? this.widget.trailing == null
              ? Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: this.widget.isPasswordField
                ? IconButton(
              splashRadius: 1,
              color: Constants.secondaryColor,
              icon: _showPassword
                  ? Icon(Icons.visibility, size: 25.0)
                  : Icon(Icons.visibility_off, size: 25.0),
              onPressed: toggleShowPassword,
            )
                : null,
          )
              : GestureDetector(
              onTap: this.widget.trailingFunction,
              child: this.widget.trailing)
              : null,
        ),
      ),
    );
  }
}
