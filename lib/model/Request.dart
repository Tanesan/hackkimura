class Request {
  var uuid;
  var className;
  var userName;
  var t;
  var ddx;
  var ddy;
  var ddz;
  var timestamp;

  Request({this.uuid, this.className, this.userName, this.t, this.ddx, this.ddy, this.ddz, this.timestamp});

  Map<String, dynamic> toJson() =>
      {'uuid': uuid, 'user_name': userName, 'class_name': className, 'className': className, 'userName': userName, 't': t, 'ddx': ddx, 'ddy': ddy, 'ddz': ddz, 'timestamp': timestamp};
}
