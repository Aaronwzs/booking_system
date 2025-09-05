class AuthUserModel {
  final String id;
  final String? email;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? password; 

  AuthUserModel({
    required this.id,
    this.email,
    required this.createdAt,
    this.updatedAt,
    this.password,
  });

  factory AuthUserModel.fromMap(Map<String, dynamic> map) {
    return AuthUserModel(
      id: map['id'],
      email: map['email'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'password': password,
    };
  }

  AuthUserModel copyWith({
    String? id,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? password, 
  }) {
    return AuthUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      password: password ?? this.password,  
    );
  }
}

class userEmail{
  final String email;
  userEmail(this.email);
}