class Login {
  final String? accessToken;
  final String? message;

  Login({this.accessToken, this.message});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      accessToken: json["AccessToken"] ?? "",
      message: json["UserMessage"] ?? "",
    );
  }
}
