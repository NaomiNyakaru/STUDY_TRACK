
class Historymodel {
  String email;
  String amount;
  String title;
  String buydate;
  String quantity;
  String genre;

  Historymodel({
    required this.email,
    required this.amount,
    required this.title,
    required this.buydate,
    required this.quantity,
    required this.genre

  });

  factory Historymodel.fromJson(Map<String, dynamic> json){
    return Historymodel(
        email: json['email'], 
        amount:json['amount'], 
        title: json['title'], 
        buydate: json['buydate'], 
        quantity: json['quantity'],
        genre: json['genre'],
        );
  }

}