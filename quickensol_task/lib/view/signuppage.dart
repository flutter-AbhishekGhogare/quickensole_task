import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickensol_task/controller/signincontroller.dart';
import 'package:quickensol_task/view/signinpage.dart';
import 'package:quickensol_task/view/mytextformfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final String _mobilePattern = r'^[0-9]{10}$';
  final String _emailPattern = r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+';

  Future<bool> signUp() async {
    bool signUpValidated = _formKey.currentState!.validate();
    if (signUpValidated) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      SignUpController obj = SignUpController();

      obj.firstname!.value = firstNameController.text;
      obj.lastname = lastNameController.text.obs;
      obj.mobilenumber = mobileNumberController.text.obs;
      obj.email = emailController.text.obs;
      obj.password = confirmPasswordController.text.obs;

      obj.createNewUser(
          emailController.text, confirmPasswordController.text, context);

      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("SignUp Failed"),
        ),
      );
      return false;
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
                      Text(
                        "Create new account",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Color.fromRGBO(16, 24, 40, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  //width: double.infinity,
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
                          "First Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(52, 64, 84, 1),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: MyTextField(
                            controller: firstNameController,
                            hintText: "Enter Your First name",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your first name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Last Name",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color.fromRGBO(52, 64, 84, 1),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: MyTextField(
                                controller: lastNameController,
                                hintText: "Enter Your Last name",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your last name";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Mobile Number",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(52, 64, 84, 1),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: MyTextField(
                            controller: mobileNumberController,
                            hintText: "Enter Your Mobile Number",
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              log("In mobile VALIDATOR");
                              if (value == null || value.isEmpty) {
                                return 'Please enter mobile number';
                              } else if (!RegExp(_mobilePattern)
                                  .hasMatch(value)) {
                                return 'Please enter a valid mobile number';
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
                            hintText: "Enter Your Email id",
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              print("In email VALIDATOR");
                              if (value == null || value.isEmpty) {
                                return "Please enter email id";
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
                          "Create New Password",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(52, 64, 84, 1),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: MyTextField(
                            controller: newPasswordController,
                            hintText: "Enter Your Password",
                            obscureText: !_isNewPasswordVisible,
                            obscuringCharacter: "*",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isNewPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isNewPasswordVisible =
                                      !_isNewPasswordVisible;
                                });
                              },
                            ),
                            validator: (value) {
                              print("In password VALIDATOR");
                              if (value == null || value.isEmpty) {
                                return "Please enter password";
                              } else if (value.length < 8) {
                                return "Password must contain 8 character";
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
                          "Confirm Your Password",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(52, 64, 84, 1),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: MyTextField(
                            controller: confirmPasswordController,
                            hintText: "Enter Your Password",
                            obscureText: !_isConfirmPasswordVisible,
                            obscuringCharacter: "*",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                            validator: (value) {
                              print("In comfirm password VALIDATOR");
                              String pass1 = newPasswordController.text;
                              String pass2 = confirmPasswordController.text;
                              int compare = pass1.compareTo(pass2);
                              if (value == null || value.isEmpty) {
                                return "Please enter password";
                              } else if (compare != 0) {
                                return "Please enter correct password";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await signUp();
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
                              )),
                          child: const Text(
                            "SignUp",
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
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(71, 84, 103, 1),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.offAll(const SignInScreen());
                              },
                              child: const Text(
                                "Log In",
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
