class Users {
  final int id;
  final String username;
  final String description;
  final int totalGames;
  final int wins;
  final int losses;
  final int draws;

  Users({
    required this.id,
    required this.username,
    required this.description,
    required this.totalGames,
    required this.wins,
    required this.losses,
    required this.draws,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'description': description,
      'total_games': totalGames,
      'wins': wins,
      'losses': losses,
      'draws': draws,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] as int,
      username: map['username'] ?? '',
      description: map['description'] ?? '',
      totalGames: map['total_games'] as int ?? 0,
      wins: map['wins'] as int ?? 0,
      losses: map['losses'] as int ?? 0,
      draws: map['draws'] as int ?? 0,
    );
  }

  Users copyWith({
    int? id,
    String? username,
    String? description,
    int? totalGames,
    int? wins,
    int? losses,
    int? draws,
  }) {
    return Users(
      id: id ?? this.id,
      username: username ?? this.username,
      description: description ?? this.description,
      totalGames: totalGames ?? this.totalGames,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      draws: draws ?? this.draws,
    );
  }
}
