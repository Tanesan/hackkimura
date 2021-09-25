class UserScoreResponse {
  var rank;
  var bestScore;

  UserScoreResponse({this.rank, this.bestScore});

  factory UserScoreResponse.fromJson(Map<String, dynamic> json) {
    return UserScoreResponse(rank: json['rank'], bestScore: json['score']);
  }
}
