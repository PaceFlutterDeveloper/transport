import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/resource/local/local_db.dart';
import '../../data/resource/local/student_db.dart';
import '../../data/resource/local/trip_db.dart';
import '../providers/nfc_provider.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmation'),
      content: const Text('Are you sure you want to proceed?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            Provider.of<NfcProvider>(context, listen: false).stop();
            clearData();
            TripDB.clardb();
            StudentDb.clardb();
            // Handle 'Yes' button tap
            Navigator.of(context)
                .pop(true); // Return true when 'Yes' is pressed
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () {
            // Handle 'No' button tap
            Navigator.of(context)
                .pop(false); // Return false when 'No' is pressed
          },
        ),
      ],
    );
  }
}
