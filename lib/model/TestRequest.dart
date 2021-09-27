class TestRequest {
  var userName;
  var t;
  var ddx;
  var ddy;
  var ddz;
  var timestamp;

  TestRequest({this.userName, this.t, this.ddx, this.ddy, this.ddz, this.timestamp});

  Map<String, dynamic> toJson() =>
      {'userName': userName, 't': t, 'ddx': ddx, 'ddy': ddy, 'ddz': ddz, 'timestamp': timestamp};
}
