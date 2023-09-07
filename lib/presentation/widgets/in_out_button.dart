import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/config/theme/color_constants.dart';
import 'package:transport_app/presentation/providers/nfc_provider.dart';

class InOutSwitch extends StatefulWidget {
  const InOutSwitch({
    Key? key,
  }) : super(key: key);

  @override
  _InOutSwitchState createState() => _InOutSwitchState();
}

class _InOutSwitchState extends State<InOutSwitch> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NfcProvider>(
      builder: (context, value, child) => Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  value.setInOut(true);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: value.inOut
                          ? ColorConstants.green
                          : ColorConstants.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: Text(
                    "IN ",
                    style: TextStyle(
                        color: value.inOut ? Colors.white : Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  value.setInOut(false);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: !value.inOut
                          ? ColorConstants.red
                          : ColorConstants.white,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: Text(
                    "OUT",
                    style: TextStyle(
                        color: !value.inOut ? Colors.white : Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
