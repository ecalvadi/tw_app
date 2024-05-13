class Token {
  Token({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  String? accessToken;
  String? tokenType;
  int? expiresIn;

  Token.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    accessToken = json['access_token'] as String?;
    tokenType = json["token_type"] as String?;
    expiresIn = json["expires_in"] as int?;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    if (accessToken != null) json["access_token"] = accessToken;
    if (tokenType != null) json["token_type"] = tokenType;
    if (expiresIn != null) json["expires_in"] = expiresIn;
    return json;
  }
}
