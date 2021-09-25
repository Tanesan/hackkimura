class ApiResults {
  var average;
  var rank;
  var topFiveUsers;
  var topFiveScores;

  ApiResults({this.average, this.rank, this.topFiveUsers, this.topFiveScores});

  factory ApiResults.fromJson(Map<String, dynamic> json) {
    return ApiResults(
        average: json['average'],
        rank: json['rank'],
        topFiveUsers: json['topFive']['userName'],
        topFiveScores: json['topFive']['score']);
  }
}
