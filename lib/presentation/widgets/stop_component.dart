import 'package:flutter/material.dart';

import '../../config/theme/color_constants.dart';
import 'alert_dialogue_coponent.dart';

class StopComponent extends StatelessWidget {
  const StopComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffededed),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const MyAlertDialog();
                },
              ).then((value) {
                if (value != null && value) {
                  // 'Yes' button pressed
                  // Perform necessary actions
                } else {
                  // 'No' button pressed or dialog dismissed
                  // Perform necessary actions
                }
              });
            },
            child: CircleAvatar(
              radius: 10,
              backgroundColor: ColorConstants.red,
              child: Text(
                "STOP",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .merge(const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ),
        ));
  }
}
