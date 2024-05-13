import 'dart:ffi';

class Position {
  Position({
    this.id,
    this.lat,
    this.lon,
    this.createdAt,
    this.modifiedAt,
    this.userId,
  });

  int? id;
  double? lat;
  double? lon;
  String? createdAt;
  String? modifiedAt;
  int? userId;

  Position.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'] as int?;
    lat = (json["lat"] is double? ) ? json["lat"] as double?:(json["lat"]*.0) as double?;
    lon = (json["lon"] is double?)  ? json["lon"] as double?:(json["lon"]*.0) as double?;
    createdAt = json["created_at"] as String?;
    modifiedAt = json["modified_at"] as String?;
    userId = json["user_id"] as int?;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    if (id != null) json["id"] = id;
    if (lat != null) json["lat"] = lat;
    if (lon != null) json["lon"] = lon;
    if (createdAt != null) json["created_at"] = createdAt;
    if (modifiedAt != null) json["modified_at"] = modifiedAt;
    if (userId != null) json["user_id"] = userId;
    return json;
  }
}
