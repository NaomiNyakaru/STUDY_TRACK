import 'package:get/get.dart';
import 'package:study_track/models/bookmodel.dart';

class Bookcontroller extends GetxController{
  var loadingBooks = true.obs;
  var BookList=<BookModel>[];
  updateBookList(List<BookModel> books){
    loadingBooks.value = false;
    BookList.clear();
    BookList.assignAll(books);
  }
}