class Login {
  Login({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["email"] = email;
    json["password"] = password;
    return json;
  }
}
