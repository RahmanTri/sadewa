import 'dart:ffi';

class Leaderboard {
  final int rank;
  final String namaLengkap;
  final String profilePict;
  final int totalPoin;
  final String onTimePercent;
  final int totalTelat;

  Leaderboard({
    required this.rank,
    required this.namaLengkap,
    required this.profilePict,
    required this.totalPoin,
    required this.onTimePercent,
    required this.totalTelat,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      rank: json['rank'],
      namaLengkap: json['nama_lengkap'],
      profilePict:
          json['foto_profil'] == null ||
              json['foto_profil'] == 'null' ||
              json['foto_profil'] == ''
          ? ""
          : json['foto_profil'],
      totalPoin: json['total_poin'],
      onTimePercent: json['ontimePercent'],
      totalTelat: json['total_telat'],
    );
  }
}
