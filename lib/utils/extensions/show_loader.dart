import 'package:flutter/material.dart';

void showProgressDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dialog dismissal on outside tap
    builder: (BuildContext context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
}
