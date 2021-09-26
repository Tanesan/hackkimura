class Request {
  var className;
  var userName;
  var data;

  Request({var className, var userName, var data}) {
    this.className = className;
    this.userName = userName;
    this.data = data;
  }

  Map<String, dynamic> toJson() =>
      {'className': className, 'userName': userName, 'data': data};
}
