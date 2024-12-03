class BookModel {
  dynamic id,title,genre,image,price,availability,dateadded;

  BookModel({
    required this.id,
    required this.title,
    required this.genre,
    required this.image,
    required this.price,
    required this.availability,
    required this.dateadded,

  });

  factory BookModel.fromJson(Map<String, dynamic>json){
    return BookModel(
         id: json['id'],
         title: json['title'], 
         genre: json['genre'], 
         image: json['image'], 
         price: json['price'], 
         availability: json['availability'], 
         dateadded: json['dateadded']
         );
  }

}