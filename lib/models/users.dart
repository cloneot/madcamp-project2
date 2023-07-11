class Users {
  final int id;
  final String username;
  final String description;
  final int wins;
  final int totalGames;

  Users({
    required this.id,
    required this.username,
    required this.description,
    required this.wins,
    required this.totalGames,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'description': description,
      'wins': wins,
      'total_games': totalGames,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] as int,
      username: map['username'] ?? '',
      description: map['description'] ?? '',
      wins: map['wins'] as int,
      totalGames: map['total_games'] as int,
    );
  }

  Users copyWith({
    int? id,
    String? username,
    String? description,
    int? wins,
    int? totalGames,
  }) {
    return Users(
      id: id ?? this.id,
      username: username ?? this.username,
      description: description ?? this.description,
      wins: wins ?? this.wins,
      totalGames: totalGames ?? this.totalGames,
    );
  }
}
