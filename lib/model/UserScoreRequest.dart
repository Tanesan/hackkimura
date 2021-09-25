class UserScoreRequest {
  var className;
  var userName;

  UserScoreRequest({var className, var userName}) {
    className = this.className;
    userName = this.userName;
  }

  Map<String, dynamic> toJson() =>
      {'className': className, 'userName': userName};
}
