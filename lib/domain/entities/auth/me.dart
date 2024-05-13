class Me {
  Me({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.modifiedAt,
  });

  int? id;
  String? name;
  String? email;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? modifiedAt;

  Me.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'] as int?;
    name = json["name"] as String?;
    email = json["email"] as String?;
    emailVerifiedAt = json["email_verified_at"] as DateTime?;
    createdAt = json["created_at"] as DateTime?;
    modifiedAt = json["modified_at"] as DateTime?;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    if (id != null) json["id"] = id;
    if (name != null) json["name"] = name;
    if (email != null) json["email"] = email;
    if (emailVerifiedAt != null) json["email_verified_at"] = emailVerifiedAt;
    if (createdAt != null) json["created_at"] = createdAt;
    if (modifiedAt != null) json["modified_at"] = modifiedAt;

    return json;
  }
}
