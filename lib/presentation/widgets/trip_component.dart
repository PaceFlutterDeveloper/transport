import 'package:flutter/material.dart';

import 'in_out_button.dart';

class TripModeComponent extends StatelessWidget {
  const TripModeComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffededed),
      ),
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Trip Mode",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          InOutSwitch(),
        ]),
      ),
    );
  }
}
