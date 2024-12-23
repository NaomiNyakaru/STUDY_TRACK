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
final store = GetStorage();

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
          "Order History",
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
            onPressed: getOrders,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Obx(() => 
              historycontroller.historyList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined, 
                          size: 100, 
                          color: Colors.grey[400]
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No orders yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600]
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
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
                                      historycontroller.historyList[index].title,
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
                                      historycontroller.historyList[index].genre,
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
                  ),
            ),
          ),
        ],
      ),
    );
  }

  getOrders() async {
  
    int? userId = store.read('userid');
    
    if (userId == null) {
     
      mysnackbar(
        title: "Error", 
        message: "No user logged in",
        type: "error",
      );
      return;
    }

    final response = 
      await http.get(Uri.parse('http://192.168.39.125/study_track/getorders.php?userid=$userId'));
    
    if(response.statusCode == 200){
      var serverResponse = jsonDecode(response.body);
      
      if (serverResponse['code'] == 1 && serverResponse['userdetails'] is List) {
        List<Historymodel> historyList = (serverResponse['userdetails'] as List)
            .map((history) => Historymodel.fromJson(history))
            .toList();
        
        historycontroller.updateHistoryList(historyList);
      } else {
       
        if (serverResponse['code'] == 0) {
          historycontroller.updateHistoryList([]); 
          mysnackbar(
            title: "No Orders", 
            message: serverResponse['message'] ?? "No orders found",
            type: "info",
          );
        } else {
          mysnackbar(
            title: "Error", 
            message: "Server error",
            type: "error",
          );
        }
      }
    } else {
      mysnackbar(
        title: "Error", 
        message: "Failed to connect to server",
        type: "error",
      );
    }
  }
}