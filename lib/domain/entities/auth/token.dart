class Token {
  Token({
    this.token,
    this.pid,
    this.name,
    this.isVerified,
  });

  String? token;
  String? pid;
  String? name;
  bool? isVerified;

  Token.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    token = json['token'] as String?;
    pid = json["pid"] as String?;
    name = json["name"] as String?;
    isVerified = json["is_verified"] as bool?;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    if (token != null) json["token"] = token;
    if (pid != null) json["pid"] = pid;
    if (name != null) json["name"] = name;
    if (isVerified != null) json["is_verified"] = isVerified;
    return json;
  }
}
