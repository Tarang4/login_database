class UserLoginModal {
  int? id;
  String? fName;
  String? lName;
  String? email;
  String? password;
  String? imgDp;
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
      this.imgDp,
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
    imgDp = json['imgDp'];
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
        "imgDp": imgDp,
        "phone": phone,
        "gender": gender,
        "address": address,
        "city": city,
        "pinCode": pinCode
      };
}

