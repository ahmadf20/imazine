import 'package:flutter/material.dart';

Widget loadingIndicator({Color color}) {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        color ?? Colors.amber,
      ),
    ),
  );
}
