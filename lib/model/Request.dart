class Request {
  var className;
  var userName;
  var score;

  Request({var className, var userName, var score}) {
    className = this.className;
    userName = this.userName;
    score = this.score;
  }

  Map<String, dynamic> toJson() =>
      {'className': className, 'userName': userName, 'score': score};
}
