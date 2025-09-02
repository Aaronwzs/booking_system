class ProfileModel {

final String? id;
final String authUserId;
final String fullName;
final int? role;
final int status;
final int age;
final int phone;

ProfileModel({
     this.id,
    required this.authUserId,
    required this.fullName,
    required this.age,
    this.role,
    required this.status,
    required this.phone,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id']?.toString(),
      authUserId: map['auth_user_id'],
      fullName: map['full_name'],
      age: map['age'],
      role: map['role'], 
      status: map['status'],
      phone: map['phone'],
    );
  }

   Map<String, dynamic> toMap() {
    return {
      'auth_user_id': authUserId,
      'full_name': fullName,
      'age': age,
      'role': role,
      'status': status,
      'phone': phone,
    };
  }
}