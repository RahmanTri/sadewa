import 'dart:ffi';

class User {
  final int userId;
  final String username;
  final String email;
  final String role;
  // final String token;
  final String idPerusahaan;
  final int idDivisi;
  final String namaDivisi;
  final String namaLengkap;
  final String noTelp;
  List<double> dataWajah;
  final String fotoProfil;
  final int poin;
  final bool loggedIn;
  final bool loggedOut;
  
  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.role,
    // required this.token,
    required this.idPerusahaan,
    required this.idDivisi,
    required this.namaDivisi,
    required this.namaLengkap,
    required this.noTelp,
    required this.dataWajah,
    required this.fotoProfil,
    required this.poin,
    required this.loggedIn,
    required this.loggedOut
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'].toInt(),
      username: json['username'],
      email: json['email'],
      role: json['role'],
      // token: json['token'],
      idPerusahaan: json['id_perusahaan'],
      idDivisi: json['id_divisi'].toInt(),
      namaDivisi: json['nama_divisi'],
      namaLengkap: json['nama_lengkap'],
      noTelp: json['no_telp'],
      dataWajah: (json['data_wajah'] as List).map((e) => (e as num).toDouble()).toList(),
      fotoProfil: json['foto_profil'] ?? "",
      poin: json['poin'].toInt(),
      loggedIn: (json['logged_in'] as int) == 1,
      loggedOut: (json['logged_out'] as int) == 1,
    );
  }
}