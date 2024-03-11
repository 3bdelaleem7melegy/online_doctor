
class Doctor {
  String id;
  String name;
  String email;
  String phoneNumber;
  String imageUrl;
  String location;
  // String Certificates;
  // String Experience;
  String Special;
  String Price ;

  Doctor({
    required this.email,
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.location,
    required this.Price ,
    // required this.Certificates,
    required this.Special,
  });

  factory Doctor.formJson(Map<String, dynamic> json) {
    return Doctor(
      email: json['email'],
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl']??'',
      location: json['location'],
      Price : json['Price ']??'',
      // Certificates: json['Certificates'],
      Special: json['Special'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "imageUrl": imageUrl,
      "location": location,
      "Price ": Price ,
      // "Certificates": Certificates,
      "Special": Special,
    };
  }
}