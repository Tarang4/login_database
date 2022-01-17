class UserLoginModal {
  int? id;
  String? fName;
  String? lName;
  String? email;
  String? password;

  UserLoginModal({this.id, this.fName, this.lName, this.email, this.password});

  UserLoginModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fName'];
    lName = json['lName'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fName": fName,
        "lName": lName,
        "email": email,
        "password": password
      };
}
