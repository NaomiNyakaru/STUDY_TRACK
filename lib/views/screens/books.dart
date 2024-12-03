import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:study_track/controllers/bookcontroller.dart';
import 'package:study_track/models/bookmodel.dart';
import 'package:study_track/views/widgets/mysnackbar.dart';

Bookcontroller bookcontroller = Get.put(Bookcontroller());
final store=GetStorage();

class Book extends StatelessWidget {
  Book({super.key});

  @override
  Widget build(BuildContext context) {
    getBooks();
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
            onPressed: getBooks,
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
              itemCount: bookcontroller.BookList.length,
              itemBuilder: (context, index) {
                final book = bookcontroller.BookList[index];
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "http://192.168.39.125/study_track/bookimages/${book.image}",
                            width: 60,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 120,
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.book,
                                  color: Colors.grey[600],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
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
                                book.genre,
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
                                    'Ksh ${book.price}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: ()async {
                                      final response= await http.get(Uri.parse("http://192.168.39.125/study_track/buybook.php?userid=${store.read("userid")}&bookid=${bookcontroller.BookList[index].id}&quantity=1&amount=${bookcontroller.BookList[index].price}"));
                                      if(response.statusCode==200){
                                        var serverResponse = jsonDecode(response.body);
                                        if(serverResponse["success"]==1&& serverResponse["message"]=="Order successfully"){
                                          mysnackbar(
                                          title:"Success",
                                          message: "order placed",
                                          type:"success");

                                        }

                                      }else{
                                        mysnackbar(
                                          title:"server errror",
                                          message: "order failed",
                                          type:"error");
                                      }
                                    },
                                   
                                    child:Text("Rent book")),
                                    
                                    
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

  getBooks() async {
    final response = 
    await http.get(Uri.parse('http://192.168.39.125/study_track/getbooks.php'));
    if(response.statusCode == 200){
      var serverResponse = jsonDecode(response.body);
       if (serverResponse['code'] == 1 && serverResponse['userdetails'] is List) {
      List<BookModel> books = (serverResponse['userdetails'] as List)
          .map((book) => BookModel.fromJson(book))
          .toList();
      bookcontroller.updateBookList(books);
    }else{
      mysnackbar(
        title: "error", 
        message: "server error",
        type: "error",
        );
    }
  }
}
}