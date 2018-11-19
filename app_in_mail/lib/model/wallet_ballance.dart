class WalletBallance {
  String eurId;
  String eurBallance;

  String antId;
  String antBallance;

  WalletBallance({this.eurId, this.eurBallance, this.antId, this.antBallance});

  factory WalletBallance.fromJson(Map<dynamic, dynamic> map) {
    return WalletBallance(
      eurId: (map['EUR'] as List)[0],
      eurBallance:(map['EUR'] as List)[1],
      antId:(map['EUR'] as List)[0],
      antBallance:(map['EUR'] as List)[1],      
    );
  }
}
