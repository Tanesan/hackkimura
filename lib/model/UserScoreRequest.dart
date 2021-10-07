class UserScoreRequest {
  var uuid;
  var userName;

  UserScoreRequest({this.uuid, this.userName});

  Map<String, dynamic> toJson() =>
      {'uuid': uuid, 'user_name': userName, 'userName': userName, 'name': userName};
}
