import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickensol_task/view/userlistpage.dart';

class APIDemo extends StatefulWidget {
  const APIDemo({super.key});

  @override
  State<APIDemo> createState() => _APIDemoState();
}

Map mapResponse = {};
String strResponse = "Press Get button to get data";
Map<String, dynamic>? dataResponse;

class _APIDemoState extends State<APIDemo> {
  Future apicall() async {
    print("in api call");
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users/2"));
    print("After uri");
    if (response.statusCode == 200) {
      setState(() {
        strResponse = response.body.toString();
        mapResponse = json.decode(response.body);
        dataResponse = mapResponse['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "API Demo",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(127, 86, 217, 1),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Get.offAll(() => (const FirstPage()));
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
            "User List",
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 1),
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: 450,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: const Color.fromARGB(255, 33, 86, 243))),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (dataResponse == null)
                  ? const SizedBox()
                  : const Text(
                      "json response",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  strResponse.toString(),
                  overflow: TextOverflow.visible,
                ),
              ),
              Container(
                //alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: (dataResponse == null)
                    ? const Text(
                        "no response from get api",
                        overflow: TextOverflow.visible,
                      )
                    : Column(
                        children: [
                          const Text(
                            "json response is formatted below",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("id : ${dataResponse!["id"]}"),
                                    Text("Email : ${dataResponse!["email"]}"),
                                    Text(
                                        "First Name : ${dataResponse!["first_name"]}"),
                                    Text(
                                        "Last Name : ${dataResponse!["last_name"]}"),
                                  ],
                                ),
                                Spacer(),
                                Image.network(
                                  "${dataResponse!["avatar"]}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      print("get api button pressed");
                      await apicall();
                      print("get api successfull");
                      setState(() {});
                    },
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(255, 255, 255, 1),
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      fixedSize: WidgetStatePropertyAll(
                        Size(100, 40),
                      ),
                    ),
                    child: const Text(
                      "Get",
                      style: TextStyle(
                          color: Color.fromRGBO(127, 86, 217, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 1),
                    ),
                  ),
                  ElevatedButton(
                onPressed: () async {
                   mapResponse = {};
 strResponse = "Press Get utton to get data";
 dataResponse = null;
                  setState(() {});
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromRGBO(255, 255, 255, 1),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  fixedSize: WidgetStatePropertyAll(
                    Size(100, 40),
                  ),
                ),
                child: const Text(
                  "Reset",
                  style: TextStyle(
                      color: Color.fromRGBO(127, 86, 217, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 1),
                ),
              )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
