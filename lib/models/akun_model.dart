class Akun {
  final int id;
  String email;
  String username;
  String role;

  Akun({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
  });

  factory Akun.fromJson(Map<String, dynamic> json) {
    return Akun(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      role: json['role'],
    );
  }
}