import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickensol_task/view/userlistpage.dart';
import 'package:quickensol_task/view/signinpage.dart';

class SignUpController extends GetxController {
  RxString? email = "".obs;
  RxString? firstname = "".obs;
  RxString? lastname = "".obs;
  RxString? mobilenumber = "".obs;
  RxString? password = "".obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  void createNewUser(
      String email, String password, BuildContext context) async {
    print("in auth and create function *****************");
    await auth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
          // ignore: invalid_return_type_for_catch_error
        )
        .then((value) => {
              Get.snackbar("Signup successful",
                  "New user successfully created and all the information is stored in firebase"),
              Get.offAll(() => (const SignInScreen()))
            })
        .catchError(
            // ignore: invalid_return_type_for_catch_error
            (onError) => {
                  Get.snackbar("Signup failed", onError.message),
                  Navigator.of(context).pop()
                });

    try {
      await storeUserData();
    } catch (e) {}
  }

  Future<void> storeUserData() async {
    await FirebaseFirestore.instance
        .collection('newusers')
        .doc(email!.value)
        .set({
      "first_name": firstname!.value,
      "last_name": lastname!.value,
      "mobile_number": mobilenumber!.value,
      "email": email!.value,
    });
    print("in auth and after storing function *****************");
  }
}

class SignInController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signin(
      String email, String password, BuildContext context) async {
    Get.find<UserController>().usersData.value =
        await UserController().fetchUsers();
    var data = await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              Get.snackbar("Sign in successful", ""),
              Get.offAll(() => (const FirstPage()))
            })
        .catchError(
            // ignore: invalid_return_type_for_catch_error
            (onError) => {
                  Get.snackbar("Sign in failed", onError.message),
                  Navigator.of(context).pop(),
                });

    print(data);
  }

  void forgotPassword(String email) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .then(
          (onValue) => {
            Get.snackbar(
              "Reset password link sent",
              "If your email is registered with us, you will receive a password reset link sent to ${email}."
            ),
            Get.offAll(
              SignInScreen(),
            ),
          },
        )
        .catchError((onError) =>
            // ignore: invalid_return_type_for_catch_error
            Get.snackbar("Password reset failed", onError.message));
  }
}

class UserController extends GetxController {
  RxList<Map<String, dynamic>> usersData =
      <Map<String, dynamic>>[].obs; //[{"": dynamic}].obs;

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('newusers').get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> updateUser(
      int index, String firstName, String lastName, String mobileNumber) async {
    try {
      await FirebaseFirestore.instance
          .collection('newusers')
          .doc(usersData[index]['email'])
          .update({
        'first_name': firstName,
        'last_name': lastName,
        'mobile_number': mobileNumber,
      });
      Get.snackbar("User details edited", "");
      usersData.value = await fetchUsers();
      update();

      // Get.back();
    } catch (e) {
      Get.snackbar("Failed to edit", e.toString());
      print("Error updating user: $e");
    }
  }

  Future<void> deleteUser(int index) async {
    String email = usersData[index]["email"];
    try {
      await FirebaseFirestore.instance
          .collection('newusers')
          .doc(email)
          .delete();

      Get.snackbar('Deleted', 'User successfully deleted');
      usersData.value = await fetchUsers();
      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete user: $e');
    }
  }
}
