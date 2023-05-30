

class UserDataResponse {
  UserDataResponse({
    this.id,
    this.fullName,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.password,
  });

  String? id;
  String? fullName;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? password;



  factory UserDataResponse.fromJson(Map<String, dynamic> json) => UserDataResponse(
    id: json['id'] ?? "",
    fullName: json['full_name'] ?? "",
    email: json['email'] ?? "",
    gender: json['gender'] ?? "",
    dateOfBirth: json['date_of_birth'] ?? "",
    password: json['password'] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    'full_name': fullName,
    "email": email,
    "gender": gender,
    "dateOfBirth": dateOfBirth,
    "password": password,
  };
}