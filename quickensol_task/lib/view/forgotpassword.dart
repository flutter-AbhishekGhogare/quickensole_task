import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickensol_task/controller/signincontroller.dart';
import 'package:quickensol_task/view/mytextformfield.dart';
import 'package:quickensol_task/view/signinpage.dart';

class Forgotpassword extends StatelessWidget {
  Forgotpassword({super.key});

  final String _emailPattern = r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


void sendLink(){
bool loginValidated = _formKey.currentState!.validate();
if(loginValidated){
   Get.find<SignInController>()
                    .forgotPassword(emailController.text);
              
}
}
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Icon(
                Icons.lock_reset,
                size: 50,
                color: Color.fromRGBO(105, 65, 198, 1),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Reset your password",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Color.fromRGBO(16, 24, 40, 1),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: MyTextField(
                controller: emailController,
                hintText: "Enter Your Email",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  print("In email VALIDATOR");
                  if (value == null || value.isEmpty) {
                    return "Please enter email";
                  } else if (!RegExp(_emailPattern).hasMatch(value)) {
                    return 'Please enter a valid email';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                sendLink();
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
                "Send reset password link to email",
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
                              "Remwmbered password ?",
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
                                "Sign in",
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
    );
  }
}
