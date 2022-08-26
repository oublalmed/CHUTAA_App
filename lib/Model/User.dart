class User {
  late String? fullName;
  late String? email;
  late String? uid;
  late String? number;

    User({
     this.uid,
     this.fullName,
     this.email,
     this.number
   });

   Map<String, dynamic> toJson() => {
      "uid" : uid,
      "fullName" : fullName,
      "email" : email,
      "number" : number,
   };

   static User fromJson(Map<String, dynamic> json) => User(
      number: json["number"],
      uid: json["uid"],
      fullName: json["fullName"],
      email: json["email"],

   );


}