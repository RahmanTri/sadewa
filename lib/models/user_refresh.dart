class UserRefresh {
  final String email;
  final String namaLengkap;
  final String noTelp;
  final String fotoProfil;
  final int poin;
  final bool loggedIn;
  final bool loggedOut;

  UserRefresh({
    required this.email,
    required this.namaLengkap,
    required this.noTelp,
    required this.fotoProfil,
    required this.poin,
    required this.loggedIn,
    required this.loggedOut,
  });

  factory UserRefresh.fromJson(Map<String, dynamic> json) {
    return UserRefresh(
      email: json['email'],
      namaLengkap: json['nama_lengkap'],
      noTelp: json['no_telp'],
      fotoProfil: json['foto_profil'] ?? "",
      poin: json['poin'].toInt(),
      loggedIn: (json['logged_in'] as int) == 1,
      loggedOut: (json['logged_out'] as int) == 1,
    );
  }
}
