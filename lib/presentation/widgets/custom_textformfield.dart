import 'package:flutter/material.dart';

class CustomTexformFieldWidget extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController textEditingController;
  final bool obsecureText;
  const CustomTexformFieldWidget({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.obsecureText = false,
    this.prefixIcon,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: prefixIcon ?? const SizedBox(),
          ),
          Expanded(
            child: TextFormField(
              obscureText: obsecureText,
              controller: textEditingController,
              decoration: InputDecoration(
                // isDense: true,
                hintText: hintText,

                contentPadding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                hintStyle: const TextStyle(
                  color: Color(0xff747980),
                  fontSize: 12,
                  fontFamily: "Glory",
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                //contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: suffixIcon ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
