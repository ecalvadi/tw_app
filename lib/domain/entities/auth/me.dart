class Me {
  Me({
    this.pid,
    this.name,
    this.email,
  });

  String? pid;
  String? name;
  String? email;

  Me.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    pid = json['pid'] as String?;
    name = json["name"] as String?;
    email = json["email"] as String?;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    if (pid != null) json["pid"] = pid;
    if (name != null) json["name"] = name;
    if (email != null) json["email"] = email;
    return json;
  }
}
