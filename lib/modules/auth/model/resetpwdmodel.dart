class Resetpwdmodel {

  final String token;
  final bool isUsed;
  final DateTime expiresAt;

  Resetpwdmodel({
    required this.token,
    required this.isUsed,
    required this.expiresAt,
  });

  factory Resetpwdmodel.fromMap(Map<String, dynamic> map) {
    return Resetpwdmodel(
      token: map['prt_token'],
      isUsed: map['is_used'],
      expiresAt: DateTime.parse(map['expires_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'prt_token': token,
      'is_used': isUsed,
      'expires_at': expiresAt.toIso8601String(),
    };
  }
}