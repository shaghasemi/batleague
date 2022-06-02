import 'package:flutter/material.dart';

buttonMain({
  required String title,
  required VoidCallback action,
  bool? isLoading,
  bool isActive = true,
  double? width,
  Color? backgroundColor,
  Key? key,
}) {
  return MaterialButton(
    minWidth: width,
    key: key,
    onPressed: isActive ? action : null,
    color: backgroundColor ?? Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      side: BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    child: Text(
      title,
      style: const TextStyle(
        // color: Colors.white,
        fontFamily: 'iranyekan',
        fontSize: 16,
      ),
    ),
  );
}
