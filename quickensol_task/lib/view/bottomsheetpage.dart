import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickensol_task/controller/signincontroller.dart';
import 'package:quickensol_task/view/mytextformfield.dart';

void sheet(context, int index) {
  SignUpController signUpController = Get.find<SignUpController>();

  const String mobilePattern = r'^[0-9]{10}$';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  firstNameController.text = signUpController.firstname!.value;
  lastNameController.text = signUpController.lastname!.value;
  mobileNumberController.text = signUpController.mobilenumber!.value;

  UserController userController = Get.find<UserController>();

  Future<bool> edit(int index) async {
    bool editValidate = formKey.currentState!.validate();
    if (editValidate) {
      await userController.updateUser(index, firstNameController.text,
          lastNameController.text, mobileNumberController.text);
      print("User updated");
      return true;
    } else {
      Get.snackbar("Failed to edit", "");
      print("User not Updated");
      return false;
    }
  }

  showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (context) => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Edit User Details",
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      color: const Color.fromRGBO(105, 65, 198, 1),
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "First Name",
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(105, 65, 198, 1),
                      ),
                    ),
                    MyTextField(
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Last Name",
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(105, 65, 198, 1),
                      ),
                    ),
                    MyTextField(
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Mobile Number",
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(105, 65, 198, 1),
                      ),
                    ),
                    MyTextField(
                      controller: mobileNumberController,
                      hintText: "Enter Your Mobile Number",
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        print("In mobile VALIDATOR");
                        if (value == null || value.isEmpty) {
                          return 'Please enter mobile number';
                        } else if (!RegExp(mobilePattern).hasMatch(value)) {
                          return 'Please enter a valid mobile number';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: ElevatedButton(
                        onPressed: () {
                          edit(index);
                          Get.back();
                        },
                        style: const ButtonStyle(
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            minimumSize: WidgetStatePropertyAll(
                                Size(double.infinity, 50)),
                            backgroundColor: WidgetStatePropertyAll(
                              Color.fromRGBO(105, 65, 198, 1),
                            )),
                        child: Text(
                          "Submit",
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )));
}
