class Player {
  final String nickName;
  //final String socketId;
  final double points;
  //final String playerType;
  Player({
    required this.nickName,
    //required this.socketId,
    required this.points,
    //required this.playerType,
});

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickName,
      //'socketID': socketId,
      'points': points,
      //'playerType': playerType,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickName: map['nickName'] ?? '',
      //socketId: map['socketId'] ?? '',
      points: map['points']?.toDouble() ?? 0.0,
      //playerType: map['playerType'] ?? '',
    );
  }

  Player copyWith({
    String? nickName,
    //String? socketId,
    double? points,
    //String? playerType,
  }) {
    return Player(
      nickName: nickName ?? this.nickName,
      //socketId: socketId ?? this.socketId,
      points: points ?? this.points,
      //playerType: playerType ?? this.playerType,
    );
  }
}