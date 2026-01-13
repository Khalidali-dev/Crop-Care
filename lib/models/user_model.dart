class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final bool isApproved;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.isApproved = true,
  });

  bool get isAdmin => role == 'admin';
  bool get isEmployee => role == 'employee';

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      role: map['role'],
      isApproved: map['isApproved'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'isApproved': isApproved,
    };
  }
}
