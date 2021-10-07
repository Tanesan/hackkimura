class ClassScoreRequest {
  var uuid;
  var userName;
  var className;

  ClassScoreRequest({this.uuid, this.userName, this.className});

  Map<String, dynamic> toJson() =>
      {'uuid': uuid, 'userName': userName, 'user_name': userName, 'className': className, 'class_name': className};
}
