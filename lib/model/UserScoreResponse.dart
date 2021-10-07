class UserScoreResponse {
  var rank;
  var bestScore;
  var numberOfTrainings;
  var scoreHistory;
  var scoreRate;

  UserScoreResponse(
      {this.bestScore, this.numberOfTrainings, this.scoreHistory, this.scoreRate});

  factory UserScoreResponse.fromJson(Map<String, dynamic> json) {
    final scoreHistory = json['score_history'];
    final length = scoreHistory.length;
    final rate = length > 1 ? 100 * scoreHistory[length - 1] / scoreHistory[length - 2] : 0;
    return UserScoreResponse(
        bestScore: json['score'],
        numberOfTrainings: json['number_of_trainings'],
        scoreHistory: json['score_history'],
        scoreRate: rate);
  }
}
