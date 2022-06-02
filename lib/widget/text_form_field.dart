import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../util/main/color.dart';
import '../util/main/style.dart';

textFormFieldWidget(
  final String labelText,
  final TextEditingController? controller, {
  final String? initialValue,
  final ValueChanged<String>? onChanged,
  final FormFieldValidator<String>? validator,
  final VoidCallback? onEditingComplete,
  final VoidCallback? onTap,
  final TextStyle? style,
  final FocusNode? focusNode,
  final bool isEnabled = true,
  final bool isReadOnly = false,
  final bool isObscureText = false,
  final int? maxLength,
  final int? maxLines,
  final TextInputAction? textInputAction,
  final TextInputType? keyboardType,
  final List<TextInputFormatter>? inputFormatter,
  final TextAlign textAlign = TextAlign.start,
  final TextDirection? textDirection,
  final String? helperText,
  final bool isAutoFocus = false,
}) {
  final TextStyle secondaryStyle = TextStyle(
    decorationColor: redColor,
    color: darkColor,
    fontSize: 13,
  );

  const double borderWidth = 1.5;
  const double focusedBorderWidth = 2;

  TextStyle mainStyle = TextStyle(
    fontSize: 15,
    color: darkColor,
    fontWeight: FontWeight.bold,
  );

  final TextStyle errorStyle = TextStyle(
    fontSize: 12,
    color: redColor,
    fontWeight: FontWeight.bold,
  );

  final TextStyle helperStyle = TextStyle(fontSize: 11, color: hintColor);

  InputBorder borderStyle = OutlineInputBorder(
    borderSide: BorderSide(color: c_150Color, width: 0),
    borderRadius: BorderRadius.circular(24),
  );

  final InputBorder focusedBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(
      color: const Color(0xff7cb721).withOpacity(0.7),
      width: focusedBorderWidth,
    ),
    borderRadius: BorderRadius.circular(8),
  );

  final InputBorder errorBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(color: redColor, width: borderWidth),
    borderRadius: BorderRadius.circular(8),
  );

  final InputBorder focusedErrorBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(color: redColor, width: focusedBorderWidth),
    borderRadius: BorderRadius.circular(8),
  );

  final InputBorder disabledBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(color: c_240Color, width: 1.5),
    borderRadius: BorderRadius.circular(8),
  );

  return TextFormField(
    initialValue: initialValue,
    controller: controller,
    validator: validator,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    enabled: isEnabled,
    readOnly: isReadOnly,
    obscureText: isObscureText,
    onTap: onTap,
    maxLength: maxLength,
    maxLines: maxLines,
    textInputAction: textInputAction,
    focusNode: focusNode,
    keyboardType: keyboardType,
    inputFormatters: inputFormatter ??
        [
          if (keyboardType == TextInputType.number)
            FilteringTextInputFormatter.digitsOnly
        ],
    textAlign: textAlign,
    textDirection: textDirection,
    style: style ?? mainStyle,
    autofocus: isAutoFocus,
    toolbarOptions: ToolbarOptions(
      copy: isObscureText ? false : true,
      cut: isObscureText ? false : true,
      paste: true,
      selectAll: true,
    ),
    decoration: InputDecoration(
      disabledBorder: disabledBorderStyle,
      labelText: labelText,
      helperText: helperText,
      enabled: isEnabled,
      hintStyle: hintStyle,
      labelStyle: hintStyle,
      helperStyle: helperStyle,
      hintTextDirection: textDirection,
      filled: true,
      fillColor: c_250Color,
      counterText: '',
      border: const OutlineInputBorder(),
      enabledBorder: borderStyle,
      focusedBorder: focusedBorderStyle,
      errorStyle: errorStyle,
      errorBorder: errorBorderStyle,
      focusedErrorBorder: focusedErrorBorderStyle,
      contentPadding: const EdgeInsets.all(16),
    ),
  );
}
