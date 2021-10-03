class AEDResponse {
  var latitude;
  var longitude;

  AEDResponse({this.latitude, this.longitude});

  factory AEDResponse.fromJson(Map<String, dynamic> json) {
    return AEDResponse(
        latitude: json['Latitude'], longitude: json['Longitude']);
  }
}
