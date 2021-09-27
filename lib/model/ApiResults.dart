class ApiResults {
  var score;
  var average;
  var rank;
  var topFiveUsers;
  var topFiveScores;

  ApiResults(
      {this.score,
      this.average,
      this.rank,
      this.topFiveUsers,
      this.topFiveScores});

  factory ApiResults.fromJson(Map<String, dynamic> json) {
    return ApiResults(
        score: json['score'],
        average: json['average'],
        rank: json['rank'],
        topFiveUsers: json['result']['userName'],
        topFiveScores: json['result']['score']);
  }
}
