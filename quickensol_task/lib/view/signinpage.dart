import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickensol_task/controller/signincontroller.dart';
import 'package:quickensol_task/view/forgotpassword.dart';
import 'package:quickensol_task/view/mytextformfield.dart';
import 'package:quickensol_task/view/signuppage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String _emailPattern = r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+';

  void signin() async {
    bool loginValidated = _formKey.currentState!.validate();
    if (loginValidated) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      var logincontroller = Get.find<SignInController>();
      await logincontroller.signin(
          emailController.text, passwordController.text, context);
    }
  }

  String? checkValidation(value) {
    if (value == null || value.isEmpty) {
      return "Please enter email";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Color.fromRGBO(105, 65, 198, 1),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Sign in to your account",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Color.fromRGBO(16, 24, 40, 1),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(52, 64, 84, 1),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: MyTextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Enter Your Email id",
                            validator: (value) {
                              print("In email VALIDATOR");
                              if (value == null || value.isEmpty) {
                                return "Please enter email";
                              } else if (!RegExp(_emailPattern)
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Password",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(52, 64, 84, 1),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: MyTextField(
                            controller: passwordController,
                            hintText: "Enter Your Password",
                            obscureText: !_isPasswordVisible,
                            obscuringCharacter: "*",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            validator: (value) {
                              print("In password VALIDATOR");
                              if (value == null || value.isEmpty) {
                                return "Please enter password";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.off(Forgotpassword());
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color.fromRGBO(105, 65, 198, 1),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            signin();
                          },
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Color.fromRGBO(127, 86, 217, 1),
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            minimumSize: WidgetStatePropertyAll(
                              Size(double.infinity, 50),
                            ),
                          ),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don’t have an account?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(71, 84, 103, 1),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.offAll(const SignUpScreen());
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(105, 65, 198, 1),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
