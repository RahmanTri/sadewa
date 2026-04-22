import 'dart:ffi';

class User {
  final String id;
  final String username;
  final String email;
  final String idPerusahaan;
  final String nama;
  final String noHp;
  final String fotoProfile;
  final bool statusMasuk;
  final bool statusKeluar;
  final String namaDivisi;
  final String poin;
  final String positiveStreak;
  final String negativeStreak;

  final Float faceData;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.idPerusahaan,
    required this.nama,
    required this.noHp,
    required this.fotoProfile,
    required this.statusMasuk,
    required this.statusKeluar,
    required this.namaDivisi,
    required this.poin,
    required this.positiveStreak,
    required this.negativeStreak,
    required this.faceData,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      idPerusahaan: json['idPerusahaan'],
      nama: json['nama'],
      noHp: json['noHp'],
      fotoProfile: json['fotoProfile'],
      statusMasuk: json['statusMasuk'],
      statusKeluar: json['statusKeluar'],
      namaDivisi: json[''],
      poin: json['poin'],
      positiveStreak: json['positiveStreak'],
      negativeStreak: json['negativeStreak'],
      faceData: json['faceData'],
    );
  }
}
