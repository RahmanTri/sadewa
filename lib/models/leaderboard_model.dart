class Leaderboard {
  final int rank;
  final String namaLengkap;
  final int totalPoin;
  final int topStreak;
  final int totalTelat;

  Leaderboard({
    required this.rank,
    required this.namaLengkap,
    required this.totalPoin,
    required this.topStreak,
    required this.totalTelat,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      rank: json['rank'],
      namaLengkap: json['nama_lengkap'],
      totalPoin: json['total_poin'],
      topStreak: json['top_streak'],
      totalTelat: json['total_telat'],
    );
  }
}
