class UserScoreRequest {
  var uuid;
  var className;
  var userName;

  UserScoreRequest({this.uuid, this.className, this.userName});

  Map<String, dynamic> toJson() =>
      {'uuid': uuid, 'user_name': userName, 'class_name': className, 'className': className, 'userName': userName};
}
