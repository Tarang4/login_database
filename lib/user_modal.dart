class UserLoginModal {
  int? id;
  String? fName;
  String? lName;
  String? email;
  String? password;
  String? img;
  int? phone;
  int? gender;
  String? address;
  String? city;
  int? pinCode;

  UserLoginModal(
      {this.id,
      this.fName,
      this.lName,
      this.email,
      this.password,
      this.img,
      this.phone,
      this.gender,
      this.address,
      this.city,
      this.pinCode});

  UserLoginModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fName'];
    lName = json['lName'];
    email = json['email'];
    password = json['password'];
    img = json['img'];
    phone = json['phone'];
    gender = json['gender'];
    address = json['address'];
    city = json['city'];
    pinCode = json['pinCode'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fName": fName,
        "lName": lName,
        "email": email,
        "password": password,
        "img": img,
        "phone": phone,
        "gender": gender,
        "address": address,
        "city": city,
        "pinCode": pinCode
      };
}

