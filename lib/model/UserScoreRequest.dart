class UserScoreRequest {
  var className;
  var userName;

  UserScoreRequest({var className, var userName}) {
    this.className = className;
    this.userName = userName;
  }

  Map<String, dynamic> toJson() =>
      {'className': className, 'userName': userName};
}
