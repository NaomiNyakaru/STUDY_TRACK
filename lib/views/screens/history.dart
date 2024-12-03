import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:study_track/controllers/bookcontroller.dart';
import 'package:study_track/controllers/historycontroller.dart';
import 'package:study_track/controllers/logincontroller.dart';
import 'package:study_track/models/historymodel.dart';
import 'package:study_track/views/widgets/mysnackbar.dart';

Bookcontroller bookcontroller = Get.put(Bookcontroller());
Logincontroller logincontroller = Get.put(Logincontroller());
Historycontroller historycontroller = Get.put(Historycontroller());
final store=GetStorage();

class History extends StatelessWidget {
  History({super.key});

  @override
  Widget build(BuildContext context) {
    print('${logincontroller.email.value}');

    getOrders();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: const Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed("/settings"),
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: getOrders,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: historycontroller.historyList.length,

              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                historycontroller.historyList[index].email,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[900],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                historycontroller.historyList[index].title,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                historycontroller.historyList[index].quantity,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ksh ${historycontroller.historyList[index].amount}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                              Text(
                                historycontroller.historyList[index].buydate,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                                    
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
          
        ],
      ),
    );
  }

  getOrders() async {
  final response = await http.get(Uri.parse('http://192.168.39.125/study_track/getorders.php'));

  if (response.statusCode == 200) {
    var serverResponse = jsonDecode(response.body);

    if (serverResponse['code'] == 1 && serverResponse['userdetails'] is List) {
      // Get the signed-in user's email
      String signedInEmail = logincontroller.email.value;

      // Map the server response to the Historymodel
      List<Historymodel> historyList = (serverResponse['userdetails'] as List)
          .map((history) => Historymodel.fromJson(history))
          .toList();

      // Filter the historyList based on the signed-in user's email
      List<Historymodel> userOrders = historyList.where((order) => order.email == signedInEmail).toList();

      // Update the history controller with the filtered list
      historycontroller.updateHistoryList(userOrders);
    } else {
      mysnackbar(
        title: "error", 
        message: "server error",
        type: "error",
      );
    }
  }
}

}
