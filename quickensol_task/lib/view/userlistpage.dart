import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickensol_task/controller/signincontroller.dart';
import 'package:quickensol_task/view/apidemo.dart';
import 'package:quickensol_task/view/bottomsheetpage.dart';
import 'package:quickensol_task/view/signinpage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                print("Pop");
                // showDialog(
                //   context: context,
                //   barrierDismissible: false,
                //   builder: (context) {
                //     print("loading");
                //     return Center(
                //       child: Container(
                //           height: 100,
                //           width: 200,
                //           alignment: Alignment.center,
                //           child: CircularProgressIndicator()),
                //     );
                //   },
                // );
                //print("round loaded");
                await Get.find<UserController>().deleteUser(index);
                //Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SignUpController textfields = Get.find<SignUpController>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              "Users List",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Get.offAll(SignInScreen());
              },
              child: Icon(Icons.logout),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(127, 86, 217, 1),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Get.to(const APIDemo());
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
            "API Demo",
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        width: double.maxFinite,
        child: Container(
          // height: 400,
          child: Obx(
            () {
              var usersData = Get.find<UserController>().usersData;
              print("in list builder");
              print(usersData);
              return ListView.builder(
                itemCount: usersData.length,
                itemBuilder: (context, index) => Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        //height: 150,
                        width: double.maxFinite,
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 189, 227, 251),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                          border: Border(
                            left: BorderSide(
                              color: Color.fromARGB(255, 33, 37, 243),
                            ),
                            top: BorderSide(
                              color: Color.fromARGB(255, 33, 37, 243),
                            ),
                            right: BorderSide(
                              color: Color.fromARGB(255, 33, 37, 243),
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Name :",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    " ${usersData[index]["first_name"] + " " + usersData[index]["last_name"]}",
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Mobile no :",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  " ${usersData[index]["mobile_number"]}",
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Email :",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    " ${usersData[index]["email"]}",
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 89, 186, 246),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10)),
                          border: Border(
                            left: BorderSide(
                              color: Color.fromARGB(255, 33, 37, 243),
                            ),
                            bottom: BorderSide(
                              color: Color.fromARGB(255, 33, 37, 243),
                            ),
                            right: BorderSide(
                              color: Color.fromARGB(255, 33, 37, 243),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                textfields.firstname!.value =
                                    usersData[index]["first_name"];
                                textfields.lastname!.value =
                                    usersData[index]["last_name"];
                                textfields.mobilenumber!.value =
                                    usersData[index]["mobile_number"];
                                sheet(context, index);
                                // showModalBottomSheet(
                                //   isScrollControlled: true,
                                //   shape: const RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.only(
                                //       topLeft: Radius.circular(30.0),
                                //       topRight: Radius.circular(30.0),
                                //     ),
                                //   ),
                                //   context: context,
                                //   builder: (context) => sheet(context, index),
                                // );
                              },
                              child: const Icon(
                                Icons.edit,
                                size: 21,
                                color: Color.fromRGBO(127, 86, 217, 1),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                showDeleteConfirmationDialog(context, index);
                                // showDialog(
                                //   context: context,
                                //   barrierDismissible: false,
                                //   builder: (context) {
                                //     return Center(
                                //       child: Container(
                                //         height: 100,
                                //         width: 200,
                                //         alignment: Alignment.center,
                                //         child: Text("Are you sure you want to delete the user?")
                                //       ),
                                //     );
                                //   },
                                // );

                                // Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.delete,
                                size: 20,
                                color: Color.fromRGBO(127, 86, 217, 1),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
