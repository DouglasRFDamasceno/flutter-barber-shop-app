class UserRole {
  final String role;

  UserRole({required this.role});

  factory UserRole.fromMap(Map<String, dynamic> map) {
    return UserRole(
      role: map['role'] ?? 'user',
    );
  }
}
