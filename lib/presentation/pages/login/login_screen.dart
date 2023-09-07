import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/data/resource/remote/data_state.dart';
import 'package:transport_app/presentation/providers/auth_provider.dart';

import '../../widgets/custom_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Consumer<AUthProvider>(
                builder: (context, value, child) {
                  if (value.autState.dataState == DataState.Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Login",
                              style: TextStyle(
                                color: Color(0xff312e49),
                                fontSize: 28,
                                fontFamily: "Glory",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 30.80),
                            const Text(
                              "Username",
                              style: TextStyle(
                                color: Color(0xff312e49),
                                fontSize: 14,
                                fontFamily: "Glory",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            CustomTexformFieldWidget(
                              hintText: "Enter username",
                              textEditingController: emailController,
                            ),
                            const Text(
                              "Password",
                              style: TextStyle(
                                color: Color(0xff312e49),
                                fontSize: 14,
                                fontFamily: "Glory",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            CustomTexformFieldWidget(
                              hintText: "Enter Password",
                              textEditingController: passwordController,
                            ),
                            const SizedBox(height: 54.80),
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  Provider.of<AUthProvider>(context,
                                          listen: false)
                                      .login(
                                          userName: emailController.text,
                                          password: passwordController.text);
                                }

                                //     Navigator.pushNamed(context, OtpScreen.routeName);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xffb4aaf2),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 13,
                                ),
                                child: const Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: "Glory",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 54.80),
                          ]),
                    ),
                  );
                },
              ))),
    );
  }
}
