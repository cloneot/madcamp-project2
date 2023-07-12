class Histories {
  final int id;
  final String owner;
  final String player2;
  final String player3;
  final String player4;
  final int winnerIndex;

  Histories({
    required this.id,
    required this.owner,
    required this.player2,
    required this.player3,
    required this.player4,
    required this.winnerIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner': owner,
      'player2': player2,
      'player3': player3,
      'player4': player4,
      'winner_index': winnerIndex,
    };
  }

  factory Histories.fromMap(Map<String, dynamic> map) {
    return Histories(
      id: map['id'] as int,
      owner: map['owner'] ?? 'no_owner',
      player2: map['player2'] ?? 'no_player2',
      player3: map['player3'] ?? 'no_player3',
      player4: map['player4'] ?? 'no_player4',
      winnerIndex: map['winner_index'] as int,
    );
  }

  Histories copyWith({
    int? id,
    String? owner,
    String? player2,
    String? player3,
    String? player4,
    int? winnerIndex,
  }) {
    return Histories(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      player2: player2 ?? this.player2,
      player3: player3 ?? this.player3,
      player4: player4 ?? this.player4,
      winnerIndex: winnerIndex ?? this.winnerIndex,
    );
  }
}
