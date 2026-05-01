class Admin {
  final int id;
  String name;
  String email;
  String role;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      name: json['username'],
      email: json['email'],
      role: json['role'],
    );
  }
}